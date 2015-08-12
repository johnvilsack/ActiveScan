#!/bin/bash

CORDOVA_NAME="ActiveScan";
CORDOVA_ID="com.activescan.activescanapp";
AUTHOR_NAME="John Vilsack";
AUTHOR_EMAIL="vilsack@gmail.com";
AUTHOR_WEBSITE="www.johnvilsack.com";

CONTENT_INDEX="https://www.scirra.com/demos/c2/particles/";

# WKWebView offers substantial performance improvements over the older UIWebView.  This will enable a plugin
# that will offer Cordova to use WK, but also gracefully fall back to UI. 
USE_WKWEBVIEW="Y";