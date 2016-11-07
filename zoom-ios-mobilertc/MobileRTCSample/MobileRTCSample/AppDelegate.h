//
//  AppDelegate.h
//  ZoomSDKSample
//
//  Created by Xiaojian Hu on 3/17/14.
//  Copyright (c) 2014 Zoom Video Communications, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, MobileRTCAuthDelegate, UIAlertViewDelegate, MobileRTCPremeetingDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
