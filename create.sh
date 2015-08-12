#! /bin/bash

## Find the vars in 
source files/script_config.ini

# Create Project 
cordova create $CORDOVA_NAME $CORDOVA_ID;

# Change name to src
mv $CORDOVA_NAME src;

# Move customizable files
yes | cp -f files/config.xml src/
yes | cp -f files/splash.png src/
yes | cp -f files/icon.png src/

cd src;

# Alter config.xml settings
sed -i.sed "s|CORDOVA_NAME|$CORDOVA_NAME|g" config.xml
sed -i.sed "s|CORDOVA_ID|$CORDOVA_ID|g" config.xml
sed -i.sed "s|AUTHOR_NAME|$AUTHOR_NAME|g" config.xml
sed -i.sed "s|AUTHOR_EMAIL|$AUTHOR_EMAIL|g" config.xml
sed -i.sed "s|AUTHOR_WEBSITE|$AUTHOR_WEBSITE|g" config.xml
sed -i.sed "s|CONTENT_INDEX|$CONTENT_INDEX|g" config.xml
rm config.xml.sed

# Get the Linea Plugin
cordova plugins add https://github.com/johnvilsack/ActiveScan-Cordova-Plugin-Linea-Pro.git;

if [ "$USE_WKWEBVIEW" == "Y" ]; then
		cordova plugin add com.telerik.plugins.wkwebview;
fi

# Get index files for local server
yes | cp -f ../files/index.html www/index.html
yes | cp -f ../files/index.js www/js/index.js

# Add class for javascript console here. - DEBUG ONLY
(cd www; sed -i.sed 's|<div class="app">|<div id="app" class="app">|g' index.html; rm index.html.sed;)

# Build for IOS
cordova platforms add ios;
cordova prepare;
cordova build ios;
cd ../;
cp files/default.plist src/platforms/ios/$CORDOVA_NAME/$CORDOVA_NAME-Info.plist;

# Create shortcut to XCode
ln -s src/platforms/ios/$CORDOVA_NAME.xcodeproj;