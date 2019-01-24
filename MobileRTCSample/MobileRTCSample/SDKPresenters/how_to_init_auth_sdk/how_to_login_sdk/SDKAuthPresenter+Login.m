//
//  SDKAuthPresenter+Login.m
//  MobileRTCSample
//
//  Created by Murray Li on 2018/12/19.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import "SDKAuthPresenter+Login.h"

@implementation SDKAuthPresenter (Login)

- (void)loginWithEmail:(NSString *)email password:(NSString *)password remeberMe:(BOOL)remeberMe
{
    [[[MobileRTC sharedRTC] getAuthService] loginWithEmail:email password:password remeberMe:YES];
}

- (void)loginWithSSOToken:(NSString *)ssoToken remeberMe:(BOOL)remeberMe
{
    [[[MobileRTC sharedRTC] getAuthService] loginWithSSOToken:ssoToken remeberMe:YES];
}

@end
