//
//  MobileRTCSMSService.h
//  MobileRTC
//
//  Created by Jackie Chen on 2019/9/23.
//  Copyright © 2019 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MobileRTCMeetingDelegate.h"

/*!
 @brief for real name auth usage.
 @warning country code will used in retrieve and verify handler.
 */
@interface MobileRTCRealNameCountryInfo : NSObject
@property (nonatomic, copy) NSString * _Nullable countryId;
@property (nonatomic, copy) NSString * _Nullable countryName;
@property (nonatomic, copy) NSString * _Nullable countryCode;
@end

/*!
 @brief for send SMS usage.
 @warning if retrieve return NO, please get new retrieve handler 60s later. 'getResendSMSVerificationCodeHandler' in 'MobileRTCSMSService'
 */
@interface MobileRTCRetrieveSMSHandler : NSObject

/*!
 @brief countryCode, counry code in country code list.
 @param phoneNum, your phone number.
 @warning if retrieve return NO, please get new retrieve handler 60s later. 'getResendSMSVerificationCodeHandler' in 'MobileRTCSMSService'
 */
- (BOOL)retrieve:(NSString * _Nullable)countryCode andPhoneNumber:(NSString * _Nullable)phoneNum;

/*!
 @brief cancelAndLeaveMeeting sms
 @warning cancel and leavemb meeting
 */
- (BOOL)cancelAndLeaveMeeting;
@end

/*!
 @brief for verify SMS usage.
 @warning if verify return NO, please get new retrieve handler 60s later.  'getReVerifySMSVerificationCodeHandler' in 'MobileRTCSMSService'
 */
@interface MobileRTCVerifySMSHandler : NSObject

/*!
 @brief countryCode, counry code in country code list.
 @param phoneNum, your phone number.
 @param verifyCode, your received verify code.
 @warning if verify return NO, please get new verify handler 60s later. 'getReVerifySMSVerificationCodeHandler' in 'MobileRTCSMSService'
 */
- (BOOL)verify:(NSString * _Nullable)countryCode phoneNumber:(NSString * _Nullable)phoneNum andVerifyCode:(NSString * _Nullable)verifyCode;

/*!
 @brief cancelAndLeaveMeeting sms
 @warning cancel and leavemb meeting
 */
- (BOOL)cancelAndLeaveMeeting;
@end


/*!
 @brief for SMS service usage like following flow.
 @warning 1.need enable sms service by 'enableZoomAuthRealNameMeetingUIShown'
 @warning 2.try to join meeting or start meeting. if Real Name verify not pass, will call the callback 'onNeedRealNameAuth: privacyURL: retrieveHandle:'
 @warning 3.try to send sms with retrieveHandle, or you can use the retrieve handle cancel and leave the meeting, 'cancelAndLeaveMeeting'
 @warning 4.if success in step 3, pop up the dialog for input the verify code, in the same time, you will receive a sms and a callback 'onRetrieveSMSVerificationCodeResultNotification: verifyHandle:'.
 @warning    if failed, please try to get retrieve handle 60s later, and go to step 3.
 @warning 5.you can verify sms by verifyHandle. or you can cancel and leave meeting. 'cancelAndLeaveMeeting'.
 @warning 6.you will receive callback 'onVerifySMSVerificationCodeResultNotification:' for the verify result.
 */
@interface MobileRTCSMSService : NSObject
@property (nullable, assign, nonatomic) id<MobileRTCSMSServiceDelegate> delegate;

/*!
 @brief enable, pass YES for using the auth real name service. the call back function will called when need.(Judged by sdk logic)
 @warning enable/disable auth real name service.
 */
- (void)enableZoomAuthRealNameMeetingUIShown:(bool)enable;

/*!
 @brief for get new retrieve handle.
 @warning need get new handle 60s later.
 */
- (MobileRTCRetrieveSMSHandler * _Nullable)getResendSMSVerificationCodeHandler;

/*!
 @brief for get new verify handle.
 @warning need get new handle 60s later.
 */
- (MobileRTCVerifySMSHandler * _Nullable)getReVerifySMSVerificationCodeHandler;

/*!
 @brief getSupportPhoneNumberCountryList.
 @warning get country code iist after call join meeting or start meeting interface.
 */
- (NSArray * _Nullable)getSupportPhoneNumberCountryList;

/*!
 @brief set default cellphone for signed account.
 @param countryCode, the user account's country code.
 @param phoneNum, default phoen number.
 @return yes, for set success.
 */
- (BOOL)setDefaultCellPhoneInfo:(NSString * _Nullable)countryCode phoneNum:(NSString * _Nullable)phoneNum;

@end
