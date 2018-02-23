/* eslint-env jasmine */

exports.defineAutoTests = () => {
    describe('GRT (window.grt)', () => {
        it('should exist', () => {
            expect(window.grt).toBeDefined();
        });
    });
    describe('TimeSeriesClassificationData', () => {
        it('should be able to instantiate', (done) => {
            window.grt.createTimeSeriesClassificationData()
                .then((tscd) => {
                    expect(tscd).toBeDefined();
                    done();
                })
                .catch(done);
        });
        it('should be able to set the infoText', (done) => {
            const TEXT = 'TEST_INFO_TEXT';
            let tscd;
            window.grt.createTimeSeriesClassificationData()
                .then((t) => {
                    tscd = t;
                    return tscd.setInfoText(TEXT);
                })
                .then(() => tscd.getInfoText())
                .then((result) => {
                    expect(result).toEqual(TEXT);
                    done();
                })
                .catch(done);
        });
        it('should be able to set the datasetName', (done) => {
            const TEXT = 'TEST_DATASET_NAME';
            let tscd;
            window.grt.createTimeSeriesClassificationData()
                .then((t) => {
                    tscd = t;
                    return tscd.setDatasetName(TEXT);
                })
                .then(() => tscd.getDatasetName())
                .then((result) => {
                    expect(result).toEqual(TEXT);
                    done();
                })
                .catch(done);
        });
    });
    describe('DTW', () => {
        it('should be able to instantiate', (done) => {
            window.grt.createDTW()
                .then((dtw) => {
                    expect(dtw).toBeDefined();
                    done();
                })
                .catch(done);
        });
    });
    describe('KMeansQuantizer', () => {
        it('should be able to instantiate', (done) => {
            window.grt.createKMeansQuantizer()
                .then((quantizer) => {
                    expect(quantizer).toBeDefined();
                    done();
                })
                .catch(done);
        });
    });
    describe('HMM', () => {
        it('should be able to instantiate', (done) => {
            window.grt.createHMM()
                .then((hmm) => {
                    expect(hmm).toBeDefined();
                    done();
                })
                .catch(done);
        });
    });
};
