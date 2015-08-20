// Javascript that exists in the default index.html but is not required for Linea interface is presented here.

// Toggle Connectivity Status using CSS
function ConnectivityButton(state) {
	if (state == 2) {
		document.getElementById("ConnState").className = "circle-green";
	} else {
		document.getElementById("ConnState").className = "circle-red";
	}
}