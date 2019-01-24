//
//  AppDelegate.h
//  MobileRTCSample
//
//  Created by Xiaojian Hu on 3/17/14.
//  Copyright (c) 2014 Zoom Video Communications, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
*    ========== Disclaimer ==========
*
*    Please be aware that all hard-coded variables and constants 
*    shown in the documentation and in the demo, such as Zoom Token, 
*    Zoom Access, Token, etc., are ONLY FOR DEMO AND TESTING PURPOSES.
*    We STRONGLY DISCOURAGE the way of HARDCODING any Zoom Credentials
*    (username, password, API Keys & secrets, SDK keys & secrets, etc.)
*    or any Personal Identifiable Information (PII) inside your application. 
*    WE DON’T MAKE ANY COMMITMENTS ABOUT ANY LOSS CAUSED BY HARD-CODING CREDENTIALS
*    OR SENSITIVE INFORMATION INSIDE YOUR APP WHEN DEVELOPING WITH OUR SDK.
*
*/

#define kSDKAppKey      @""
#define kSDKAppSecret   @""
#define kSDKDomain      @""

@interface AppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate, MobileRTCPremeetingDelegate>

@property (strong, nonatomic) UIWindow *window;

- (UIViewController *)topViewController;
@end
