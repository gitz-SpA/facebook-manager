//
//  AppDelegate.m
//  FacebookManager
//
//  Created by Juan Eduardo Zumarán Salvatierra on 16-06-12.
//  Copyright (c) 2012 Juan Eduardo Zumarán Salvatierra. All rights reserved.
//
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

#import "AppDelegate.h"
#import "FacebookManager.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
 * Es necesario declarar este metodo dentro del AplicationDelegate de la aplicación. Este método se encarga
 * de tomar la llamada de respuesta que genera Facebook.
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    DebugLog(@"HANDLE URL: %@", url);
    
    NSString *facebookUrlScheme = [NSString stringWithFormat:@"fb%@", kFBAppId];
    
    if ([url.scheme isEqualToString:facebookUrlScheme]) {
        FacebookManager *manager = [FacebookManager sharedManager];
        return [[manager facebook] handleOpenURL:url];
    }
    else {
        return YES;
    }
}

@end
