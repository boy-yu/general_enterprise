package com.example.general

import android.graphics.Bitmap
import android.os.Bundle
import android.util.Log
import android.widget.Button
import android.widget.TextView
import android.widget.ImageView
import android.widget.Toast
import android.app.Activity
import com.flir.thermalsdk.ErrorCode
import com.flir.thermalsdk.androidsdk.ThermalSdkAndroid
import com.flir.thermalsdk.androidsdk.live.connectivity.UsbPermissionHandler
import com.flir.thermalsdk.androidsdk.live.connectivity.UsbPermissionHandler.UsbPermissionListener
import com.flir.thermalsdk.androidsdk.live.discovery.PermissionHandler
import com.flir.thermalsdk.image.ThermalValue
import com.flir.thermalsdk.live.CommunicationInterface
import com.flir.thermalsdk.live.Identity
import com.flir.thermalsdk.live.connectivity.ConnectionStatusListener
import com.flir.thermalsdk.live.discovery.DiscoveryEventListener
import com.flir.thermalsdk.log.ThermalLog.LogLevel
import java.io.IOException
import java.util.concurrent.LinkedBlockingQueue
import kotlin.math.floor
import android.content.Context
//保存图片
import android.os.Environment;
import java.io.File;
import java.io.FileOutputStream;
import android.net.Uri;
import android.content.Intent;
import android.os.Build;
import android.Manifest;
import android.content.pm.PackageManager;
import android.view.View;
import io.flutter.plugin.common.MethodChannel

