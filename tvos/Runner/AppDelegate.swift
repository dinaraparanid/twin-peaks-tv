import AVFoundation
import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      let controller = window?.rootViewController as! FlutterViewController

      let audioOutputChannel = FlutterMethodChannel(
        name: "com.paranid5.twin_peaks_tv/audio_output",
        binaryMessenger: controller.binaryMessenger,
      )

      audioOutputChannel.setMethodCallHandler({[weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
          switch call.method {
          case "getAudioOutputDevice":
              self?.getAudioOutputDevice(result: result)

          default:
              result(FlutterMethodNotImplemented)
          }
      })

      GeneratedPluginRegistrant.register(with: self)
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func getAudioOutputDevice(result: FlutterResult) {
      let device = AVAudioSession.sharedInstance().currentRoute.outputs.first
      let deviceName = device?.portName
      let deviceType = device?.portType.outputType

      if deviceName == nil || deviceType == nil {
          result(FlutterError(
            code: "UNAVAILABLE",
            message: "Audio output device not available",
            details: nil,
          ))
      } else {
          result(["name": deviceName, "type": deviceType])
      }
  }
}

extension AVAudioSession.Port {
    var outputType: String {
        return switch (self) {
        case AVAudioSession.Port.builtInSpeaker,
            AVAudioSession.Port.airPlay: "speaker"

        case AVAudioSession.Port.bluetoothA2DP,
            AVAudioSession.Port.bluetoothLE,
            AVAudioSession.Port.bluetoothHFP: "bluetooth"

        case AVAudioSession.Port.usbAudio: "usb"

        case AVAudioSession.Port.HDMI: "hdmi"

        case AVAudioSession.Port.headphones: "headphones"

        default: "other"
        }
    }
}
