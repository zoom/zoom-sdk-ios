//
//  MobileRTCMeetingService+Customize.h
//  MobileRTC
//
//  Created by Robust Hu on 2017/2/27.
//  Copyright © 2019年 Zoom Video Communications, Inc. All rights reserved.
//

#import <MobileRTC/MobileRTC.h>
#import <MobileRTC/MobileRTCRoomDevice.h>
#import <MobileRTC/MobileRTCCallCountryCode.h>

/*!
 @brief Provide interfaces for outgoing calls and Call Room Device.
 */
@interface MobileRTCMeetingService (Customize)

/*!
 @brief Set to customize the meeting title/topic which will be displayed in the meeting bar. 
 @param title The topic/title of the meeting.
 @warning User should call the method before starting or joining the meeting if he wants to reset the title/topic of the meeting.
 */
- (void)customizeMeetingTitle:(NSString * _Nullable)title;

/*!
 @brief Query if user can dial out in the meeting.
 @return YES means able, No disable.
 */
- (BOOL)isDialOutSupported;

/*!
 @brief Query if there is any outgoing call in process.
 @return YES means that there is outgoing call in process.
 */
- (BOOL)isDialOutInProgress;

/*!
 @brief Start to dial out.
 @param phone The phone number of destination, you should add the country code in front of the phone number, such as +86123456789.
 @param me YES means Call Me; NO means inviting others by Phone.
 @param username The name of the user to be called. 
 @return YES means the method is called successfully, otherwise not.
 */
- (BOOL)dialOut:(nonnull NSString*)phone isCallMe:(BOOL)me withName:(nullable NSString*)username;

/*!
 @brief Cancel to dial out.
 @param isCallMe YES means Call Me; NO means inviting others by Phone.
 @return YES means the method is called successfully, otherwise not.
 */
- (BOOL)cancelDialOut:(BOOL)isCallMe;

/*!
 @brief Query if it is able to Call Room device(H.323).
 @return YES means able, otherwise not.
 */
- (BOOL)isCallRoomDeviceSupported;

/*!
 @brief Query if it is in process to call room device.
 @return YES means calling room device in process, otherwise not. 
 */
- (BOOL)isCallingRoomDevice;

/*!
 @brief Cancel to call room device.
 @return YES means the method is called successfully, otherwise not.
 */
- (BOOL)cancelCallRoomDevice;

/*!
 @brief Get an array of IP Addresses of room device which is used for calling.
 @return The array of IP Address; if there is no existed IP Address, it will return nil.
 */
- (nullable NSArray*)getIPAddressList;

/*!
 @brief Get the password of the meeting running on H.323 device.
 @return The meeting password. If no meeting is running, it will return nil.
 */
- (nullable NSString*)getH323MeetingPassword;

/*!
 @brief Get room devices that can be called. 
 @return The array of room devices. If there is no any room device. it will return nil.
 */
- (nullable NSArray*)getRoomDeviceList;

/*!
 @brief Get the pairing code when the room device call in. 
 @param code The pairing code which enable the device connect to the meeting.
 @param meetingNumber The number of meeting.
 @return YES means the method is called successfully, otherwise not.
 @warning App can invite Room System while App is in Meeting or in pre-Meeting.
 */
- (BOOL)sendPairingCode:(nonnull NSString*)code WithMeetingNumber:(unsigned long long)meetingNumber;

/*!
 @brief The user calls out to invite the room device. 
 @param device The room device.
 @return YES means the method is called successfully, otherwise not.
 */
- (BOOL)callRoomDevice:(nonnull MobileRTCRoomDevice*)device;

/*!
 @brief Get Participant ID.
 @return The Participant ID.
 */
- (NSUInteger)getParticipantID;

/*!
 @brief Get countrycode for the current user's locale.
 @return The object of MobileRTCCallCountryCode for user's locale.
 */
- (nullable MobileRTCCallCountryCode *)getDialInCurrentCountryCode;

/*!
 @brief Get all countrycodes
 @return The array of all countrycode.
 */

- (nullable NSArray *)getDialInAllCountryCodes;

/*!
 @brief Get to the countrycode specified by countryId
 @return The array of countrycode.
 */

- (nullable NSArray *)getDialInCallCodesWithCountryId:(nullable NSString *)countryId;

/*!
 @brief Make a phone call to access your voice
 @return YES means the method is called successfully, otherwise not.
 */
- (BOOL)dialInCall:(nullable NSString *)countryNumber;

@end
