#! /bin/bash
source includes.sh

cd src;
cordova platforms remove ios;
cordova platforms add ios;
cp default.plist src/platforms/ios/$CORDOVA_NAME/$CORDOVA_NAME-Info.plist;
cordova build ios;