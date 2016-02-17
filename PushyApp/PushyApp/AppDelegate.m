//
//  AppDelegate.m
//  PushyApp
//
//  Created by Eric on 2015-11-16.
//  Copyright © 2015 Eric. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    application.applicationIconBadgeNumber = 0;
    
    UILocalNotification *localNotif = launchOptions[UIApplicationLaunchOptionsLocalNotificationKey];
    
    if (localNotif) {
        
        UIAlertController *notifAC = [UIAlertController alertControllerWithTitle:@"Supprise!!!" message:localNotif.alertBody preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *notifAction = [UIAlertAction actionWithTitle:@"Come on, Shut Up!" style:UIAlertActionStyleDefault handler:nil];
        
        [notifAC addAction:notifAction];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [application.keyWindow.rootViewController presentViewController:notifAC animated:YES completion:nil];
        });
    }
    
    return YES;
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
    application.applicationIconBadgeNumber = 0;
    
    UIAlertController *notifAC = [UIAlertController alertControllerWithTitle:@"Suprise!" message:notification.alertBody preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *notifAction = [UIAlertAction actionWithTitle:@"Okay, I go." style:UIAlertActionStyleDefault handler:nil];
    
    [notifAC addAction:notifAction];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [application.keyWindow.rootViewController presentViewController:notifAC animated:YES completion:nil];
    });
    
}

-(void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(nonnull UILocalNotification *)notification completionHandler:(nonnull void (^)())completionHandler{
    
    application.applicationIconBadgeNumber = 0;
    
    UIAlertController* notifAC = [UIAlertController alertControllerWithTitle:@"Recevied on notification pull down" message:identifier preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* notifAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
    
    [notifAC addAction:notifAction];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [application.keyWindow.rootViewController presentViewController:notifAC animated:YES completion:nil];
    });
    
    completionHandler();
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
