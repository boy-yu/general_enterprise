package com.example.general

import android.graphics.Bitmap
import android.util.Log
import com.flir.thermalsdk.androidsdk.image.BitmapAndroid
import com.flir.thermalsdk.image.ThermalImage
import com.flir.thermalsdk.image.ThermalValue
import com.flir.thermalsdk.image.fusion.FusionMode
import com.flir.thermalsdk.live.Camera
import com.flir.thermalsdk.live.CommunicationInterface
import com.flir.thermalsdk.live.ConnectParameters
import com.flir.thermalsdk.live.Identity
import com.flir.thermalsdk.live.connectivity.ConnectionStatusListener
import com.flir.thermalsdk.live.discovery.DiscoveryEventListener
import com.flir.thermalsdk.live.discovery.DiscoveryFactory
import com.flir.thermalsdk.live.streaming.ThermalImageStreamListener
import com.flir.thermalsdk.image.palettes.Palette;
import com.flir.thermalsdk.image.palettes.PaletteManager;
import com.flir.thermalsdk.image.ImageParameters;
import com.flir.thermalsdk.image.TemperatureUnit;
import java.io.IOException
import java.util.*

class CameraHandler {
    private val TAG = "CameraHandler"

    private var streamDataListener: StreamDataListener? = null
    interface StreamDataListener {
        fun images(dataHolder: FrameDataHolder?)
        fun images(
                msxBitmap: Bitmap?,
                dcBitmap: Bitmap?,
                minTemper: ThermalValue?,
                maxTemper: ThermalValue?
        )
    }

    var foundCameraIdentities =
        LinkedList<Identity>()
    private var camera: Camera? = null

    interface DiscoveryStatus {
        fun started()
        fun stopped()
    }

    fun CameraHandler() {}
    fun startDiscovery(
            cameraDiscoveryListener: DiscoveryEventListener?,
            discoveryStatus: DiscoveryStatus
    ) {
        DiscoveryFactory.getInstance().scan(
                cameraDiscoveryListener!!,
                CommunicationInterface.EMULATOR,
                CommunicationInterface.USB
        )
        discoveryStatus.started()
    }

    fun stopDiscovery(discoveryStatus: DiscoveryStatus) {
        DiscoveryFactory.getInstance()
            .stop(CommunicationInterface.EMULATOR, CommunicationInterface.USB)
        discoveryStatus.stopped()
    }

    @Throws(IOException::class)
    fun connect(
            identity: Identity?,
            connectionStatusListener: ConnectionStatusListener?
    ) {
        camera = Camera()
        var connectParameters = ConnectParameters()
        if(connectionStatusListener!=null && identity!=null){
            camera!!.connect(identity, connectionStatusListener, connectParameters)
        }
    }

    fun disconnect() {
        if (camera == null) {
            return
        }
        if (camera!!.isGrabbing) {
            camera!!.unsubscribeAllStreams()
        }
        camera!!.disconnect()
    }

    fun startStream(listener: StreamDataListener?) {
        streamDataListener = listener
        camera!!.subscribeStream(thermalImageStreamListener)
    }
    fun add(identity: Identity?) {
        foundCameraIdentities.add(identity!!)
    }
    operator fun get(i: Int): Identity? {
        return foundCameraIdentities[i]
    }


    fun getCameraList(): List<Identity?>? {
        return Collections.unmodifiableList(foundCameraIdentities)
    }
    fun clear() {
        foundCameraIdentities.clear()
    }
    fun getCppEmulator(): Identity? {
        for (foundCameraIdentity in foundCameraIdentities) {
            if (foundCameraIdentity.deviceId.contains("C++ Emulator")) {
                return foundCameraIdentity
            }
        }
        return null
    }
    fun getFlirOneEmulator(): Identity? {
        for (foundCameraIdentity in foundCameraIdentities) {
            if (foundCameraIdentity.deviceId.contains("EMULATED FLIR ONE")) {
                return foundCameraIdentity
            }
        }
        return null
    }
    fun getFlirOne(): Identity? {
        for (foundCameraIdentity in foundCameraIdentities) {
            val isFlirOneEmulator =
                foundCameraIdentity.deviceId.contains("EMULATED FLIR ONE")
            val isCppEmulator =
                foundCameraIdentity.deviceId.contains("C++ Emulator")
            if (!isFlirOneEmulator && !isCppEmulator) {
                return foundCameraIdentity
            }
        }
        return null
    }
    private fun withImage(
            listener: ThermalImageStreamListener,
            functionToRun: Camera.Consumer<ThermalImage>
    ) {
        camera!!.withImage(listener, functionToRun)
    }
    private val thermalImageStreamListener: ThermalImageStreamListener =
        object : ThermalImageStreamListener {
            override fun onImageReceived() {
                withImage(this, handleIncomingImage)
            }
        }

    private val handleIncomingImage: Camera.Consumer<ThermalImage> =
        object : Camera.Consumer<ThermalImage> {
            override fun accept(thermalImage: ThermalImage) {
                //Will be called on a non-ui thread,
                // extract information on the background thread and send the specific information to the UI thread
                var minTemperature = thermalImage.statistics.min.asCelsius()
                var maxTemperature = thermalImage.statistics.max.asCelsius()
                //Get a bitmap with only IR data
                var msxBitmap: Bitmap?
                run {
                    val palette: Palette = PaletteManager.getDefaultPalettes().get(0)
                    thermalImage.setPalette(palette)
                    thermalImage.getFusion()!!.setFusionMode(FusionMode.MSX)
                    val params: ImageParameters = thermalImage.getImageParameters()
                    params.setEmissivity(0.91)
                    thermalImage.getExternalSensors()

                    //                minimumValue = thermalImage.getStatistics().min.asCelsius();
//                maximumValue = thermalImage.getStatistics().max.asCelsius();
                    thermalImage.setTemperatureUnit(TemperatureUnit.CELSIUS)
                    msxBitmap = BitmapAndroid.createBitmap(thermalImage.image).bitMap
                }

                //Get a bitmap with the visual image, it might have different dimensions then the bitmap from THERMAL_ONLY
                val dcBitmap =
                    BitmapAndroid.createBitmap(thermalImage.fusion!!.photo!!).bitMap
//                Log.d(CameraHandler.TAG, "adding images to cache")
                streamDataListener!!.images(msxBitmap, dcBitmap, minTemperature, maxTemperature)
            }
        }
}




