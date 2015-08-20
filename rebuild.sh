#! /bin/bash
source files/script_config.ini

cd src;
cordova platforms remove ios;
cordova platforms add ios;
cordova prepare;
cd ../;
yes | cp -f files/default.plist src/platforms/ios/$CORDOVA_NAME/$CORDOVA_NAME-Info.plist;

yes | cp -f files/splash.png src/;
yes | cp -f files/icon.png src/;

yes | cp -f files/index.html src/www/index.html;
yes | cp -f files/index.js src/www/js/index.js;
sed -i.sed "s|CORDOVA_NAME|$CORDOVA_NAME|g" src/www/index.html;
rm src/www/index.html.sed;

cd src;

if [ "$DEBUGGING" == "Y" ]; then
	(cd www; sed -i.sed 's|<div class="app">|<div id="app" class="app">|g' index.html; rm index.html.sed;);
fi

cordova build ios;