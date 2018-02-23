package com.kano.grt;

import java.util.UUID;
import java.util.Map;
import java.util.HashMap;
import java.util.Vector;

import com.kano.grt.TimeSeriesClassificationData;

public class TSCDWrapper extends Wrapper<TimeSeriesClassificationData> {
    static {
        System.loadLibrary("GRT");
    }

    public void setInfoText(String id, String infoText) {
        TimeSeriesClassificationData t = getFromId(id);
        if (t != null) {
            t.setInfoText(infoText);
        }
    }

    public String getInfoText(String id) {
        TimeSeriesClassificationData t = getFromId(id);
        if (t != null) {
            return t.getInfoText();
        }
        return null;
    }

    public boolean setDatasetName(String id, String name) {
        TimeSeriesClassificationData t = getFromId(id);
        if (t != null) {
            return t.setDatasetName(name);
        }
        return false;
    }

    public String getDatasetName(String id) {
        TimeSeriesClassificationData t = getFromId(id);
        if (t != null) {
            return t.getDatasetName();
        }
        return null;
    }

    public boolean setNumDimensions(String id, long n) {
        TimeSeriesClassificationData t = getFromId(id);
        if (t != null) {
            return t.setNumDimensions((int) n);
        }
        return false;
    }

    public long getNumDimensions(String id) {
        TimeSeriesClassificationData t = getFromId(id);
        if (t != null) {
            return (long) t.getNumDimensions();
        }
        return -1;
    }

    public long getNumSamples(String id) {
        TimeSeriesClassificationData t = getFromId(id);
        if (t != null) {
            return (long) t.getNumSamples();
        }
        return -1;
    }

    public boolean addSample(String id, int label, double[][] sample) {
        TimeSeriesClassificationData t = getFromId(id);
        if (t != null) {
            return t.addSample(label, sample);
        }
        return false;
    }

    public TimeSeriesClassificationData newInstance() {
        return new TimeSeriesClassificationData();
    }
}