//
//  AppDelegate.h
//  MobileRTCSample
//
//  Created by Xiaojian Hu on 3/17/14.
//  Copyright (c) 2014 Zoom Video Communications, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSDKKey      @""
#define kSDKSecret   @""
#define kSDKDomain   @""

@interface AppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate, MobileRTCPremeetingDelegate>

@property (strong, nonatomic) UIWindow *window;

- (UIViewController *)topViewController;
@end
