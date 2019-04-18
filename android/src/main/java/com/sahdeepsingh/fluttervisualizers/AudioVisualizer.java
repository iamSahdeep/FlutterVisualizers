package com.sahdeepsingh.fluttervisualizers;

import android.media.audiofx.Visualizer;
import android.os.Build;

public class AudioVisualizer {

    public static final AudioVisualizer instance = new AudioVisualizer();

    private Visualizer visualizer;

    public boolean isActive() {
        return visualizer != null;
    }

    public void activate(Visualizer.OnDataCaptureListener listener , int sessionId) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.GINGERBREAD) {
            visualizer = new Visualizer(sessionId);
            visualizer.setCaptureSize(Visualizer.getCaptureSizeRange()[1]);
            visualizer.setDataCaptureListener(
                    listener,
                    Visualizer.getMaxCaptureRate() / 2,
                    true,
                    false
            );
            visualizer.setEnabled(true);
        }

    }

    public void deactivate() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.GINGERBREAD) {
            visualizer.release();
        }
        visualizer = null;
    }

}

