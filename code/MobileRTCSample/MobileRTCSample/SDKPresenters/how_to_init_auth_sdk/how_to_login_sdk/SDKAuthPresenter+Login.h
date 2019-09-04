//
//  SDKAuthPresenter+Login.h
//  MobileRTCSample
//
//  Created by Murray Li on 2018/12/19.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import "SDKAuthPresenter.h"

@interface SDKAuthPresenter (Login)

- (void)loginWithEmail:(NSString *)email password:(NSString *)password remeberMe:(BOOL)remeberMe;

- (void)loginWithSSOToken:(NSString *)ssoToken remeberMe:(BOOL)remeberMe;

@end
