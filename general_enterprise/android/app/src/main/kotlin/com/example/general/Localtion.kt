package com.example.general

import android.Manifest
import android.content.Context
import android.content.Context.LOCATION_SERVICE
import android.content.pm.PackageManager
import android.location.Location
import android.location.LocationManager
import android.util.Log
import androidx.core.app.ActivityCompat


class GPSUtils {

    fun GetLocation(context:Context,activity: MainActivity): MutableMap<String, Any> {
        val locMan = context.getSystemService(LOCATION_SERVICE) as LocationManager
        var location: Location? = null

        if (ActivityCompat.checkSelfPermission(context, Manifest.permission.ACCESS_FINE_LOCATION)
                != PackageManager.PERMISSION_GRANTED
                && ActivityCompat.checkSelfPermission(context, Manifest.permission.ACCESS_COARSE_LOCATION)
                != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(activity, arrayOf(Manifest.permission.ACCESS_FINE_LOCATION,Manifest.permission.ACCESS_COARSE_LOCATION),1)
        }else{
            val providers: List<String> = locMan.getProviders(true)

            for (provider in providers) {
                val l: Location = locMan.getLastKnownLocation(provider) ?: continue
                if (location == null || l.accuracy < location.getAccuracy()) {
                    // Found best last known location: %s", l);
                    location = l
                }
            }
//            location = locMan.getLastKnownLocation(LocationManager.GPS_PROVIDER)
//            if(location == null){
//                location = locMan.getLastKnownLocation(LocationManager.NETWORK_PROVIDER)
//            }
        }
        // Log.d("abbas",location.toString())
        return mutableMapOf("latitude" to (location?.latitude
                ?: 0), "longitude" to (location?.longitude
                ?: 0))
    }
}

