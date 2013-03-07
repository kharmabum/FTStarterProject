//
//  FTAppDelegate.m
//  FTStarterApplication
//
//  Created by Juan-Carlos Foust on 06/03/2013.
//  Copyright (c) 2013 Fototropik. All rights reserved.
//

#import "FTAppDelegate.h"
#import "FTUI.h"

@implementation FTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    

    NSDictionary *defaults = @{
                              // kFTDefaultsKey: kFTDefaultsValue,
                               };
	[[NSUserDefaults standardUserDefaults] registerDefaults:defaults];
    
    // Initialize the window
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.window.backgroundColor = [UIColor blackColor];
	[self applyStylesheet];
	
    /* Unless set w/ Storyboard */
    /*
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		self.window.rootViewController = [[UIViewController alloc] init];
	} else {
		self.window.rootViewController = [[UIViewController alloc] init];
	}
	[self.window makeKeyAndVisible];
     */
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [FTSessionManager suspendSession];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    //    if ( application.applicationIconBadgeNumber > 0 );
    //        [[HPTabBarController currentVC] setSelectedIndex:4];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    dispatch_async(dispatch_get_main_queue(), ^{
        [FTSessionManager resumeSession];
	});
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [FTSessionManager suspendSession];
//    [HPManager saveContext];
//    [FBSession.activeSession close];
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSString* newToken = [deviceToken description];
    newToken = [newToken stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
	newToken = [newToken stringByReplacingOccurrencesOfString:@" " withString:@""];
//    [[FTSessionManager activeUser] setPushtoken:newToken];
    Mixpanel *mixpanel = [Mixpanel sharedInstance];
    [mixpanel.people addPushDeviceToken:deviceToken];
//    [HPApiClient updateUser:[HPSessionManager activeUser] WithPushtoken:newToken success:NULL failure:NULL];
	NSLog(@"My token is: %@", deviceToken);
}



- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [FTUI clearFontCache];
    [FTUI clearColorCache];
}


#pragma mark - Stylesheet

- (void)applyStylesheet
{
    
}

@end