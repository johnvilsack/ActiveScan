#! /bin/bash
cd src;
cordova platforms remove ios;
cordova platforms add ios;
cordova build ios;