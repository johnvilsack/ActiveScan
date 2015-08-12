# ActiveScan

```git clone https://github.com/johnvilsack/ActiveScan.git; cd ActiveScan; ./create.sh;```

* ./create.sh will build the cordova project from scratch
* ./rebuild.sh will delete the platform folder, and rebuild (this is to force a rebuild of plugins)
* ./destroy.sh will destroy the contents of src, so be sure to back up any customizations
* ./clean.sh just removes the ios platform.  For gitting.

default.plist is renamed and pushed directly to the main app's plist on build.
