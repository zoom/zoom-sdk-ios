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
@class MobileRTCAccountInfo;
@class MobileRTCAlternativeHost;

/*!
 @brief MobileRTCAuthService provides support for authorizing MobileRTC.
 @warning Before using MobileRTC, the client should authorize the MobileRTC at first. or the functions in MobileRTC cannot work correctly.
 */
@interface MobileRTCAuthService : NSObject

/*!
 @brief The property that acts as the delegate of the receiving auth/login events.
 */
@property (nullable, assign, nonatomic) id<MobileRTCAuthDelegate> delegate;

/*!
 @brief The key value is used during the authorization code grant. This key value is generated from MobileRTC Web site.
 @warning This value should be a secret. DO NOT publish this value.
 */
@property (nonnull, retain, nonatomic) NSString *clientKey;

/*!
 @brief The secret value is used during the authorization code grant. This secret value is generated from MobileRTC Web site.
 @warning This value should be a secret. DO NOT publish this value.
 */
@property (nonnull, retain, nonatomic) NSString *clientSecret;

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
- (BOOL)loginWithEmail:(nonnull NSString*)email password:(nonnull NSString*)password remeberMe:(BOOL)remeberMe;

/*!
 @brief Designated for login MobileRTC with SSO (Single-Sign-On).
 @param token the user token information
 @return YES means call this method successfully.
 @warning this method is optional, if you need not SSO login with MobileRTC, just ignore it.
 */
- (BOOL)loginWithSSOToken:(nonnull NSString*)token remeberMe:(BOOL)remeberMe;

/*!
 @brief Designated for logout MobileRTC.
 @return YES means call this method successfully.
 @warning this method is optional, if you did not log in, just ignore it.
 */
- (BOOL)logoutRTC;

/*!
 @brief Designated for get Login User Profile Info.
 @return MobileRTCAccountInfo instance is success.
 @warning Get instance successfully only after login.
 */
- (nullable MobileRTCAccountInfo*)getAccountInfo;
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

/*!
 @brief MobileRTCAccountInfo used to store the login user profile information.
 */
@interface MobileRTCAccountInfo : NSObject

/*!
 @brief This method is used to get account email address.
 @return email address
 */
- (nullable NSString*)getEmailAddress;

/*!
 @brief This method is used to get PMI Vanity URL from user profile info.
 @return PMI Vanity URL.
 */
- (nullable NSString *)getPMIVanityURL;

/*!
 @brief This method is used to check whether Audio Type: Telephone Only is supported while schedule meeting.
 @return YES means supported
 */
- (BOOL)isTelephoneOnlySupported;

/*!
 @brief This method is used to check whether Audio Type: Telephone And Voip is supported while schedule meeting.
 @return YES means supported
 */
- (BOOL)isTelephoneAndVoipSupported;

/*!
 @brief This method is used to check whether Audio Type: 3rdParty Audio is supported while schedule meeting.
 @return YES means supported
 */
- (BOOL)is3rdPartyAudioSupported;

/*!
 @brief This method is get 3rd Party Audio Info from user profile info.
 @return send 3rd Party Audio Info.
 */
- (nullable NSString*)get3rdPartyAudioInfo;

/*!
 @brief This method is default Audio Type from user info from user profile info.
 @return default audio type.
 */
- (MobileRTCMeetingItemAudioType)getDefaultAudioInfo;

/*!
 @brief This method is used to check whether only allow signed-in user join the meeting while schedule meeting.
 @return Yes only allow signed-in user join the meeting.
 */
- (BOOL)onlyAllowSignedInUserJoinMeeting;

/*!
 @brief This method is used to get alternative host list from user profile info.
 @return array with MobileRTCAlternativeHost info.
 */
- (nullable NSArray*)getCanScheduleForUsersList;

/*!
 @brief This method is used to check whether local recording is supported while schedule meeting.
 @return YES means supported
 */
- (BOOL)isLocalRecordingSupported;

/*!
 @brief This method is used to check whether cloud recording is supported while schedule meeting.
 @return YES means supported
 */
- (BOOL)isCloudRecordingSupported;

/*!
 @brief This method is used to set default Meeting Auto Record Type from user info from user profile info.
 @return default Meeting Auto Record Type.
 */
- (MobileRTCMeetingItemRecordType)getDefaultAutoRecordType;

/*!
 @brief This method is used to check whether only user in specified domain can join the meeting while schedule meeting.
 @return YES means supported
 */
- (BOOL)isSpecifiedDomainCanJoinFeatureOn;

/*!
 @brief This method is used to get Specified domain from user profile info.
 @return NSString type default Sepecified of domain array.
 */
- (nullable NSArray *)getDefaultCanJoinUserSpecifiedDomains;

@end

/*!
 @brief MobileRTCAlternativeHost used to store alternative host information.
 */
@interface MobileRTCAlternativeHost : NSObject

@property (nonatomic, retain, readonly) NSString* email;
@property (nonatomic, retain, readonly) NSString* firstName;
@property (nonatomic, retain, readonly) NSString* lastName;
@property (nonatomic, assign, readonly) unsigned long long PMINumber;

- (id)initWithEmailAddress:(nonnull NSString*)emailAddress firstname:(nonnull NSString*)firstName lastName:(nonnull NSString*)lastName PMI:(unsigned long long)PMINumber;
@end
