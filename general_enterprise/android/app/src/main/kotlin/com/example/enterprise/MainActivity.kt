package com.example.enterprise

import android.annotation.SuppressLint
import android.app.ActivityManager
import android.app.NotificationManager
import android.content.Context
import android.content.Intent
import android.content.pm.ActivityInfo
import android.content.pm.PackageManager
import android.os.Build
import android.os.Bundle
import androidx.annotation.NonNull
import com.flir.thermalsdk.androidsdk.ThermalSdkAndroid
import com.sytest.app.blemulti.BleDevice
import com.sytest.app.blemulti.Rat
import com.sytest.app.blemulti.data.B1_SampleData.SignalType.*
import com.sytest.app.blemulti.easy.Recipe
import com.sytest.app.blemulti.exception.BleException
import com.sytest.app.blemulti.interfaces.SucFail
import com.sytest.app.blemulti.interfaces.Value_CB
import io.flutter.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.Serializable


var globalResult: MethodChannel.Result? = null
var rat: Rat? = null
var fireSdk:Boolean = false

class MainActivity: FlutterActivity() {
    // 热成像
    private  val nativeView = "nativeView"
    private val FLIRONE = "FLIRONE"
    private val LOCALCHANNEL = "getLocal"
    private val CHANNEL = "getToken"
    private val messagePushChannel = "messagePushChannel"
    private val stopEventChannel = "stop"
    private var bleDevice: BleDevice? = null
    private var tkim:TuiKit = TuiKit()
    /**
     * 采集到的数据
     */
    private var displacementPeakValue = 0f //位移峰峰值
    private var envelopeEquivalentPeakValue = 0f //包络有效峰峰值
    private var speedEffectiveValue = 0f //速度有效值
    private var accelerationEquivalentPeakValue = 0f //加速度等效峰值
    private var temperatureValue = 0f //温度
    private var hotLine:Boolean = false
    private var methodCall:MethodChannel?= null 
    
    override fun onStop() {
        methodCall?.invokeMethod("stop", "send")
        super.onStop()
    }

    override fun onRestart(){
        super.onRestart()
        methodCall?.invokeMethod("reStart", "send")
    }

