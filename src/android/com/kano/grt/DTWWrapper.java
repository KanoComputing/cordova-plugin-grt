package com.kano.grt;

import java.util.UUID;
import java.util.Map;
import java.util.HashMap;

import com.kano.grt.DTW;
import com.kano.grt.TimeSeriesClassificationData;

public class DTWWrapper extends Wrapper<DTW> {
    static {
        System.loadLibrary("GRT");
    }

    public boolean train(String id, TimeSeriesClassificationData sample) {
        DTW dtw = getFromId(id);
        if (dtw != null) {
            return dtw.train(sample);
        }
        return false;
    }

    public boolean predict(String id, double[][] sample) {
        DTW dtw = getFromId(id);
        if (dtw != null) {
            return dtw.predict(sample);
        }
        return false;
    }

    public int getPredictedClassLabel(String id) {
        DTW dtw = getFromId(id);
        if (dtw != null) {
            return dtw.getPredictedClassLabel();
        }
        return -1;
    }

    public double getMaximumLikelihood(String id) {
        DTW dtw = getFromId(id);
        if (dtw != null) {
            return dtw.getMaximumLikelihood();
        }
        return -1;
    }

    public DTW newInstance() {
        return new DTW();
    }
}