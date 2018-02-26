
package com.kano.grt;

import java.util.UUID;
import java.util.Map;
import java.util.HashMap;

import com.kano.grt.KMeansQuantizer;
import com.kano.grt.TimeSeriesClassificationData;

public class KMeansQuantizerWrapper extends Wrapper<KMeansQuantizer> {
    static {
        System.loadLibrary("GRT");
    }

    public boolean setNumClusters(String id, int n) {
        KMeansQuantizer quantizer = getFromId(id);
        if (quantizer != null) {
            return quantizer.setNumClusters(n);
        }
        return false;
    }

    public boolean train(String id, TimeSeriesClassificationData sample) {
        KMeansQuantizer quantizer = getFromId(id);
        if (quantizer != null) {
            return quantizer.train(sample);
        }
        return false;
    }

    public int quantize(String id, double[] sample) {
        KMeansQuantizer quantizer = getFromId(id);
        if (quantizer != null) {
            return quantizer.quantize(sample);
        }
        return 0;
    }

    public double[] getFeatureVector(String id) {
        KMeansQuantizer quantizer = getFromId(id);
        if (quantizer != null) {
            return quantizer.getFeatureVector();
        }
        return new double[0];
    }

    public boolean clear(String id) {
        KMeansQuantizer quantizer = getFromId(id);
        if (quantizer != null) {
            return quantizer.clear();
        }
        return false;
    }

    public KMeansQuantizer newInstance() {
        return new KMeansQuantizer();
    }
}
