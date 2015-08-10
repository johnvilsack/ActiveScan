function stateDevice(data) {
	console.log("ConnState: " + data);
}

function doScan(data) {
	console.log("Scanned: " + data.rawCodesArr);
}

var app = {
	initialize: function() {
		this.bindEvents();
	},
	bindEvents: function() {
		document.addEventListener('deviceready', this.onDeviceReady, false);
	},
	onDeviceReady: function() {

// LOGGER SPECIALLY ADDED DURING DEVELOPMENT
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
					logger.innerHTML += (JSON && JSON.stringify ? JSON.stringify(message) : String(message)) + '<br />';
				} else {
					logger.innerHTML += message + '<br />';
				}
			}
		})();

		LineaProCDV.initDT(stateDevice, doScan);
		app.receivedEvent('deviceready');
	},
		receivedEvent: function(id) {
		var parentElement = document.getElementById(id);
		var listeningElement = parentElement.querySelector('.listening');
		var receivedElement = parentElement.querySelector('.received');

		listeningElement.setAttribute('style', 'display:none;');
		receivedElement.setAttribute('style', 'display:block;');

		console.log('Event: ' + id);
	}
};

app.initialize();