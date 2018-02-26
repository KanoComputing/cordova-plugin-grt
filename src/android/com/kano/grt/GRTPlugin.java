package com.kano.grt;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.LOG;

import java.nio.ByteBuffer;
import java.math.BigDecimal;

import org.json.JSONArray;
import org.json.JSONException;

import com.kano.grt.TimeSeriesClassificationData;

import com.kano.grt.GRTAction;
import com.kano.grt.TSCDWrapper;
import com.kano.grt.DTWWrapper;
import com.kano.grt.HMMWrapper;
import com.kano.grt.KMeansQuantizerWrapper;

@SuppressWarnings("unchecked")

public class GRTPlugin extends CordovaPlugin {

    private TSCDWrapper tscdWrapper;
    private DTWWrapper dtwWrapper;
    private HMMWrapper hmmWrapper;
    private KMeansQuantizerWrapper kMeansQuantizerWrapper;

    static {
        System.loadLibrary("GRT");
    }

    public GRTPlugin() {
        tscdWrapper = new TSCDWrapper();
        dtwWrapper = new DTWWrapper();
        hmmWrapper = new HMMWrapper();
        kMeansQuantizerWrapper = new KMeansQuantizerWrapper();
    }

    //Actions
    @Override
    public boolean execute(String action, final JSONArray args, final CallbackContext callbackContext) throws JSONException {
        return executeTimeSeriesClassificationDataAction(action, args, callbackContext)
                || executeDTWAction(action, args, callbackContext)
                || executeHMMAction(action, args, callbackContext)
                || executeKMeansQuantizerAction(action, args, callbackContext);
    }
     
    private boolean executeTimeSeriesClassificationDataAction(String action, final JSONArray args, final CallbackContext callbackContext) throws JSONException {
        if (GRTAction.CREATE_TSCD.toString().equals(action)) {
            String id = tscdWrapper.create();
            callbackContext.success(id);
            return true;
        } else if (GRTAction.TSCD_SET_INFO_TEXT.toString().equals(action)) {
            tscdWrapper.setInfoText(args.getString(0), args.getString(1));
            callbackContext.success();
            return true;
        } else if (GRTAction.TSCD_GET_INFO_TEXT.toString().equals(action)) {
            String infoText = tscdWrapper.getInfoText(args.getString(0));
            callbackContext.success(infoText);
            return true;
        } else if (GRTAction.TSCD_SET_DATASET_NAME.toString().equals(action)) {
            tscdWrapper.setDatasetName(args.getString(0), args.getString(1));
            callbackContext.success();
            return true;
        } else if (GRTAction.TSCD_GET_DATASET_NAME.toString().equals(action)) {
            String name = tscdWrapper.getDatasetName(args.getString(0));
            callbackContext.success(name);
            return true;
        } else if (GRTAction.TSCD_SET_NUM_DIMENSIONS.toString().equals(action)) {
            boolean result = tscdWrapper.setNumDimensions(args.getString(0), args.getLong(1));
            if (result) {
                callbackContext.success();
            } else {
                callbackContext.error(0);
            }
            return true;
        } else if (GRTAction.TSCD_GET_NUM_DIMENSIONS.toString().equals(action)) {
            long n = tscdWrapper.getNumDimensions(args.getString(0));
            callbackContext.success((int) n);
            return true;
        } else if (GRTAction.TSCD_ADD_SAMPLE.toString().equals(action)) {
            String id = args.getString(0);
            int label = args.getInt(1);
            JSONArray data = args.getJSONArray(2);
            JSONArray item;
            double[][] matrix = new double[data.length()][];
            for (int i = 0; i < data.length(); i++) {
                item = data.getJSONArray(i);
                double[] row = new double[item.length()];
                for (int j = 0; j < item.length(); j++) {
                    row[j] = item.getDouble(j);
                }
                matrix[i] = row;
            }
            tscdWrapper.addSample(id, label, matrix);
            callbackContext.success();
            return true;
        } else if (GRTAction.TSCD_GET_NUM_SAMPLES.toString().equals(action)) {
            long n = tscdWrapper.getNumSamples(args.getString(0));
            callbackContext.success((int) n);
            return true;
        }
        return false;
    }

