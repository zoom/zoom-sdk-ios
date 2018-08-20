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

/*!
 @brief MobileRTCAuthService provides support for authorizing MobileRTC.
 @warning Before using MobileRTC, the client should authorize the MobileRTC at first. or the functions in MobileRTC cannot work correctly.
 */
@interface MobileRTCAuthService : NSObject

/*!
 @brief The property that acts as the delegate of the receiving auth/login events.
 */
@property (assign, nonatomic) id<MobileRTCAuthDelegate> delegate;

/*!
 @brief The key value is used during the authorization code grant. This key value is generated from MobileRTC Web site.
 @warning This value should be a secret. DO NOT publish this value.
 */
@property (retain, nonatomic) NSString *clientKey;

/*!
 @brief The secret value is used during the authorization code grant. This secret value is generated from MobileRTC Web site.
 @warning This value should be a secret. DO NOT publish this value.
 */
@property (retain, nonatomic) NSString *clientSecret;

/*!
 @brief Designated authorizing MobileRTC.
 @warning If the client key or secret is empty, user will get error:MobileRTCAuthError_KeyOrSecretEmpty in method onMobileRTCAuthReturn from MobileRTCAuthDelegate
 */
- (void)sdkAuth;

/*!
 @brief Designated for check whether mobileRTC logged in or not.
 @return YES means logged in.
 @warning this method is optional, if you do not log in with work email or SSO, just ignore it.
 */
- (BOOL)isLoggedIn;

/*!
 @brief Designated for check the user type.
 @return user type.
 @warning this method is optional, the default user type is MobileRTCUserType_APIUser. If login with work email in MobileRTC, the user type is MobileRTCUserType_ZoomUser; if login with SSO in MobileRTC, the user type is MobileRTCUserType_SSOUser.
 */
- (MobileRTCUserType)getUserType;

/*!
 @brief Designated for login MobileRTC with work email account.
 @param email the email address for login
 @param password the password for login
 @return YES means call this method successfully.
 @warning this method is optional, if you do not have work email account with MobileRTC, just ignore it.
 */
- (BOOL)loginWithEmail:(NSString*)email password:(NSString*)password remeberMe:(BOOL)remeberMe;

/*!
 @brief Designated for login MobileRTC with SSO (Single-Sign-On).
 @param token the user token information
 @return YES means call this method successfully.
 @warning this method is optional, if you need not SSO login with MobileRTC, just ignore it.
 */
- (BOOL)loginWithSSOToken:(NSString*)token;

/*!
 @brief Designated for logout MobileRTC.
 @return YES means call this method successfully.
 @warning this method is optional, if you did not log in, just ignore it.
 */
- (BOOL)logoutRTC;


@end

/*!
 @brief An Auth Service will issue the following value when the authorization state changes.
 */
@protocol MobileRTCAuthDelegate <NSObject>

@required
/*!
 @brief Designated for MobileRTC Auth response.
 @param returnValue tell user when the auth state changed.
 */
- (void)onMobileRTCAuthReturn:(MobileRTCAuthError)returnValue;

@optional
/*!
 @brief Designated for MobileRTC Login response.
 @param returnValue tell user when the login state changed.
 */
- (void)onMobileRTCLoginReturn:(NSInteger)returnValue;

/*!
 @brief Designated for MobileRTC Logout response.
 @param returnValue tell user whether the logout success or not.
 */
- (void)onMobileRTCLogoutReturn:(NSInteger)returnValue;

@end
