function onConnectivityChange(state) {
	console.log("Connection is: " + state);
}

function onBarcodeScanned(data) {
	console.log(data.barcode);
}

var app = {
	initialize: function() {
		this.bindEvents();
	},
	bindEvents: function() {
		document.addEventListener('deviceready', this.onDeviceReady, false);
	},
	onDeviceReady: function() {

///////////////////////////////////////////////////////////////////////////
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
///////////////////////////////////////////////////////////////////////////
		LineaProCDV.initDT();
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