package com.sahdeepsingh.fluttervisualizers;

import android.annotation.TargetApi;
import android.media.AudioManager;
import android.media.MediaPlayer;
import android.media.audiofx.Visualizer;
import android.os.Build;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FlutterVisualizersPlugin */
public class FlutterVisualizersPlugin {
    private static final Pattern VISUALIZER_METHOD_NAME_MATCH = Pattern.compile("audiovisualizer/([^/]+)");
    private static MethodChannel visualizerChannel;

    /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
      visualizerChannel = new MethodChannel(registrar.messenger(), "fluttery_audio_visualizer");
      visualizerChannel.setMethodCallHandler(new FlutteryAudioVisualizerPlugin());
  }


  private static class FlutteryAudioVisualizerPlugin implements MethodCallHandler {

    private AudioVisualizer visualizer = new AudioVisualizer();
    @TargetApi(Build.VERSION_CODES.GINGERBREAD)
    @Override
    public void onMethodCall(MethodCall call, Result result) {

      try {
        AudioVisualizerPlayerCall playerCall = parseMethodName(call.method);
        switch (playerCall.command) {
          case "activate_visualizer":
            if (visualizer.isActive()) {
              return;
            }

            int sessionID = (int )Objects.requireNonNull(call.argument( "sessionID"));
            visualizer.activate(new Visualizer.OnDataCaptureListener() {
              @Override
              public void onWaveFormDataCapture(Visualizer visualizer, byte[] waveform, int samplingRate) {
                Map<String, Object> args = new HashMap<>();
                args.put("waveform", waveform);

                visualizerChannel.invokeMethod("onWaveformVisualization", args);
              }

              @Override
              public void onFftDataCapture(Visualizer visualizer, byte[] sharedFft, int samplingRate) {

                Map<String, Object> args = new HashMap<>();
                args.put("fft", sharedFft);

                visualizerChannel.invokeMethod("onFftVisualization", args);
              }
            },sessionID);
            break;
          case "deactivate_visualizer":
            visualizer.deactivate();
            break;
        }

        result.success(null);
      } catch (IllegalArgumentException e) {
        result.notImplemented();
      }
    }

    private AudioVisualizerPlayerCall parseMethodName(String methodName) {
      Matcher matcher = VISUALIZER_METHOD_NAME_MATCH.matcher(methodName);

      if (matcher.matches()) {
        String command = matcher.group(1);
        return new AudioVisualizerPlayerCall(command);
      } else {
        throw new IllegalArgumentException("Invalid audio visualizer message: " + methodName);
      }
    }

    private static class AudioVisualizerPlayerCall {
      public final String command;

      private AudioVisualizerPlayerCall(String command) {
        this.command = command;
      }

      @Override
      public String toString() {
        return String.format("AudioVisualizerPlayerCall - Command: %s", command);
      }
    }
  }
}
