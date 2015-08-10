#import "LineaProCDV.h"

@implementation LineaProCDV

- (void)initDT:(CDVInvokedUrlCommand*)command
{
	// runInBackground Fix
	[self.commandDelegate runInBackground:^{
		CDVPluginResult* pluginResult = nil;

		if (!dtdev) {
			dtdev = [DTDevices sharedDevice];
			[dtdev addDelegate:self];
			[dtdev connect];
		}

		[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
	}];
}

- (void)getConnectionStatus:(CDVInvokedUrlCommand*)command
{
	CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:[dtdev connstate]];
	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

// Required for init
- (void)connectionState: (int)state {
	switch (state) {
		case CONN_DISCONNECTED:
		case CONN_CONNECTING:
			break;
		case CONN_CONNECTED:
			break;
	}

	NSString* retStr = [ NSString stringWithFormat:@"LineaProCDV.connectionChanged(%d);", state];
	[[super webView] stringByEvaluatingJavaScriptFromString:retStr];
}

- (void)startBarcode:(CDVInvokedUrlCommand *)command
{
	[dtdev barcodeStartScan:nil];
	CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:[dtdev connstate]];
	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)stopBarcode:(CDVInvokedUrlCommand *)command
{
	[dtdev barcodeStopScan:nil];
	CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:[dtdev connstate]];
	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) barcodeData: (NSString *) barcode type:(int) type {
	NSLog(@"barcodeData: barcode - %@, type - %@", barcode, [dtdev barcodeType2Text:type]);
	NSString* retStr = [ NSString stringWithFormat:@"LineaProCDV.onBarcodeData('%@', '%@');", barcode, [dtdev barcodeType2Text:type]];
	[[super webView] stringByEvaluatingJavaScriptFromString:retStr];
}

// Preferences settings fro Lineas
- (void) readFromSettingsFile:(CDVInvokedUrlCommand*)command
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];

	//bundle path
	NSString *bPath = [[NSBundle mainBundle] bundlePath];
	NSString *settingsPath = [bPath stringByAppendingPathComponent:@"Settings.bundle"];
	NSString *plistFile = [settingsPath stringByAppendingPathComponent:@"Root.plist"];   

	// Dictionary and Primary Array
	NSDictionary *settingsDictionary = [NSDictionary dictionaryWithContentsOfFile:plistFile];
	NSArray *preferencesArray = [settingsDictionary objectForKey:@"PreferenceSpecifiers"];

	//Preferences Array
	NSDictionary *pref;

	// BOOL latestNews = ![[NSUserDefaults standardUserDefaults] boolForKey:@"notLatestNews"];

	for(pref in preferencesArray)
	{
		//get the key
		NSString *keyValue = [pref objectForKey:@"Key"];
		//get the default
		id defaultValue = [pref objectForKey:@"DefaultValue"];

		NSLog(@"%@, %@", defaultValue, keyValue);
		
		// if we have both, set in defaults
		if (keyValue && defaultValue)
		[standardUserDefaults setObject:defaultValue forKey:keyValue];
	}

	// Return specifically the PassThroughSync var.
	int retPassThroughSync = [[standardUserDefaults objectForKey:@"PassThroughSync"] intValue];
	NSLog(@"%i", retPassThroughSync);

	// keep the in-memory cache in sync with the database
   [standardUserDefaults synchronize];

	//FIGURE OUT HOW TO GET RESULTS BACK TO HTML.
	CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:retPassThroughSync];
	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


@end
