package com.sahdeepsingh.fluttervisualizersexample;

import android.annotation.TargetApi;
import android.media.AudioManager;
import android.media.MediaPlayer;
import android.os.Build;
import android.os.Bundle;
import android.provider.MediaStore;
import android.util.Log;

import java.io.IOException;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "calls";
    MediaPlayer player;
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
      player = new MediaPlayer();
      player.setAudioStreamType(AudioManager.STREAM_MUSIC);
      try {
          player.setDataSource("https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3");
      } catch (IOException e) {
          e.printStackTrace();
      }

      player.setOnPreparedListener(new MediaPlayer.OnPreparedListener() {
          @Override
          public void onPrepared(MediaPlayer mp) {
              mp.start();
          }
      });
      new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
              new MethodChannel.MethodCallHandler() {
                  @TargetApi(Build.VERSION_CODES.GINGERBREAD)
                  @Override
                  public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                      if (call.method.equals("getSessionID")){
                       result.success(player.getAudioSessionId());
                      }
                      else if (call.method.equals("playSong"))
                          player.prepareAsync();
                  }
              });
  }
}
