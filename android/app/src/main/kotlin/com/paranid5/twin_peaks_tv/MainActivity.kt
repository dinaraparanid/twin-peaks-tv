package com.paranid5.twin_peaks_tv

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

    private fun getAudioOutputDevice(): String? {
        val audioManager = getSystemService(AUDIO_SERVICE) as AudioManager

        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            audioManager.communicationDevice?.productName?.toString()
        } else {
            audioManager
                .getDevices(AudioManager.GET_DEVICES_OUTPUTS)
                .asSequence()
                .filter { it.isSink }
                .map { it.productName }
                .firstOrNull()
                ?.toString()
        }
    }
}
