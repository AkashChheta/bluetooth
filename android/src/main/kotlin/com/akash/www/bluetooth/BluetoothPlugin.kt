package com.akash.www.bluetooth

import android.Manifest
import android.bluetooth.BluetoothAdapter
import android.content.pm.PackageManager
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar


class BluetoothPlugin(var registrar: Registrar) : MethodCallHandler {
    var adapter = BluetoothAdapter.getDefaultAdapter() as BluetoothAdapter

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar): Unit {
            val channel = MethodChannel(registrar.messenger(), "bluetooth")
            var call = BluetoothPlugin(registrar)
            channel.setMethodCallHandler(call)
        }
    }

    override fun onMethodCall(call: MethodCall, result: Result): Unit {
        if (call.method.equals("on")) {
            if (!adapter.isEnabled) {
                adapter.enable()
            }
        } else if (call.method.equals("off")) {
            if (adapter.isEnabled) {
                adapter.disable()
            }
        } else if (call.method.equals("scan")) {
            if (ContextCompat.checkSelfPermission(registrar.activity(), Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
                ActivityCompat.requestPermissions(registrar.activity(), Manifest.permission.ACCESS_COARSE_LOCATION,
                        REQUEST_COARSE_LOCATION_PERMISSIONS)
                pendingCall = call
                pendingResult = result
            }
            startScan(call, result)
        } else {
            result.notImplemented()
        }
    }
}
