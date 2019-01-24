//
//  SDKInitPresenter.m
//  MobileRTCSample
//
//  Created by Murray Li on 2018/11/19.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import "SDKInitPresenter.h"

@implementation SDKInitPresenter

- (void)SDKInit:(UINavigationController *)navVC
{
    //1. initSDK
    [MobileRTC initializeWithDomain:kSDKDomain enableLog:YES];
    
    NSLog(@"MobileRTC Version: %@", [[MobileRTC sharedRTC] mobileRTCVersion]);
    
//    //2. Set MobileRTC Resource Bundle path
//    //Note: This step is optional, If MobileRTCResources.bundle is included in other bundle/framework, use this method to set the path of MobileRTCResources.bundle, or just ignore this step
//    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
//    [[MobileRTC sharedRTC] setMobileRTCResPath:bundlePath];
//    // 3.This method is optional, MobileRTC will read Custom Localizable file from App’s main bundle first.
//       [[MobileRTC sharedRTC] setMobileRTCCustomLocalizableName:@"Custom"];
//   //4. Set Root Navigation Controller
//   //Note: This step is optional, If app’s rootViewController is not a UINavigationController, just ignore this step.
    [[MobileRTC sharedRTC] setMobileRTCRootController:navVC];
}

@end
