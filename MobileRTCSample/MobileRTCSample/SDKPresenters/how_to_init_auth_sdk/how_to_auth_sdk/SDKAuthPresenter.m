//
//  SDKAuthPresenter.m
//  MobileRTCSample
//
//  Created by Zoom Video Communications on 2018/11/15.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import "SDKAuthPresenter.h"
#import "AppDelegate.h"
#import "SDKAuthPresenter+AuthDelegate.h"


@interface SDKAuthPresenter()

@end

@implementation SDKAuthPresenter

- (void)SDKAuth
{

    MobileRTCAuthService *authService = [[MobileRTC sharedRTC] getAuthService];
    if (authService)
    {
        authService.delegate = self;
        // Here need add your jwtToken, if jwtToken is nil or empty,We will user your clientKey and clientSecret to Auth, We recommend using JWTToken.
        authService.jwtToken = KjwtToken;
        [authService sdkAuth];
    }
}

#pragma mark - AlertView Delegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != alertView.cancelButtonIndex)
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self SDKAuth];
        });
    }
}

@end
