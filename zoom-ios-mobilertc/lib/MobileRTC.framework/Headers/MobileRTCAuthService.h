//
//  MobileRTCAuthService.h
//  MobileRTC
//
//  Created by Robust Hu on 8/8/14.
//  Copyright (c) 2016 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MobileRTCConstants.h"

@protocol MobileRTCAuthDelegate;

/**
 * This class provides support for authorizing MobileRTC.
 *
 * The Authorization Code Grant requires HTTP request to allow the user to authenticate with MobileRTC and Authorize your
 * application. Upon successful authorization, the MobileRTCAuthDelegate will give MobileRTCAuthError_Success to user by method onMobileRTCAuthReturn.
 *
 * **Note**: Before using MobileRTC, the client should authorize the MobileRTC at first. or the function in MobileRTC cannot work correctly.
 */
@interface MobileRTCAuthService : NSObject

/**
 * The object that acts as the delegate of the receiving auth/login events.
 */
@property (assign, nonatomic) id<MobileRTCAuthDelegate> delegate;

/**
 * The key value is used during the authorization code grant. This key value is generated from MobileRTC Web site.
 * This value should be a secret. DO NOT publish this value.
 *
 */
@property (retain, nonatomic) NSString *clientKey;

/**
 * The secret value is used during the authorization code grant. This secret value is generated from MobileRTC Web site.
 * This value should be a secret. DO NOT publish this value.
 *
 */
@property (retain, nonatomic) NSString *clientSecret;


/**
 * Designated authorizing MobileRTC.
 *
 * If the client key or secret is empty, user will get error:MobileRTCAuthError_KeyOrSecretEmpty in method onMobileRTCAuthReturn from MobileRTCAuthDelegate
 */
- (void)sdkAuth;

/**
 * @return A BOOL indicating whether the MobileRTC auth may be valid.
 */
- (BOOL)isAuthorized;

/**
 * Designated for login MobileRTC with work email account.
 *
 * @param email, login email account.
 * @param password, login password.
 *
 * @return YES, if user can login with work email.
 *
 * *Note*: this method is optional, if you do have work email account with MobileRTC, just ignore it.
 */
- (BOOL)loginWithEmail:(NSString*)email password:(NSString*)password;

/**
 * Designated for logout MobileRTC.
 *
 * @return YES, if user can logout.
 *
 * *Note*: this method is optional, if you do have work email account with MobileRTC, just ignore it.
 */
- (BOOL)logoutRTC;


@end

/**
 * MobileRTCAuthDelegate
 * An Auth Service will issue the following value when the authorization state changes:
 *
 * - MobileRTCAuthError_Success: MobileRTC authorizs successfully.
 * - MobileRTCAuthError_KeyOrSecretEmpty: the client key or secret for MobileRTC Auth is empty.
 * - MobileRTCAuthError_KeyOrSecretWrong: the client key or secret for MobileRTC Auth is wrong.
 * - MobileRTCAuthError_AccountNotSupport: this client account cannot support MobileRTC.
 * - MobileRTCAuthError_AccountNotEnableSDK: this client account does not enable MobileRTC.
 */
@protocol MobileRTCAuthDelegate <NSObject>

@required
/**
 * Designated for MobileRTC Auth response.
 *
 * @param returnValue tell user when the auth state changed.
 *
 */
- (void)onMobileRTCAuthReturn:(MobileRTCAuthError)returnValue;

@optional
/**
 * Designated for MobileRTC Login response.
 *
 * @param returnValue tell user when the login state changed.
 *
 */
- (void)onMobileRTCLoginReturn:(NSInteger)returnValue;

/**
 * Designated for MobileRTC Logout response.
 *
 * @param returnValue tell user whether the logout success or not.
 *
 */
- (void)onMobileRTCLogoutReturn:(NSInteger)returnValue;

@end
