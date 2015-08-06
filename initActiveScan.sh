#! /bin/bash

cd ~/Desktop;
cordova create ActiveScan com.activesportsinc.activescan;
cd ActiveScan;
cordova plugins add https://github.com/aaronthorp/lineapro-phonegap-plugin.git;
wget -r -O ~/Desktop/ActiveScan/www/js/index.js https://gist.githubusercontent.com/johnvilsack/44cb8f6fd9328e327ff9/raw/9244ed88161bc6f01877891028ce702ed1654e6f/index.js;
cordova platforms add ios;
cordova build ios;