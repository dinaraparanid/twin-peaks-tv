package com.paranid5.twin_peaks_tv

import android.media.AudioDeviceInfo
import android.media.AudioManager
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

private const val CHANNEL = "com.paranid5.twin_peaks_tv/audio_output"

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getAudioOutputDevice") {
                when (val device = getAudioOutputDevice()) {
                    null -> result.error("UNAVAILABLE", "Audio output device not available", null)
                    else -> result.success(device)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getAudioOutputDevice(): Map<String, String>? {
        val audioManager = getSystemService(AUDIO_SERVICE) as AudioManager

        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            audioManager.communicationDevice?.let {
                mapOf(
                    "name" to it.productName.toString(),
                    "type" to it.outputType
                )
            }
        } else {
            audioManager
                .getDevices(AudioManager.GET_DEVICES_OUTPUTS)
                .asSequence()
                .filter { it.isSink }
                .firstNotNullOf {
                    mapOf(
                        "name" to it.productName.toString(),
                        "type" to it.outputType
                    )
                }
        }
    }
}

private val AudioDeviceInfo.outputType: String
    get() = when (type) {
        AudioDeviceInfo.TYPE_BUILTIN_SPEAKER -> "speaker"
        AudioDeviceInfo.TYPE_BLUETOOTH_A2DP, AudioDeviceInfo.TYPE_BLUETOOTH_SCO -> "bluetooth"
        AudioDeviceInfo.TYPE_USB_DEVICE -> "usb"
        AudioDeviceInfo.TYPE_HDMI,
        AudioDeviceInfo.TYPE_HDMI_ARC,
        AudioDeviceInfo.TYPE_HDMI_EARC -> "hdmi"
        AudioDeviceInfo.TYPE_USB_HEADSET,
        AudioDeviceInfo.TYPE_WIRED_HEADSET,
        AudioDeviceInfo.TYPE_WIRED_HEADPHONES -> "headphones"
        else -> "other"
    }
