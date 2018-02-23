const pluginName = 'GRTPlugin';

class TimeSeriesClassificationData {
    constructor(id) {
        this._id = id;
    }
    setInfoText(text) {
        return new Promise((resolve, reject) => {
            window.cordova.exec(resolve, reject, pluginName, 'TimeSeriesClassificationData_setInfoText', [this._id, text]);
        });
    }
    getInfoText() {
        return new Promise((resolve, reject) => {
            window.cordova.exec(resolve, reject, pluginName, 'TimeSeriesClassificationData_getInfoText', [this._id]);
        });
    }
    setNumDimensions(n) {
        return new Promise((resolve, reject) => {
            window.cordova.exec(resolve, reject, pluginName, 'TimeSeriesClassificationData_setNumDimensions', [this._id, n]);
        });
    }
    getNumDimensions() {
        return new Promise((resolve, reject) => {
            window.cordova.exec(resolve, reject, pluginName, 'TimeSeriesClassificationData_getNumDimensions', [this._id]);
        });
    }
    getNumSamples() {
        return new Promise((resolve, reject) => {
            window.cordova.exec(resolve, reject, pluginName, 'TimeSeriesClassificationData_getNumSamples', [this._id]);
        });
    }
    addSample(label, matrix) {
        return new Promise((resolve, reject) => {
            window.cordova.exec(resolve, reject, pluginName, 'TimeSeriesClassificationData_addSample', [this._id, label, matrix]);
        });
    }
}

class DTW {
    constructor(id) {
        this._id = id;
    }
    train(sample) {
        if (!(sample instanceof TimeSeriesClassificationData)) {
            throw new Error('Sample is not of type TimeSeriesClassificationData');
        }
        return new Promise((resolve, reject) => {
            window.cordova.exec(resolve, reject, pluginName, 'DTW_train', [this._id, sample._id]);
        });
    }
    predict(vertices) {
        return new Promise((resolve, reject) => {
            window.cordova.exec(resolve, reject, pluginName, 'DTW_predict', [this._id, vertices]);
        });
    }
    getMaximumLikelihood() {
        return new Promise((resolve, reject) => {
            window.cordova.exec(resolve, reject, pluginName, 'DTW_getMaximumLikelihood', [this._id]);
        });
    }
    getPredictedClassLabel() {
        return new Promise((resolve, reject) => {
            window.cordova.exec((byteArray) => {
                const dataView = new DataView(byteArray);
                resolve(dataView.getFloat64());
            }, reject, pluginName, 'DTW_getPredictedClassLabel', [this._id]);
        });
    }
}

class KMeansQuantizer {
    constructor(id) {
        this._id = id;
    }
}

class HMM {
    constructor(id) {
        this._id = id;
    }
    train(sample) {
        if (!(sample instanceof TimeSeriesClassificationData)) {
            throw new Error('Sample is not of type TimeSeriesClassificationData');
        }
        return new Promise((resolve, reject) => {
            window.cordova.exec(resolve, reject, pluginName, 'HMM_train', [this._id, sample._id]);
        });
    }
    predict(vertices) {
        return new Promise((resolve, reject) => {
            window.cordova.exec(resolve, reject, pluginName, 'HMM_predict', [this._id, vertices]);
        });
    }
    getMaximumLikelihood() {
        return new Promise((resolve, reject) => {
            window.cordova.exec(resolve, reject, pluginName, 'HMM_getMaximumLikelihood', [this._id]);
        });
    }
    getPredictedClassLabel() {
        return new Promise((resolve, reject) => {
            window.cordova.exec((byteArray) => {
                const dataView = new DataView(byteArray);
                resolve(dataView.getFloat64());
            }, reject, pluginName, 'HMM_getPredictedClassLabel', [this._id]);
        });
    }
    setHMMType(n) {
        return new Promise((resolve, reject) => {
            window.cordova.exec(resolve, reject, pluginName, 'HMM_setHMMType', [this._id, n]);
        });
    }
    setNumStates(n) {
        return new Promise((resolve, reject) => {
            window.cordova.exec(resolve, reject, pluginName, 'HMM_setNumStates', [this._id, n]);
        });
    }
    setNumSymbols(n) {
        return new Promise((resolve, reject) => {
            window.cordova.exec(resolve, reject, pluginName, 'HMM_setNumSymbols', [this._id, n]);
        });
    }
    setModelType(n) {
        return new Promise((resolve, reject) => {
            window.cordova.exec(resolve, reject, pluginName, 'HMM_setModelType', [this._id, n]);
        });
    }
    setMinChange(n) {
        return new Promise((resolve, reject) => {
            window.cordova.exec(resolve, reject, pluginName, 'HMM_setMinChange', [this._id, n]);
        });
    }
    setMaxNumEpochs(n) {
        return new Promise((resolve, reject) => {
            window.cordova.exec(resolve, reject, pluginName, 'HMM_setMaxNumEpochs', [this._id, n]);
        });
    }
    setNumRandomTrainingIterations(n) {
        return new Promise((resolve, reject) => {
            window.cordova.exec(resolve, reject, pluginName, 'HMM_setNumRandomTrainingIterations', [this._id, n]);
        });
    }
}


const grt = {
    createTimeSeriesClassificationData() {
        return new Promise((resolve, reject) => {
            window.cordova.exec((result) => {
                const t = new TimeSeriesClassificationData(result);
                resolve(t);
            }, reject, pluginName, 'createTimeSeriesClassificationData', []);
        });
    },
    createDTW() {
        return new Promise((resolve, reject) => {
            window.cordova.exec((result) => {
                const t = new DTW(result);
                resolve(t);
            }, reject, pluginName, 'createDTW', []);
        });
    },
    createKMeansQuantizer() {
        return new Promise((resolve, reject) => {
            window.cordova.exec((result) => {
                const t = new KMeansQuantizer(result);
                resolve(t);
            }, reject, pluginName, 'createKMeansQuantizer', []);
        });
    },
    createHMM() {
        return new Promise((resolve, reject) => {
            window.cordova.exec((result) => {
                const t = new HMM(result);
                resolve(t);
            }, reject, pluginName, 'createHMM', []);
        });
    },
};


module.exports = grt;
