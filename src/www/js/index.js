function onDeviceConnected(data) {
    console.log("onDeviceConnected: " + data);
}


function onBarcodeScanned(data) {
    console.log("onBarcodeScanned: " + data.rawCodesArr);
}

var app = {
    // Application Constructor
    initialize: function() {
        this.bindEvents();
    },
    // Bind Event Listeners
    //
    // Bind any events that are required on startup. Common events are:
    // 'load', 'deviceready', 'offline', and 'online'.
    bindEvents: function() {
        document.addEventListener('deviceready', this.onDeviceReady, false);
    },
    // deviceready Event Handler
    //
    // The scope of 'this' is the event. In order to call the 'receivedEvent'
    // function, we must explicity call 'app.receivedEvent(...);'
    onDeviceReady: function() {
 


        document.getElementById('log');
        var container = document.getElementById('app');
        var newLog = '<div id=\"log\"></div>';
        container.innerHTML += newLog;

        // Console Logger to Div
        (function () {
            if (!console) {
                console = {};
            }
            var old = console.log;
            var logger = document.getElementById('log');
            console.log = function (message) {
                if (typeof message == 'object') {
                    logger.innerHTML = (JSON && JSON.stringify ? JSON.stringify(message) : String(message)) + '<br />';
                } else {
                    logger.innerHTML = message + '<br />';
                }
            }
        })();








        LineaProCDV.initDT(onDeviceConnected, onBarcodeScanned);
        app.receivedEvent('deviceready');
    },
        receivedEvent: function(id) {
        var parentElement = document.getElementById(id);
        var listeningElement = parentElement.querySelector('.listening');
        var receivedElement = parentElement.querySelector('.received');

        listeningElement.setAttribute('style', 'display:none;');
        receivedElement.setAttribute('style', 'display:block;');

        console.log('Received Event: ' + id);
    }
};

app.initialize();