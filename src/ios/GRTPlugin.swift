@objc(GRTPlugin) class GRTPlugin : CDVPlugin {
    override func pluginInitialize() {
        print("GRTPlugin loaded")
    }

    func createTimeSeriesClassificationData(_ command: CDVInvokedUrlCommand) {
        let instanceId = TSCDWrapper.create()
        self.commandDelegate.send(
            CDVPluginResult(status: CDVCommandStatus_OK, messageAs: instanceId),
            callbackId:command.callbackId
        )
    }

    // window.cordova.exec(resolve, reject, pluginName, 'TimeSeriesClassificationData_setInfoText', [this._id, text]);
    func TimeSeriesClassificationData_setInfoText(_ command: CDVInvokedUrlCommand) {
        guard let instanceId = command.argument(at: 0) as? String else {
            self.commandDelegate.send(
                CDVPluginResult(status: CDVCommandStatus_ERROR,
                                messageAs: "TimeSeriesClassificationData_setInfoText: Called with wrong parameters: instanceId"),
                callbackId:command.callbackId
            )
            return
        }

        let instance = TSCDWrapper.getFromId(instanceId)
        instance?.setInfoText(command.argument(at: 2) as! String)

        self.commandDelegate.send(
            CDVPluginResult(status: CDVCommandStatus_OK),
            callbackId:command.callbackId
        )
    }

    // window.cordova.exec(resolve, reject, pluginName, 'TimeSeriesClassificationData_getInfoText', [this._id]);
    func TimeSeriesClassificationData_getInfoText(_ command: CDVInvokedUrlCommand) {
        guard let instanceId = command.argument(at: 0) as? String else {
            self.commandDelegate.send(
                CDVPluginResult(status: CDVCommandStatus_ERROR,
                                messageAs: "TimeSeriesClassificationData_getInfoText: Called with wrong parameters: instanceId"),
                callbackId:command.callbackId
            )
            return
        }
        let instance = TSCDWrapper.getFromId(instanceId)
        let infoText = instance?.getInfoText()

        self.commandDelegate.send(
            CDVPluginResult(status: CDVCommandStatus_OK, messageAs: infoText),
            callbackId:command.callbackId
        )
    }

    // window.cordova.exec(resolve, reject, pluginName, 'TimeSeriesClassificationData_setNumDimensions', [this._id, n]);
    func TimeSeriesClassificationData_setNumDimensions(_ command: CDVInvokedUrlCommand) {
        guard let instanceId = command.argument(at: 0) as? String else {
            self.commandDelegate.send(
                CDVPluginResult(status: CDVCommandStatus_ERROR,
                                messageAs: "TimeSeriesClassificationData_setNumDimensions: Called with wrong parameters: instanceId"),
                callbackId:command.callbackId
            )
            return
        }
        guard let numDimensions = command.argument(at: 1) as? UInt32 else {
            self.commandDelegate.send(
                CDVPluginResult(status: CDVCommandStatus_ERROR,
                                messageAs: "TimeSeriesClassificationData_setNumDimensions: Called with wrong parameters: numDimensions"),
                callbackId:command.callbackId
            )
            return
        }

        let instance = TSCDWrapper.getFromId(instanceId)
        instance?.setNumDimensions(numDimensions)

        self.commandDelegate.send(
            CDVPluginResult(status: CDVCommandStatus_OK),
            callbackId:command.callbackId
        )
    }

    // window.cordova.exec(resolve, reject, pluginName, 'TimeSeriesClassificationData_getNumDimensions', [this._id]);
    func TimeSeriesClassificationData_getNumDimensions(_ command: CDVInvokedUrlCommand) {
        guard let instanceId = command.argument(at: 0) as? String else {
            self.commandDelegate.send(
                CDVPluginResult(status: CDVCommandStatus_ERROR,
                                messageAs: "TimeSeriesClassificationData_getNumDimensions: Called with wrong parameters: instanceId"),
                callbackId:command.callbackId
            )
            return
        }
        let instance = TSCDWrapper.getFromId(instanceId)
        let numDimensions = instance?.getNumDimensions()

        self.commandDelegate.send(
            CDVPluginResult(status: CDVCommandStatus_OK, messageAs: Int32(numDimensions!)),
            callbackId:command.callbackId
        )
    }

    // window.cordova.exec(resolve, reject, pluginName, 'TimeSeriesClassificationData_getNumSamples', [this._id]);
    func TimeSeriesClassificationData_getNumSamples(_ command: CDVInvokedUrlCommand) {
        guard let instanceId = command.argument(at: 0) as? String else {
            self.commandDelegate.send(
                CDVPluginResult(status: CDVCommandStatus_ERROR,
                                messageAs: "TimeSeriesClassificationData_getNumSamples: Called with wrong parameters: instanceId"),
                callbackId:command.callbackId
            )
            return
        }
        let instance = TSCDWrapper.getFromId(instanceId)
        let numSamples = instance?.getNumSamples()

        self.commandDelegate.send(
            CDVPluginResult(status: CDVCommandStatus_OK, messageAs: Int32(numSamples!)),
            callbackId:command.callbackId
        )
    }

    // window.cordova.exec(resolve, reject, pluginName, 'TimeSeriesClassificationData_addSample', [this._id, label, matrix]);
    func TimeSeriesClassificationData_addSample(_ command: CDVInvokedUrlCommand) {
        guard let instanceId = command.argument(at: 0) as? String else {
            self.commandDelegate.send(
                CDVPluginResult(status: CDVCommandStatus_ERROR,
                                messageAs: "TimeSeriesClassificationData_addSample: Called with wrong parameters: instanceId"),
                callbackId:command.callbackId
            )
            return
        }
        guard let label = command.argument(at: 1) as? UInt32 else {
            self.commandDelegate.send(
                CDVPluginResult(status: CDVCommandStatus_ERROR,
                                messageAs: "TimeSeriesClassificationData_addSample: Called with wrong parameters: label"),
                callbackId:command.callbackId
            )
            return
        }

        guard let matrix = command.argument(at: 2) as? NSArray else {
            self.commandDelegate.send(
                CDVPluginResult(status: CDVCommandStatus_ERROR,
                                messageAs: "TimeSeriesClassificationData_addSample: Called with wrong parameters: sample"),
                callbackId:command.callbackId
            )
            return
        }

        let instance = TSCDWrapper.getFromId(instanceId)
        let mf = MatrixFloat()

        for vector in matrix {
            let vf = VectorFloat()
            for number in vector as! NSArray {
                vf.push_back(number as! Float)
            }
            mf.push_back(vf)
        }

        instance?.addSample(label, withMatrix: mf)

        self.commandDelegate.send(
            CDVPluginResult(status: CDVCommandStatus_OK),
            callbackId:command.callbackId
        )
    }

    //KMeansQuantizer
    func createKMeansQuantizer(_ command: CDVInvokedUrlCommand) {
        let instanceId = KMeansQuantizerWrapper.create()
        self.commandDelegate.send(
            CDVPluginResult(status: CDVCommandStatus_OK, messageAs: instanceId),
            callbackId:command.callbackId
        )
    }

    func KMeansQuantizer_setNumClusters(_ command: CDVInvokedUrlCommand){
        guard let instanceId = command.argument(at: 0) as? String else {
            self.commandDelegate.send(
                CDVPluginResult(status: CDVCommandStatus_ERROR,
                                messageAs: "KMeansQuantizer_setNumClusters: Called with wrong parameters: instanceId"),
                callbackId:command.callbackId
            )
            return
        }
        guard let numClusters = command.argument(at: 1) as? UInt32 else {
            self.commandDelegate.send(
                CDVPluginResult(status: CDVCommandStatus_ERROR,
                                messageAs: "KMeansQuantizer_setNumClusters: Called with wrong parameters: numClusters"),
                callbackId:command.callbackId
            )
            return
        }
        let instance = KMeansQuantizerWrapper.getFromId(instanceId)
        let result = instance?.setNumClusters(numClusters)

        self.commandDelegate.send(
            CDVPluginResult(status: CDVCommandStatus_OK),
            callbackId:command.callbackId
        )
    }

    func KMeansQuantizer_train(_ command: CDVInvokedUrlCommand) {
        guard let instanceId = command.argument(at: 0) as? String else {
            self.commandDelegate.send(
                CDVPluginResult(status: CDVCommandStatus_ERROR,
                                messageAs: "KMeansQuantizer_train: Called with wrong parameters: instanceId"),
                callbackId:command.callbackId
            )
            return
        }
        guard let sampleId = command.argument(at: 1) as? String else {
            self.commandDelegate.send(
                CDVPluginResult(status: CDVCommandStatus_ERROR,
                                messageAs: "KMeansQuantizer_train: Called with wrong parameters: sampleId"),
                callbackId:command.callbackId
            )
            return
        }

        let instance = KMeansQuantizerWrapper.getFromId(instanceId)
        let sample = TSCDWrapper.getFromId(sampleId)
        instance?.train(sample)

        self.commandDelegate.send(
            CDVPluginResult(status: CDVCommandStatus_OK),
            callbackId:command.callbackId
        )
    }

    func KMeansQuantizer_quantize(_ command: CDVInvokedUrlCommand) {
        guard let instanceId = command.argument(at: 0) as? String else {
            self.commandDelegate.send(
                CDVPluginResult(status: CDVCommandStatus_ERROR,
                                messageAs: "KMeansQuantizer_quantize: Called with wrong parameters: instanceId"),
                callbackId:command.callbackId
            )
            return
        }

        guard let vector = command.argument(at: 1) as? NSArray else {
            self.commandDelegate.send(
                CDVPluginResult(status: CDVCommandStatus_ERROR,
                                messageAs: "KMeansQuantizer_quantize: Called with wrong parameters: vector"),
                callbackId:command.callbackId
            )
            return
        }

        let instance = KMeansQuantizerWrapper.getFromId(instanceId)
        let vf = VectorFloat()

        print("QUANTIZE")

        for value in vector {
            print(value)
        }

        for value in vector {
            vf.push_back(value as! Float)
        }

        instance!.quantize(vf)

        self.commandDelegate.send(
            CDVPluginResult(status: CDVCommandStatus_OK),
            callbackId:command.callbackId
        )
    }

    func KMeansQuantizer_getFeatureVector(_ command: CDVInvokedUrlCommand) {
        guard let instanceId = command.argument(at: 0) as? String else {
            self.commandDelegate.send(
                CDVPluginResult(status: CDVCommandStatus_ERROR,
                                messageAs: "KMeansQuantizer_getFeatureVector: called with wrong parameters: instanceId"),
                callbackId:command.callbackId
            )
            return
        }
        let instance = KMeansQuantizerWrapper.getFromId(instanceId)

        let vf = instance?.getFeatureVector()
        let array = vf!.toNSArray();

        for el in array! {
            print("ELEMENT: ")
            print(el)
        }

        self.commandDelegate.send(
            CDVPluginResult(status: CDVCommandStatus_OK, messageAs: array),
            callbackId:command.callbackId
        )
    }

    // HMM
    func createHMM(_ command: CDVInvokedUrlCommand) {
        let instanceId = HMMWrapper.create()
        print("Created HMM \(instanceId!)")
        commandDelegate.send(
            CDVPluginResult(status: CDVCommandStatus_OK, messageAs: instanceId),
            callbackId:command.callbackId
        )
    }

    // - (BOOL) train:(TSCDWrapper *) sample;
    func HMM_train(_ command: CDVInvokedUrlCommand) {
        guard let instanceId = command.argument(at: 0) as? String else {
            self.commandDelegate.send(
                CDVPluginResult(status: CDVCommandStatus_ERROR,
                                messageAs: "HMM_train: Called with wrong parameters: instanceId"),
                callbackId:command.callbackId
            )
            return
        }
        guard let sampleId = command.argument(at: 1) as? String else {
            self.commandDelegate.send(
                CDVPluginResult(status: CDVCommandStatus_ERROR,
                                messageAs: "HMM_train: Called with wrong parameters: sampleId"),
                callbackId:command.callbackId
            )
            return
        }
        let instance = HMMWrapper.getFromId(instanceId)
        let sample = TSCDWrapper.getFromId(sampleId)
        instance?.train(sample)

        self.commandDelegate.send(
            CDVPluginResult(status: CDVCommandStatus_OK),
            callbackId:command.callbackId
        )
    }

    // - (BOOL) predict:(MatrixFloat *) timeseries;
    func HMM_predict(_ command: CDVInvokedUrlCommand) {
        guard let instanceId = command.argument(at: 0) as? String else {
            self.commandDelegate.send(
                CDVPluginResult(status: CDVCommandStatus_ERROR,
                                messageAs: "HMM_predict: Called with wrong parameters: instanceId"),
                callbackId:command.callbackId
            )
            return
        }
        guard let matrix = command.argument(at: 1) as? NSArray else {
            self.commandDelegate.send(
                CDVPluginResult(status: CDVCommandStatus_ERROR,
                                messageAs: "HMM_predict: Called with wrong parameters: matrix"),
                callbackId:command.callbackId
            )
            return
        }

        let instance = HMMWrapper.getFromId(instanceId)
        let mf = MatrixFloat()

        for vector in matrix {
            let vf = VectorFloat()
            for number in vector as! NSArray {
                vf.push_back(number as! Float)
            }
            mf.push_back(vf)
        }

        instance?.predict(mf)

        self.commandDelegate.send(
            CDVPluginResult(status: CDVCommandStatus_OK),
            callbackId:command.callbackId
        )
    }

    // - (VectorFloat *) getClassLikelihoods;
    func HMM_getClassLikelihoods(_ command: CDVInvokedUrlCommand) {
        guard let instanceId = command.argument(at: 0) as? String else {
            self.commandDelegate.send(
                CDVPluginResult(status: CDVCommandStatus_ERROR,
                                messageAs: "HMM_getClassLikelihoods: Called with wrong parameters: instanceId"),
                callbackId:command.callbackId
            )
            return
        }
        let instance = HMMWrapper.getFromId(instanceId)

        let vf = instance?.getClassLikelihoods()
        let array = vf!.toNSArray();

        self.commandDelegate.send(
            CDVPluginResult(status: CDVCommandStatus_OK, messageAs: array),
            callbackId:command.callbackId
        )
    }

    // - (unsigned int) getPredictedClassLabel;
    func HMM_getPredictedClassLabel(_ command: CDVInvokedUrlCommand) {
        guard let instanceId = command.argument(at: 0) as? String else {
            self.commandDelegate.send(
                CDVPluginResult(status: CDVCommandStatus_ERROR,
                                messageAs: "HMM_getPredictedClassLabel: Called with wrong parameters: instanceId"),
                callbackId:command.callbackId
            )
            return
        }
        let instance = HMMWrapper.getFromId(instanceId)
        let predictedClassLabel = instance?.getPredictedClassLabel()

        self.commandDelegate.send(
            CDVPluginResult(status: CDVCommandStatus_OK, messageAs: Int32(predictedClassLabel!)),
            callbackId:command.callbackId
        )
    }

    // - (BOOL) setHMMType: (unsigned int) hmmType;
    func HMM_setHMMType(_ command: CDVInvokedUrlCommand) {
        guard let instanceId = command.argument(at: 0) as? String else {
            self.commandDelegate.send(
                CDVPluginResult(status: CDVCommandStatus_ERROR,
                                messageAs: "HMM_setHMMType: Called with wrong parameters: instanceId"),
                callbackId:command.callbackId
            )
            return
        }
        guard let type = command.argument(at: 1) as? UInt32 else {
            self.commandDelegate.send(
                CDVPluginResult(status: CDVCommandStatus_ERROR,
                                messageAs: "HMM_setHMMType: Called with wrong parameters: hmmType"),
                callbackId:command.callbackId
            )
            return
        }

        let instance = HMMWrapper.getFromId(instanceId)
        let result = instance?.setHMMType(type)

        self.commandDelegate.send(
            CDVPluginResult(status: CDVCommandStatus_OK, messageAs: result!),
            callbackId:command.callbackId
        )
    }

    // - (BOOL) setNumStates: (unsigned int) n;
    func HMM_setNumStates(_ command: CDVInvokedUrlCommand) {
        guard let instanceId = command.argument(at: 0) as? String else {
            self.commandDelegate.send(
                CDVPluginResult(status: CDVCommandStatus_ERROR,
                                messageAs: "HMM_setHMMType: Called with wrong parameters: instanceId"),
                callbackId:command.callbackId
            )
            return
        }
        guard let numStates = command.argument(at: 1) as? UInt32 else {
            self.commandDelegate.send(
                CDVPluginResult(status: CDVCommandStatus_ERROR,
                                messageAs: "HMM_setHMMType: Called with wrong parameters: numStates"),
                callbackId:command.callbackId
            )
            return
        }
        let instance = HMMWrapper.getFromId(instanceId)
        let result = instance?.setNumStates(numStates)

        self.commandDelegate.send(
            CDVPluginResult(status: CDVCommandStatus_OK, messageAs: result!),
            callbackId:command.callbackId
        )
    }

    // - (BOOL) setNumSymbols: (unsigned int) n;
    func HMM_setNumSymbols(_ command: CDVInvokedUrlCommand) {
        guard let instanceId = command.argument(at: 0) as? String else {
            self.commandDelegate.send(
                CDVPluginResult(status: CDVCommandStatus_ERROR,
                                messageAs: "HMM_setHMMType: Called with wrong parameters: instanceId"),
                callbackId:command.callbackId
            )
            return
        }
        guard let numSymbols = command.argument(at: 1) as? UInt32 else {
            self.commandDelegate.send(
                CDVPluginResult(status: CDVCommandStatus_ERROR,
                                messageAs: "HMM_setHMMType: Called with wrong parameters: numSymbols"),
                callbackId:command.callbackId
            )
            return
        }
        let instance = HMMWrapper.getFromId(instanceId)
        let result = instance?.setNumSymbols(numSymbols)

        self.commandDelegate.send(
            CDVPluginResult(status: CDVCommandStatus_OK, messageAs: result!),
            callbackId:command.callbackId
        )
    }

    // - (BOOL) setModelType: (unsigned int) n;
    func HMM_setModelType(_ command: CDVInvokedUrlCommand) {
        guard let instanceId = command.argument(at: 0) as? String else {
            self.commandDelegate.send(
                CDVPluginResult(status: CDVCommandStatus_ERROR,
                                messageAs: "HMM_setHMMType: Called with wrong parameters: instanceId"),
                callbackId:command.callbackId
            )
            return
        }
        guard let modelType = command.argument(at: 1) as? UInt32 else {
            self.commandDelegate.send(
                CDVPluginResult(status: CDVCommandStatus_ERROR,
                                messageAs: "HMM_setHMMType: Called with wrong parameters: modelType"),
                callbackId:command.callbackId
            )
            return
        }
        let instance = HMMWrapper.getFromId(instanceId)
        let result = instance?.setModelType(modelType)

        self.commandDelegate.send(
            CDVPluginResult(status: CDVCommandStatus_OK, messageAs: result!),
            callbackId:command.callbackId
        )
    }

    // - (BOOL) setMinChange: (float) n;
    func HMM_setMinChange(_ command: CDVInvokedUrlCommand) {
        guard let instanceId = command.argument(at: 0) as? String else {
            self.commandDelegate.send(
                CDVPluginResult(status: CDVCommandStatus_ERROR,
                                messageAs: "HMM_setHMMType: Called with wrong parameters: instanceId"),
                callbackId:command.callbackId
            )
            return
        }
        guard let minChange = command.argument(at: 1) as? Float else {
            self.commandDelegate.send(
                CDVPluginResult(status: CDVCommandStatus_ERROR,
                                messageAs: "HMM_setHMMType: Called with wrong parameters: minChange"),
                callbackId:command.callbackId
            )
            return
        }
        let instance = HMMWrapper.getFromId(instanceId)
        let result = instance?.setMinChange(minChange)

        self.commandDelegate.send(
            CDVPluginResult(status: CDVCommandStatus_OK, messageAs: result!),
            callbackId:command.callbackId
        )
    }

    // - (BOOL) setMaxNumEpochs: (unsigned int) n;
    func HMM_setMaxNumEpochs(_ command: CDVInvokedUrlCommand) {
        guard let instanceId = command.argument(at: 0) as? String else {
            self.commandDelegate.send(
                CDVPluginResult(status: CDVCommandStatus_ERROR,
                                messageAs: "HMM_setHMMType: Called with wrong parameters: instanceId"),
                callbackId:command.callbackId
            )
            return
        }
        guard let maxNumEpochs = command.argument(at: 1) as? UInt32 else {
            self.commandDelegate.send(
                CDVPluginResult(status: CDVCommandStatus_ERROR,
                                messageAs: "HMM_setHMMType: Called with wrong parameters: maxNumEpochs"),
                callbackId:command.callbackId
            )
            return
        }
        let instance = HMMWrapper.getFromId(instanceId)
        let result = instance?.setMaxNumEpochs(maxNumEpochs)

        self.commandDelegate.send(
            CDVPluginResult(status: CDVCommandStatus_OK, messageAs: result!),
            callbackId:command.callbackId
        )
    }

    // - (BOOL) setNumRandomTrainingIterations: (unsigned int) n
    func HMM_setNumRandomTrainingIterations(_ command: CDVInvokedUrlCommand) {
        guard let instanceId = command.argument(at: 0) as? String else {
            self.commandDelegate.send(
                CDVPluginResult(status: CDVCommandStatus_ERROR,
                                messageAs: "HMM_setHMMType: Called with wrong parameters: instanceId"),
                callbackId:command.callbackId
            )
            return
        }
        guard let numRandomTrainingIterations = command.argument(at: 1) as? UInt32 else {
            self.commandDelegate.send(
                CDVPluginResult(status: CDVCommandStatus_ERROR,
                                messageAs: "HMM_setHMMType: Called with wrong parameters: numRandomTrainingIterations"),
                callbackId:command.callbackId
            )
            return
        }
        let instance = HMMWrapper.getFromId(instanceId)
        let result = instance?.setNumRandomTrainingIterations(numRandomTrainingIterations)

        self.commandDelegate.send(
            CDVPluginResult(status: CDVCommandStatus_OK, messageAs: result!),
            callbackId:command.callbackId
        )
    }

    // DTW
    func createDTW(_ command: CDVInvokedUrlCommand) {
        let instanceId = DTWWrapper.create()
        self.commandDelegate.send(
            CDVPluginResult(status: CDVCommandStatus_OK, messageAs: instanceId),
            callbackId:command.callbackId
        )
    }
}


