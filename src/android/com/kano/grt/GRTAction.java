package com.kano.grt;

public enum GRTAction {
    CREATE_TSCD("createTimeSeriesClassificationData"),
    TSCD_SET_INFO_TEXT("TimeSeriesClassificationData_setInfoText"),
    TSCD_GET_INFO_TEXT("TimeSeriesClassificationData_getInfoText"),
    TSCD_SET_NUM_DIMENSIONS("TimeSeriesClassificationData_setNumDimensions"),
    TSCD_GET_NUM_DIMENSIONS("TimeSeriesClassificationData_getNumDimensions"),
    TSCD_SET_DATASET_NAME("TimeSeriesClassificationData_setDatasetName"),
    TSCD_GET_DATASET_NAME("TimeSeriesClassificationData_getDatasetName"),
    TSCD_ADD_SAMPLE("TimeSeriesClassificationData_addSample"),
    TSCD_GET_NUM_SAMPLES("TimeSeriesClassificationData_getNumSamples"),

    CREATE_DTW("createDTW"),
    DTW_TRAIN("DTW_train"),
    DTW_PREDICT("DTW_predict"),
    DTW_GET_MAXIMUM_LIKELIHOOD("DTW_getMaximumLikelihood"),
    DTW_GET_PREDICTED_CLASS_LABEL("DTW_getPredictedClassLabel"),

    CREATE_HMM("createHMM"),
    HMM_TRAIN("HMM_train"),
    HMM_PREDICT("HMM_predict"),
    HMM_GET_CLASS_LIKELIHOODS("HMM_getClassLikelihoods"),
    HMM_GET_PREDICTED_CLASS_LABEL("HMM_getPredictedClassLabel"),
    HMM_SET_HMM_TYPE("HMM_setHMMType"),
    HMM_SET_NUM_STATES("HMM_setNumStates"),
    HMM_SET_NUM_SYMBOLS("HMM_setNumSymbols"),
    HMM_SET_MODEL_TYPE("HMM_setModelType"),
    HMM_SET_MIN_CHANGE("HMM_setMinChange"),
    HMM_SET_MAX_NUM_EPOCHS("HMM_setMaxNumEpochs"),
    HMM_SET_NUM_RANDOM_TRAINING_ITERATIONS("HMM_setNumRandomTrainingIterations"),

    CREATE_K_MEANS_QUANTIZER("createKMeansQuantizer"),
    KMQ_TRAIN("KMeansQuantizer_train"),
    KMQ_SET_NUM_CLUSTERS("KMeansQuantizer_setNumClusters"),
    KMQ_QUANTIZE("KMeansQuantizer_quantize"),
    KMQ_GET_FEATURE_VECTOR("KMeansQuantizer_getFeatureVector"),
    KMQ_CLEAR("KMeansQuantizer_clear");

    private final String text;

    /**
     * @param text
     */
    GRTAction(final String text) {
        this.text = text;
    }

    /* (non-Javadoc)
     * @see java.lang.Enum#toString()
     */
    @Override
    public String toString() {
        return text;
    }
}