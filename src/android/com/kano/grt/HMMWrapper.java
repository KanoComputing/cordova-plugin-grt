package com.kano.grt;

import org.apache.cordova.LOG;

import java.util.UUID;
import java.util.Map;
import java.util.HashMap;

import com.kano.grt.HMM;
import com.kano.grt.TimeSeriesClassificationData;

public class HMMWrapper extends Wrapper<HMM> {
    static {
        System.loadLibrary("GRT");
    }

    public boolean train(String id, TimeSeriesClassificationData sample) {
        HMM hmm = getFromId(id);
        if (hmm != null) {
            return hmm.train(sample);
        }
        return false;
    }

    public boolean predict(String id, double[][] sample) {
        HMM hmm = getFromId(id);
        if (hmm != null) {
            return hmm.predict(sample);
        }
        return false;
    }

    public int getPredictedClassLabel(String id) {
        HMM hmm = getFromId(id);
        if (hmm != null) {
            return hmm.getPredictedClassLabel();
        }
        return -1;
    }

    public double[] getClassLikelihoods(String id) {
        HMM hmm = getFromId(id);
        if (hmm != null) {
            return hmm.getClassLikelihoods();
        }
        return new double[0];
    }

    public boolean setHMMType(String id, int n) {
        HMM hmm = getFromId(id);
        if (hmm != null) {
            return hmm.setHMMType(n);
        }
        return false;
    }

    public boolean setNumStates(String id, int n) {
        HMM hmm = getFromId(id);
        if (hmm != null) {
            return hmm.setNumStates(n);
        }
        return false;
    }
    public boolean setNumSymbols(String id, int n) {
        HMM hmm = getFromId(id);
        if (hmm != null) {
            return hmm.setNumSymbols(n);
        }
        return false;
    }
    public boolean setModelType(String id, int n) {
        HMM hmm = getFromId(id);
        if (hmm != null) {
            return hmm.setModelType(n);
        }
        return false;
    }
    public boolean setMinChange(String id, float n) {
        HMM hmm = getFromId(id);
        if (hmm != null) {
            return hmm.setMinChange(n);
        }
        return false;
    }
    public boolean setMaxNumEpochs(String id, int n) {
        HMM hmm = getFromId(id);
        if (hmm != null) {
            return hmm.setMaxNumEpochs(n);
        }
        return false;
    }
    public boolean setNumRandomTrainingIterations(String id, int n) {
        HMM hmm = getFromId(id);
        if (hmm != null) {
            return hmm.setNumRandomTrainingIterations(n);
        }
        return false;
    }

    public HMM newInstance() {
        return new HMM();
    }
}