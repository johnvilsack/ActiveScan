cordova.define("com.activescan.lineaprocdv.LineaProCDV", function(require, exports, module) { var 		argscheck = require('cordova/argscheck'),
			channel = require('cordova/channel'),
			utils = require('cordova/utils'),
			exec = require('cordova/exec'),
			cordova = require('cordova');

 function LineaProCDV() {
	this.results = [];
	this.respConnection = null;
	this.respError = null;
	this.respCancel = null;
	this.respBarcode = null;
}

LineaProCDV.prototype.initDT = function(callConnection, callBarcode, callCancel, callError) {
	this.results = [];
	this.respConnection = callConnection;
	this.respBarcode = callBarcode;
	this.respCancel = callCancel;
	this.respError = callError;

	exec(null, this.respError, "LineaProCDV", "initDT", []);
};

LineaProCDV.prototype.barcodeStart = function() {
	exec(null, null, "LineaProCDV", "startBarcode", []);
};

LineaProCDV.prototype.barcodeStop = function() {
	exec(null, null, "LineaProCDV", "stopBarcode", []);
};

LineaProCDV.prototype.connectionChanged = function(state) {
	this.respConnection(state);
};

LineaProCDV.prototype.onBarcodeData = function(rawCodesArr) {
	// Barcode scanning magic goes here.
	var data = { rawCodesArr: rawCodesArr };
	this.respBarcode(data);
};

module.exports = new LineaProCDV();

});
