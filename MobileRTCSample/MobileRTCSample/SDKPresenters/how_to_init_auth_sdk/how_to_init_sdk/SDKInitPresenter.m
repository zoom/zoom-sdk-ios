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
//    [MobileRTC initializeWithDomain:kSDKDomain enableLog:YES];
//    [[MobileRTC sharedRTC] setMobileRTCDomain:kSDKDomain];
    
    MobileRTCSDKInitContext *context = [[MobileRTCSDKInitContext alloc] init];
    context.domain = kSDKDomain;
    context.enableLog = YES;
    context.locale = MobileRTC_ZoomLocale_Default;

    //Note: This step is optional, Method is uesd for iOS Replaykit Screen share integration,if not,just ignore this step.
    context.appGroupId = @"";
    BOOL initializeSuc = [[MobileRTC sharedRTC] initialize:context];
    NSLog(@"initializeSuccessful======>%@",@(initializeSuc));
    
    NSLog(@"MobileRTC Version: %@", [[MobileRTC sharedRTC] mobileRTCVersion]);
    
//    // 2.This method is optional, MobileRTC will read Custom Localizable file from App’s main bundle first.
//       [[MobileRTC sharedRTC] setMobileRTCCustomLocalizableName:@"Custom"];
//   //3. Set Root Navigation Controller
//   //Note: This step is optional, If app’s rootViewController is not a UINavigationController, just ignore this step.
    [[MobileRTC sharedRTC] setMobileRTCRootController:navVC];
}

//- (BOOL)isChinaLocale
//{
//    NSString *localeIdentifier = [[NSLocale currentLocale] objectForKey:NSLocaleIdentifier];
//    return (localeIdentifier.length > 0 && ([localeIdentifier hasSuffix:@"_CN"] || ([localeIdentifier rangeOfString:@"_CN_"].location != NSNotFound)));
//}

@end
