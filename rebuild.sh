#! /bin/bash
source files/script_config.ini

cd src;
cordova platforms remove ios;
cordova prepare;
cordova platforms add ios;
cd ../;
yes | cp -f files/default.plist src/platforms/ios/$CORDOVA_NAME/$CORDOVA_NAME-Info.plist;
yes | cp -f files/index.html www/index.html
yes | cp -f files/index.js www/js/index.js
cd src;

if [ "$DEBUGGING" == "Y" ]; then
	(cd www; sed -i.sed 's|<div class="app">|<div id="app" class="app">|g' index.html; rm index.html.sed;);
fi

cordova build ios;