class FlirOneActivity : Activity() {
    private var btn_flir_one:Button? = null
    private var btn_flir_tow:Button? = null
    private var photoImage:ImageView? = null
    private val TAG = "FlirOneActivity"
    private var permissionHandler: PermissionHandler? = null
    private var cameraHandler: CameraHandler? = null
    private var connectedIdentity: Identity? = null
    private val msxImage: ImageView? = null
    private val framesBuffer: LinkedBlockingQueue<FrameDataHolder?> =
        LinkedBlockingQueue(21)
    private val usbPermissionHandler = UsbPermissionHandler()
    private var once:Boolean = false
    private var thermalSdkAndroid:ThermalSdkAndroid?=null
    private var tvMaxTemperature:TextView? = null
    private var tvMinTemperature:TextView? = null
    private var ivSaveImage:ImageView? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_flir_one)
        photoImage = findViewById<ImageView>(R.id.photo)
        btn_flir_one= findViewById<Button>(R.id.btn_flir_one)
        btn_flir_tow = findViewById(R.id.btn_flir_tow)

        tvMaxTemperature = findViewById(R.id.tv_max_temperature)
        tvMinTemperature = findViewById(R.id.tv_min_temperature)
        ivSaveImage = findViewById(R.id.iv_save_image)
      
        //ThermalSdkAndroid has to be initiated from a Activity with the Application Context to prevent leaking Context,
        // and before ANY using any ThermalSdkAndroid functions
        //ThermalLog will show log from the Thermal SDK in standards android log framework
        // 删除之前保存热成像的文件及文件夹
        if (Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DCIM).absolutePath.toString() + "/flironeSkPic/" != null) {
            delAllFile(Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DCIM).absolutePath.toString() + "/flironeSkPic/")
            delFolder(Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DCIM).absolutePath.toString() + "/flironeSkPic/")
        }
        
        permissionHandler = PermissionHandler()
        cameraHandler = CameraHandler()
        btn_flir_tow?.visibility = View.GONE 
        btn_flir_one?.setOnClickListener {
            startDiscovery()
            btn_flir_one?.visibility = View.GONE
            btn_flir_tow?.visibility = View.VISIBLE   
        }
        btn_flir_tow?.setOnClickListener {
//            stopDiscovery()
            connect(cameraHandler!!.getFlirOne())
            btn_flir_tow?.visibility = View.GONE 
        }


        // android 6.0 以上动态获取sd卡读写权限

        if(Build.VERSION.SDK_INT >= 23){
            val REQUEST_CODE_CONTACT = 101
            val permissions = arrayOf<String>(Manifest.permission.WRITE_EXTERNAL_STORAGE)
            //验证是否许可权限
            for (str in permissions) {
                if (this.checkSelfPermission(str) != PackageManager.PERMISSION_GRANTED) {
                    //申请权限
                    this.requestPermissions(permissions, REQUEST_CODE_CONTACT);
                }
            }
        }
    }
    override fun onPause() {
        super.onPause()
        stopDiscovery()
        disconnect()       
    }



    override fun onStop() {
        super.onStop()
        finish()
    }

    interface ShowMessage {
        fun show(message: String?)
    }

    private val showMessage: ShowMessage = object : ShowMessage {
        override fun show(message: String?) {
            Toast.makeText(this@FlirOneActivity, message, Toast.LENGTH_SHORT).show()
        }
    }
    private fun startDiscovery() {
        cameraHandler!!.startDiscovery(cameraDiscoveryListener, discoveryStatusListener)
    }

    private fun stopDiscovery() {
        cameraHandler!!.stopDiscovery(discoveryStatusListener)
    }
    private val discoveryStatusListener: CameraHandler.DiscoveryStatus = object : CameraHandler.DiscoveryStatus {
        override fun started() {
            btn_flir_tow?.text = "开始扫描"
        }
        override fun stopped() {
            btn_flir_tow?.text = "停止扫描"
        }
    }

    private val cameraDiscoveryListener: DiscoveryEventListener = object : DiscoveryEventListener {
        override fun onCameraFound(identity: Identity) {
            runOnUiThread { cameraHandler!!.add(identity) }
        }
        override fun onDiscoveryError(
                communicationInterface: CommunicationInterface,
                errorCode: ErrorCode
        ) {
            runOnUiThread {
                stopDiscovery()
                showMessage.show("通信接口错误：" + "onDiscoveryError communicationInterface:$communicationInterface errorCode:$errorCode")
            }
        }
    }
    private val connectionStatusListener =
        ConnectionStatusListener { errorCode ->
//            Log.d("MainActivity.TAG", "onDisconnected errorCode:$errorCode")
            runOnUiThread {
                updateConnectionText(connectedIdentity, "连接断开") }
        }
    private fun updateConnectionText(
            identity: Identity?,
            status: String
    ) {
        val deviceId = identity?.deviceId ?: ""
        btn_flir_one!!.text = "$deviceId $status"
    }

    private val streamDataListener: CameraHandler.StreamDataListener = object : CameraHandler.StreamDataListener {
        override fun images(dataHolder: FrameDataHolder?) {
            photoImage!!.setImageBitmap(dataHolder!!.dcBitmap)
        }

        override fun images(
                msxBitmap: Bitmap?,
                dcBitmap: Bitmap?,
                minTemper: ThermalValue?,
                maxTemper: ThermalValue?
        ) {
            try {
                framesBuffer.put(FrameDataHolder(msxBitmap, dcBitmap))
            } catch (e: InterruptedException) {  
            }
           
            val poll = framesBuffer.poll()
            runOnUiThread {
                if (poll != null) {
                    photoImage!!.setImageBitmap(poll.msxBitmap)
                    val maxValue :String = String.format("%.2f", maxTemper!!.value)
                    val minValue :String = String.format("%.2f", minTemper!!.value)
                    tvMaxTemperature!!.text = maxValue
                    tvMinTemperature!!.text = minValue

                    ivSaveImage?.setOnClickListener {
                        val irPath: String = saveImageToGallery(this@FlirOneActivity, poll.msxBitmap, "IR")
                        globalResult?.success(mutableMapOf("path" to irPath,"minValue" to minValue,"maxValue" to maxValue))
                        finish()
                    }
                }
            }
        }
    }

    fun saveImageToGallery(context: Context, bmp: Bitmap?, type: String): String{
        // 首先保存图片
        val storePath: String = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DCIM).getAbsolutePath().toString() + "/flironeSkPic/"
        val appDir = File(storePath)
        if (!appDir.exists()) {
            appDir.mkdir()
        }
        val fileName = type + System.currentTimeMillis().toString() + ".jpg"
        val file = File(appDir, fileName)
        try {
            val fos = FileOutputStream(file)
            //通过io流的方式来压缩保存图片
            val isSuccess: Boolean = bmp!!.compress(Bitmap.CompressFormat.JPEG, 60, fos)
            fos.flush()
            fos.close()
            //保存图片后发送广播通知更新数据库
            val uri: Uri = Uri.fromFile(file)
            context.sendBroadcast(Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE, uri))
            if (isSuccess) return storePath + fileName
            return ""
        }catch (e: IOException){
            println("程序出现了未知异常。${e.message}")
        }
        return ""
    }

    private fun connect(identity: Identity?) {
        //We don't have to stop a discovery but it's nice to do if we have found the camera that we are looking for
        cameraHandler!!.stopDiscovery(discoveryStatusListener)
        if (connectedIdentity != null) {
            showMessage.show("一次只支持一个摄像头连接")
            return
        }
        if (identity == null) {
            showMessage.show("无法连接，没有可用的摄像头")
            return
        }
        connectedIdentity = identity
        updateConnectionText(identity, "连接")
        //IF your using "USB_DEVICE_ATTACHED" and "usb-device vendor-id" in the Android Manifest
        // you don't need to request permission, see documentation for more information
        if (UsbPermissionHandler.isFlirOne(identity)) {
            usbPermissionHandler.requestFlirOnePermisson(identity, applicationContext, permissionListener)
        } else {
        //    cameraHandler!!.connect(identity,connectionStatusListener)
            doConnect(identity)
        }
    }
    private val permissionListener: UsbPermissionListener = object : UsbPermissionListener {
        override fun permissionGranted(identity: Identity) {
            doConnect(identity)
        }

        override fun permissionDenied(identity: Identity) {
            showMessage.show("无权限拒绝访问")
        }

        override fun error(
                errorType: UsbPermissionListener.ErrorType,
                identity: Identity
        ) {
            showMessage.show("红外许可请求失败, error:$errorType identity:$identity")
        }
    }
    private fun doConnect(identity: Identity) {
                    Thread(Runnable {
                        try {
                            cameraHandler!!.connect(identity, connectionStatusListener)
                            runOnUiThread {
                                updateConnectionText(identity, "已连接")
                                cameraHandler!!.startStream(streamDataListener)
                            }
                        } catch (e: IOException) {
                            runOnUiThread {
//                                Log.d("MainActivity.TAG", "Could not connect: $e")
                                updateConnectionText(identity, "连接断开")
                            }
                        }
                    }).start()
    }
    private fun disconnect() {
        updateConnectionText(connectedIdentity, "断开连接")
        connectedIdentity = null
        Thread(Runnable {
            cameraHandler!!.disconnect()
            runOnUiThread { 
                updateConnectionText(null, "连接断开") 
            }
        }).start()
    }

    // 删除文件夹中文件
    fun delFolder(folderPath: String) {
        try {
            delAllFile(folderPath) //删除完里面所有内容
            var filePath = folderPath
            filePath = filePath
            val myFilePath = File(filePath)
            myFilePath.delete() //删除空文件夹
        } catch (e: Exception) {
            println("删除文件夹操作出错")
            e.printStackTrace()
        }
    }
    // 删除文件夹
    fun delAllFile(path: String) {
        val file = File(path)
        if (!file.exists()) {
            return
        }
        if (!file.isDirectory) {
            return
        }
        val tempList = file.list()
        var temp: File? = null
        for (i in tempList.indices) {
            temp = if (path.endsWith(File.separator)) {
                File(path + tempList[i])
            } else {
                File(path + File.separator + tempList[i])
            }
            if (temp.isFile) {
                temp.delete()
            }
            if (temp.isDirectory) {
                delAllFile(path + "/" + tempList[i]) //先删除文件夹里面的文件
                delFolder(path + "/" + tempList[i]) //再删除空文件夹
            }
        }
    }
}



