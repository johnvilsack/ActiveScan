#! /bin/bash

## Find the vars in 
source includes.sh

# Create Project 
cordova create $CORDOVA_NAME $CORDOVA_ID;

# Change name to src
mv $CORDOVA_NAME src;

# Move customizable files
yes | cp -f config.xml src/
yes | cp -f splash.png src/
yes | cp -f icon.png src/

cd src;

# Alter config.xml settings
sed -i.sed "s/CORDOVA_NAME/$CORDOVA_NAME/g" config.xml
sed -i.sed "s/CORDOVA_ID/$CORDOVA_ID/g" config.xml
sed -i.sed "s/AUTHOR_NAME/$AUTHOR_NAME/g" config.xml
sed -i.sed "s/AUTHOR_EMAIL/$AUTHOR_EMAIL/g" config.xml
sed -i.sed "s/AUTHOR_WEBSITE/$AUTHOR_WEBSITE/g" config.xml
rm config.xml.sed

# Get the Linea Plugin
cordova plugins add https://github.com/johnvilsack/ActiveScan-Cordova-Plugin-Linea-Pro.git;

# Get the proper index.js to activate it
wget -r -O www/js/index.js https://gist.githubusercontent.com/johnvilsack/44cb8f6fd9328e327ff9/raw/9244ed88161bc6f01877891028ce702ed1654e6f/index.js;

# Build for IOS
cordova platforms add ios;
cordova build ios;
cd ../;
cp default.plist src/platforms/ios/$CORDOVA_NAME/$CORDOVA_NAME-Info.plist;

# Create shortcut to XCode
ln -s src/platforms/ios/$CORDOVA_NAME.xcodeproj;