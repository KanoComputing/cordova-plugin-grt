# Cordova Plugin GRT

Allows you to use The Gesture Recognition Toolkit from your web pages running with cordova.

## API

The API follows the API available here (https://github.com/KanoComputing/android-grt).

Due to the nature of a cordova plugin, every call must be asynchronous. To instantiate the GRT classes, you need to call <createNameOfClass> which will return a promise.

Example
```js

grt.createTimeSeriesClassificationData()
    .then((trainingData) => {
        // Do something here
        return trainingData.setInfoText('My Text');
    });

```