    private boolean executeDTWAction(String action, final JSONArray args, final CallbackContext callbackContext) throws JSONException {
        if (GRTAction.CREATE_DTW.toString().equals(action)) {
            String id = dtwWrapper.create();
            callbackContext.success(id);
            return true;
        } else if (GRTAction.DTW_TRAIN.toString().equals(action)) {
            TimeSeriesClassificationData t = tscdWrapper.getFromId(args.getString(1));
            boolean result = dtwWrapper.train(args.getString(0), t);
            callbackContext.success(result ? 1 : 0);
            return true;
        } else if (GRTAction.DTW_PREDICT.toString().equals(action)) {
            JSONArray data = args.getJSONArray(1);
            JSONArray item;
            double[][] matrix = new double[data.length()][];
            for (int i = 0; i < data.length(); i++) {
                item = data.getJSONArray(i);
                double[] row = new double[item.length()];
                for (int j = 0; j < item.length(); j++) {
                    row[j] = item.getDouble(j);
                }
                matrix[i] = row;
            }
            boolean result = dtwWrapper.predict(args.getString(0), matrix);
            callbackContext.success(result ? 1 : 0);
            return true;
        } else if (GRTAction.DTW_GET_MAXIMUM_LIKELIHOOD.toString().equals(action)) {
            double result = dtwWrapper.getMaximumLikelihood(args.getString(0));
            byte[] bytes = new byte[8];
            ByteBuffer.wrap(bytes).putDouble(result);
            callbackContext.success(bytes);
            return true;
        } else if (GRTAction.DTW_GET_PREDICTED_CLASS_LABEL.toString().equals(action)) {
            int result = dtwWrapper.getPredictedClassLabel(args.getString(0));
            callbackContext.success(result);
            return true;
        }
        return false;
    }

    private boolean executeKMeansQuantizerAction(String action, final JSONArray args, final CallbackContext callbackContext) throws JSONException {
        if (GRTAction.CREATE_K_MEANS_QUANTIZER.toString().equals(action)) {
            String id = kMeansQuantizerWrapper.create();
            callbackContext.success(id);
            return true;
        } else if (GRTAction.KMQ_TRAIN.toString().equals(action)) {
            TimeSeriesClassificationData t = tscdWrapper.getFromId(args.getString(1));
            boolean result = kMeansQuantizerWrapper.train(args.getString(0), t);
            callbackContext.success(result ? 1 : 0);
            return true;
        } else if (GRTAction.KMQ_SET_NUM_CLUSTERS.toString().equals(action)) {
            boolean result = kMeansQuantizerWrapper.setNumClusters(args.getString(0), args.getInt(1));
            callbackContext.success(result ? 1 : 0);
            return true;
        } else if (GRTAction.KMQ_QUANTIZE.toString().equals(action)) {
            JSONArray data = args.getJSONArray(1);
            double[] sample = new double[data.length()];
                for (int i = 0; i < data.length(); i++) {
                    sample[i] = data.getDouble(i);
                }
            int result = kMeansQuantizerWrapper.quantize(args.getString(0), sample);
            callbackContext.success(result);
            return true;
        } else if (GRTAction.KMQ_GET_FEATURE_VECTOR.toString().equals(action)) {
            double[] result = kMeansQuantizerWrapper.getFeatureVector(args.getString(0));
            JSONArray jsonResult = new JSONArray();
            for (int i = 0; i < result.length; i++) {
                jsonResult.put(result[i]);
            }
            callbackContext.success(jsonResult);
            return true;
        } else if (GRTAction.KMQ_CLEAR.toString().equals(action)) {
            boolean result = kMeansQuantizerWrapper.clear(args.getString(0));
            callbackContext.success(result ? 1 : 0);
            return true;
        }
        return false;
    }