    override fun onDestroy() {
        tkim.destory()
        super.onDestroy()
    }
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        if(!fireSdk){
            ThermalSdkAndroid.init(applicationContext)
            fireSdk = true
        }
    }



    @SuppressLint("WrongConstant", "NewApi")
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        methodCall =  MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "stop")
        methodCall?.invokeMethod("reStart", "send")
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler(
                MethodChannel.MethodCallHandler { call, result ->
                    var tempBleDevice = bleDevice
                    when {
                        call.method.contentEquals("putBlue") -> {
                            // Log.d("mac", call.arguments.toString())
                            Rat.initilize(context)
                            Rat.getInstance().connectDevice_Normal(false, call.arguments.toString(), object : SucFail {
                                //蓝牙连接成功
                                override fun onSucceed_UI(msg: String?) {
                                    bleDevice = Rat.getInstance().firstBleDevice
                                    // 停止扫描
                                    // Rat.getInstance().stopScan()
                                    // Log.d("TPush", "${bleDevice.toString()}")
                                    result.success("success")
                                }

                                //蓝牙连接失败
                                override fun onFailed_UI(msg: String?) {
                                    result.success(msg)
                                }
                            })
                        }
                        call.method.contentEquals("disConnect") -> {
                            Rat.initilize(context)
                            Rat.getInstance().disConnAll()
                            // Rat.getInstance().disConnectDevice(tempBleDevice?.get_macAddress())
                            result.success("断开连接")
                        }
                        call.method.contentEquals("close") -> {
                            // Rat.getInstance().disConnectDevice(tempBleDevice?.get_macAddress())
                            result.success("断开连接")
                        }
                        call.method.contentEquals("getData") -> {
                            result.success(envelopeEquivalentPeakValue)
                        }
                        call.method.contentEquals("startGet") -> {
                            if (tempBleDevice != null) {
                                // getLittleMushroomEnvelopeEarthquakeValue(tempBleDevice)
                                getLittleMushroomTemperatureEarthquakeValue(tempBleDevice)
                            }
                            result.success("start")
                        }
                    }
                }
        )
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, LOCALCHANNEL).setMethodCallHandler(
                MethodChannel.MethodCallHandler { call, result ->
                    globalResult = result
                    when {
                        call.method.contentEquals("getLocal") -> {
                            val location = GPSUtils().GetLocation(context, this)
                            result.success(location)
                        }
                        call.method.contentEquals("getAppState") -> {
                            val notificationManager: NotificationManager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
                            if (getForegroundActivity()) {
                                notificationManager.cancel(call.arguments as Int)
                            }
                            result.success(getForegroundActivity())
                        }

                        call.method.contentEquals("judgePlatform") -> {
                            result.success(judgePlatform())
                        }
                    }

                }
        )
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, FLIRONE).setMethodCallHandler(
                MethodChannel.MethodCallHandler { call, result ->
                    //    var fileOneActivity:FlirOneActivity = FlirOneActivity()
                    globalResult = result
                    if (call.method.contentEquals("startFlirOne")) {
                        var intent: Intent = Intent(context, FlirOneActivity::class.java)
                        startActivity(intent)
                        // result.success("startFlirOne")
                    }
                }
        )

        //tuiKit
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, messagePushChannel).setMethodCallHandler { call, result ->

            if(call.method.contentEquals("init")){
                tkim.init(context, flutterEngine)
                result.success("successInit")
            }

            if(call.method.contentEquals("login")){
                tkim.login(call.arguments.toString(), result)
            }

            if(call.method.contentEquals("send")){
                var list:List<String> = call.arguments as List<String>
                // _list [0]  message  _list[1]  sendToPeople account
                tkim.send(list[0], list[1], result)
            }

            if(call.method.contentEquals("intoRoom")){
                tkim.intoRoom(result)
            }

            if(call.method.contentEquals("logout")){
                tkim.logout(result)
            }
        }


        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, nativeView).setMethodCallHandler{ call, result ->
            if(call.method.contentEquals("webView")){
                var _intent:Intent = Intent(this, WebH5::class.java)
                val data = call.arguments as MutableMap<*, *>

                _intent.putExtra("url", data["url"] as String)
                _intent.putExtra("title", data["title"] as String)
                startActivity(_intent)
                result.success("invoke webView success")
            }
        }
    }

    /**
     * 同时获取包络震值
     * z: Float 实时获取的值
     * envelopeEquivalentPeakValue： 本次采集获取的峰值
     */
    private fun getLittleMushroomEnvelopeEarthquakeValue(bleDevice: BleDevice) {
        Recipe.newInstance(bleDevice) // 包络信号类型  B1_SampleData.SignalType.ENVELOPE
                .getValue_Z(ENVELOPE, true, object : Value_CB {
                    override fun onValue_UI(x: Float, y: Float, z: Float) {
                        // envelopeEquivalentPeakValue = Recipe.Cal_CharacterValue(Recipe.TYPE_PeakPeak, DISPLACEMENT, z)
                        // envelopeEquivalentPeakValue = z
                        Log.d("envelopeEquivalentPeakValue", envelopeEquivalentPeakValue.toString())
                    }

                    override fun onFail_UI(p0: BleException) {
                    }
                })
    }

    /**
     * 同时获取位移震值
     */
    private fun getLittleMushroomDisplacementEarthquakeValue(bleDevice: BleDevice) {
        Recipe.newInstance(bleDevice) // 位移信号类型  B1_SampleData.SignalType.DISPLACEMENT
                .getValue_Z(DISPLACEMENT, true, object : Value_CB {
                    override fun onValue_UI(x: Float, y: Float, z: Float) {
                        displacementPeakValue = Recipe.Cal_CharacterValue(Recipe.TYPE_PeakPeak, DISPLACEMENT, z)
                    }

                    override fun onFail_UI(p0: BleException) {
                        TODO("Not yet implemented")
                    }
                })
    }

    /**
     * 同时获取速度震值
     */
    private fun getLittleMushroomSpeedEarthquakeValue(bleDevice: BleDevice) {
        Recipe.newInstance(bleDevice) // 速度信号类型  B1_SampleData.SignalType.VELOCITY
                .getValue_Z(VELOCITY, true, object : Value_CB {
                    override fun onValue_UI(x: Float, y: Float, z: Float) {
                        speedEffectiveValue = Recipe.Cal_CharacterValue(Recipe.TYPE_Virtual, VELOCITY, z)
                    }

                    override fun onFail_UI(p0: BleException) {
                    }
                })
    }

    /**
     * 同时获取加速度震值
     */
    private fun getLittleMushroomAccelerationEarthquakeValue(bleDevice: BleDevice) {
        Recipe.newInstance(bleDevice) // 速度信号类型  B1_SampleData.SignalType.ACCELERATION
                .getValue_Z(ACCELERATION, true, object : Value_CB {
                    override fun onValue_UI(x: Float, y: Float, z: Float) {
                        accelerationEquivalentPeakValue = Recipe.Cal_CharacterValue(Recipe.TYPE_Peak, ACCELERATION, z)
                    }

                    override fun onFail_UI(p0: BleException) {
                    }
                })
    }

    /**
     * 同时获取温度震值
     */
    private fun getLittleMushroomTemperatureEarthquakeValue(bleDevice: BleDevice) {
        Recipe.newInstance(bleDevice) // 温度信号类型  B1_SampleData.SignalType.TEMPERATURE
                .getValue_Z(TEMPERATURE, true, object : Value_CB {
                    override fun onValue_UI(x: Float, y: Float, z: Float) {
                        // temperatureValue = z
                        envelopeEquivalentPeakValue = Recipe.Cal_CharacterValue(Recipe.TYPE_PeakPeak, DISPLACEMENT, z)
                        envelopeEquivalentPeakValue = z
                    }

                    override fun onFail_UI(p0: BleException) {
                    }
                })
    }


    /**
     *
     *
     */
    fun getForegroundActivity(): Boolean {
        val mActivityManager: ActivityManager = getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        val mRunningTask: MutableList<ActivityManager.RunningAppProcessInfo> = mActivityManager.runningAppProcesses
                ?: return false
        for (mess in mRunningTask){
            if(mess.processName == context.packageName &&(mess.importance ==
                            ActivityManager.RunningAppProcessInfo.IMPORTANCE_FOREGROUND))  {
                return true
            }
        }
        return false
    }

    fun judgePlatform() :Boolean{
        var CPUABI: String? = null
        if (Build.VERSION.SDK_INT >= 21) {
            val CPUABIS = Build.SUPPORTED_ABIS
            if (CPUABIS.isNotEmpty()) {
                CPUABI = CPUABIS[0];
            }
        }
        return CPUABI.toString() != "x86_64"
    }
}




class ListData : Serializable{

}

