const pluginName = 'GRTPlugin';

function pExec(action, args) {
    return new Promise((resolve, reject) => {
        window.cordova.exec(resolve, reject, pluginName, action, args);
    });
}

class TimeSeriesClassificationData {
    constructor(id) {
        this._id = id;
    }
    setInfoText(text) {
        return pExec('TimeSeriesClassificationData_setInfoText', [this._id, text]);
    }
    getInfoText() {
        return pExec('TimeSeriesClassificationData_getInfoText', [this._id]);
    }
    setNumDimensions(n) {
        return pExec('TimeSeriesClassificationData_setNumDimensions', [this._id, n]);
    }
    getNumDimensions() {
        return pExec('TimeSeriesClassificationData_getNumDimensions', [this._id]);
    }
    getNumSamples() {
        return pExec('TimeSeriesClassificationData_getNumSamples', [this._id]);
    }
    addSample(label, matrix) {
        return pExec('TimeSeriesClassificationData_addSample', [this._id, label, matrix]);
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
        return pExec('DTW_train', [this._id, sample._id]);
    }
    predict(vertices) {
        return pExec('DTW_predict', [this._id, vertices]);
    }
    getMaximumLikelihood() {
        return pExec('DTW_getMaximumLikelihood', [this._id])
            .then((byteArray) => {
                const dataView = new DataView(byteArray);
                return dataView.getFloat64();
            });
    }
    getPredictedClassLabel() {
        return pExec('DTW_getPredictedClassLabel', [this._id]);
    }
}

class KMeansQuantizer {
    constructor(id) {
        this._id = id;
    }
    setNumClusters(n) {
        return pExec('KMeansQuantizer_setNumClusters', [this._id, n]);
    }
    train(sample) {
        if (!(sample instanceof TimeSeriesClassificationData)) {
            throw new Error('Sample is not of type TimeSeriesClassificationData');
        }
        return pExec('KMeansQuantizer_train', [this._id, sample._id]);
    }
    quantize(data) {
        return pExec('KMeansQuantizer_quantize', [this._id, data]);
    }
    getFeatureVector() {
        return pExec('KMeansQuantizer_getFeatureVector', [this._id]);
    }
    clear() {
        return pExec('KMeansQuantizer_clear', [this._id]);
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
    getClassLikelihoods() {
        return new Promise((resolve, reject) => {
            window.cordova.exec(resolve, reject, pluginName, 'HMM_getClassLikelihoods', [this._id]);
        });
    }
    getPredictedClassLabel() {
        return new Promise((resolve, reject) => {
            window.cordova.exec(resolve, reject, pluginName, 'HMM_getPredictedClassLabel', [this._id]);
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

const instantiators = {
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


const grt = {
    createTimeSeriesClassificationData() {
        return instantiators.createTimeSeriesClassificationData();
    },
    createDTW() {
        return instantiators.createDTW();
    },
    createKMeansQuantizer(clusters) {
        let p = instantiators.createKMeansQuantizer();
        if (typeof clusters !== 'undefined') {
            p = p.then(instance => instance.setNumClusters(clusters).then(() => instance));
        }
        return p;
    },
    createHMM() {
        return instantiators.createHMM();
    },
    HMM_CONTINUOUS: 1,
    HMM_DISCRETE: 0,

    HMM_LEFTRIGHT: 1,
    HMM_ERGODIC: 0,
};


module.exports = grt;