    private boolean executeHMMAction(String action, final JSONArray args, final CallbackContext callbackContext) throws JSONException {
        if (GRTAction.CREATE_HMM.toString().equals(action)) {
            String id = hmmWrapper.create();
            callbackContext.success(id);
            return true;
        } else if (GRTAction.HMM_TRAIN.toString().equals(action)) {
            TimeSeriesClassificationData t = tscdWrapper.getFromId(args.getString(1));
            boolean result = hmmWrapper.train(args.getString(0), t);
            callbackContext.success(result ? 1 : 0);
            return true;
        } else if (GRTAction.HMM_PREDICT.toString().equals(action)) {
            JSONArray data = args.getJSONArray(1);
            JSONArray item;
            double[][] matrix = new double[data.length()][];
            for (int i = 0; i < data.length(); i++) {
                item = data.getJSONArray(i);
                double[] row = new double[item.length()];
                for (int j = 0; j < item.length(); j++) {
                    row[j] = item.getDouble(j);
                }
                matrix[i] = row;
            }
            boolean result = hmmWrapper.predict(args.getString(0), matrix);
            callbackContext.success(result ? 1 : 0);
            return true;
        } else if (GRTAction.HMM_GET_CLASS_LIKELIHOODS.toString().equals(action)) {
            double[] result = hmmWrapper.getClassLikelihoods(args.getString(0));
            JSONArray jsonResult = new JSONArray();
            for (int i = 0; i < result.length; i++) {
                LOG.w("DRFHUISJFGIUSDHFGHBDS", Double.toString(result[i]));
                jsonResult.put(result[i]);
            }
            callbackContext.success(jsonResult);
            return true;
        } else if (GRTAction.HMM_GET_PREDICTED_CLASS_LABEL.toString().equals(action)) {
            int result = hmmWrapper.getPredictedClassLabel(args.getString(0));
            callbackContext.success(result);
            return true;
        } else if (GRTAction.HMM_SET_HMM_TYPE.toString().equals(action)) {
            boolean result = hmmWrapper.setHMMType(args.getString(0), args.getInt(1));
            callbackContext.success(result ? 1 : 0);
            return true;
        } else if (GRTAction.HMM_SET_NUM_STATES.toString().equals(action)) {
            boolean result = hmmWrapper.setNumStates(args.getString(0), args.getInt(1));
            callbackContext.success(result ? 1 : 0);
            return true;
        } else if (GRTAction.HMM_SET_NUM_SYMBOLS.toString().equals(action)) {
            boolean result = hmmWrapper.setNumSymbols(args.getString(0), args.getInt(1));
            callbackContext.success(result ? 1 : 0);
            return true;
        } else if (GRTAction.HMM_SET_MODEL_TYPE.toString().equals(action)) {
            boolean result = hmmWrapper.setModelType(args.getString(0), args.getInt(1));
            callbackContext.success(result ? 1 : 0);
            return true;
        } else if (GRTAction.HMM_SET_MIN_CHANGE.toString().equals(action)) {
            boolean result = hmmWrapper.setMinChange(args.getString(0), BigDecimal.valueOf(args.getDouble(1)).floatValue());
            callbackContext.success(result ? 1 : 0);
            return true;
        } else if (GRTAction.HMM_SET_MAX_NUM_EPOCHS.toString().equals(action)) {
            boolean result = hmmWrapper.setMaxNumEpochs(args.getString(0), args.getInt(1));
            callbackContext.success(result ? 1 : 0);
            return true;
        } else if (GRTAction.HMM_SET_NUM_RANDOM_TRAINING_ITERATIONS.toString().equals(action)) {
            boolean result = hmmWrapper.setNumRandomTrainingIterations(args.getString(0), args.getInt(1));
            callbackContext.success(result ? 1 : 0);
            return true;
        }
        return false;
    }
}
