using System.Collections.Generic;
using System.Linq;
using Tizen.Flutter.Embedding;
using Tizen.Multimedia;

namespace Runner
{
    public class App : FlutterApplication
    {
        const string channelName = "com.paranid5.twin_peaks_tv/audio_output";

        protected override void OnCreate()
        {
            base.OnCreate();

            new MethodChannel(channelName).SetMethodCallHandler(async (call) =>
            {
                if (call.Method == "getAudioOutputDevice")
                    return GetAudioOutputDevice();

                throw new MissingPluginException();
            });

            GeneratedPluginRegistrant.RegisterPlugins(this);
        }

        static void Main(string[] args)
        {
            var app = new App();
            app.Run(args);
        }

        static private Dictionary<string, string> GetAudioOutputDevice()
        {
            var device = AudioManager.GetConnectedDevices().FirstOrDefault(d =>
                d.IoDirection == AudioDeviceIoDirection.Output
            );

            if (device == null)
                return null;

            return new Dictionary<string, string>
            {
                {"name", device.Name},
                {"type", device.Type.OutputType()},
            };
        }
    }

    static class AudioTypeExtension
    {
        public static string OutputType(this AudioDeviceType type)
        {
            switch (type)
            {
                case AudioDeviceType.BuiltinSpeaker: return "speaker";
                case AudioDeviceType.AudioJack: return "bluetooth";
                case AudioDeviceType.BluetoothMedia: return "bluetooth";
                case AudioDeviceType.BluetoothVoice: return "bluetooth";
                case AudioDeviceType.Hdmi: return "hdmi";
                case AudioDeviceType.UsbAudio: return "usb";
                default: return "other";
            }
        }
    }
}
