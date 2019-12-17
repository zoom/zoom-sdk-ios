//
//  SDKAuthPresenter.m
//  MobileRTCSample
//
//  Created by Murray Li on 2018/11/15.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import "SDKAuthPresenter.h"
#import "AppDelegate.h"
#import "SDKAuthPresenter+AuthDelegate.h"

/**
 * We recommend that, you can generate jwttoken on your own server instead of hardcore in the code.
 * We hardcore it here, just to run the demo.
 *
 * You can generate a jwttoken on the https://jwt.io/
 * with this payload:
 * {
 *     "appKey": "string", // app key
 *     "iat": long, // access token issue timestamp
 *     "exp": long, // access token expire time
 *     "tokenExp": long // token expire time
 * }
 */
#define KjwtToken @""

@interface SDKAuthPresenter()
@property (nonatomic, copy) NSString *clientKey;
@property (nonatomic, copy) NSString *clientSecret;
@end

@implementation SDKAuthPresenter

- (void)SDKAuth:(NSString *)clientKey clientSecret:(NSString *)clientSecret
{
    self.clientKey = clientKey;
    self.clientSecret = clientSecret;
    MobileRTCAuthService *authService = [[MobileRTC sharedRTC] getAuthService];
    if (authService)
    {
        authService.delegate = self;
        authService.clientKey = clientKey;
        authService.clientSecret = clientSecret;
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
            [self SDKAuth:self.clientKey clientSecret:self.clientSecret];
        });
    }
}

@end
