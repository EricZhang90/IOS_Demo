//
//  ViewController.m
//  PushyApp
//
//  Created by Eric on 2015-11-16.
//  Copyright © 2015 Eric. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

-(void) requestPermissionToNotify;

-(void) createANotification: (int) secondInFuture;

@end

@implementation ViewController
- (IBAction)scheduleTapped:(id)sender {
    [self requestPermissionToNotify];
    [self createANotification:15];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)requestPermissionToNotify{
    
    UIMutableUserNotificationAction* later = [[UIMutableUserNotificationAction alloc]init];
    later.identifier = @"Time to school (later)";
    later.title = @"See that later";
    later.activationMode = NO;  // so, it is later action
    later.destructive = NO; // wether or not it is able to delete some data: delete email, appointment
    later.authenticationRequired = NO; // request a permission to accsess some data in security area when phone is locked.
    
    UIMutableUserNotificationAction* rightNow = [[UIMutableUserNotificationAction alloc]init];
    rightNow.identifier = @"Time to school (right now)";
    rightNow.title = @"See that right now";
    later.activationMode = YES;
    later.destructive = NO;
    later.authenticationRequired = NO;
    
    UIMutableUserNotificationCategory* notifCategory = [[UIMutableUserNotificationCategory alloc]init];
    notifCategory.identifier = @"Hurry Up!";
    [notifCategory setActions:@[later, rightNow] forContext:UIUserNotificationActionContextDefault];
    
    NSSet* categorySet = [NSSet setWithObject:notifCategory];
    
    UIUserNotificationType types  = UIUserNotificationTypeAlert |
                                    UIUserNotificationTypeBadge |
                                    UIUserNotificationTypeSound;
    
    UIUserNotificationSettings* setting = [UIUserNotificationSettings settingsForTypes:types categories:categorySet];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
}

-(void) createANotification: (int) secondInFuture{
    UILocalNotification* localNotif = [[UILocalNotification alloc] init];
    
    localNotif.fireDate = [[NSDate date] dateByAddingTimeInterval:secondInFuture];
    localNotif.timeZone = nil;
    
    localNotif.alertTitle = @"hurry up!";
    localNotif.alertBody = @"Hurry up! Time to school!";
    localNotif.alertAction = @"left to see more options";
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    localNotif.applicationIconBadgeNumber = 9999;
    
    localNotif.category = @"Hurry Up!"; // this name must be same as the name defined in func"request permision"
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
}

@end






















