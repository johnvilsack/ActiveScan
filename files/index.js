function onConnectivityChange(state) {
	if (state == 2) {
		document.getElementById("ConnState").className = "circle circle-green";
	} else {
		document.getElementById("ConnState").className = "circle circle-red";
	}
}

function onBarcodeScanned(data) {
	document.getElementById("barcode").innerHTML = data.barcode;
	document.getElementById("type").innerHTML = data.type;
}

var app = {
	initialize: function() {
		this.bindEvents();
	},
	bindEvents: function() {
		document.addEventListener('deviceready', this.onDeviceReady, false);
	},
	onDeviceReady: function() {
		LineaProCDV.initDT();
		app.receivedEvent('deviceready');
	},
		receivedEvent: function(id) {
		console.log('Received Event: ' + id);
	}
};
app.initialize();