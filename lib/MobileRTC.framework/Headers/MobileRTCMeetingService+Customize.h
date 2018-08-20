//
//  MobileRTCMeetingService+Customize.h
//  MobileRTC
//
//  Created by Robust Hu on 2017/2/27.
//  Copyright © 2017年 Zoom Video Communications, Inc. All rights reserved.
//

#import <MobileRTC/MobileRTC.h>
#import <MobileRTC/MobileRTCRoomDevice.h>

/*!
 @brief Category Customize is designed for providing interfaces for Dial-out and Call Room Device
 */
@interface MobileRTCMeetingService (Customize)

/*!
 @brief This method is used to customize meeting title for meeting bar while inmeeting status.
 @param title the customized content for title
 @warning Method need to be call before start or join one meeting & title will be reset after leave/end meeting.
 */
- (void)customizeMeetingTitle:(NSString*)title;

/*!
 @brief This method is used to check whether Dial out is supported in meeting.
 @return YES means supported
 */
- (BOOL)isDialOutSupported;

/*!
 @brief This method is used to check whether there exists a dial out in process.
 @return YES means that a dial out in process.
 */
- (BOOL)isDialOutInProgress;

/*!
 @brief This method is used to start a dial out.
 @param phone the phone number used to dial out, the phone number should add country code at first, such as "+86123456789".
 @param me YES means "Call Me"; NO means "Invite by Phone".
 @param username the display name for invite other by phone. If parameter "me" is YES, the param can be ignored.
 @return YES means call this method successfully.
 */
- (BOOL)dialOut:(nonnull NSString*)phone isCallMe:(BOOL)me withName:(nullable NSString*)username;

/*!
 @brief This method is used to cancel dial out.
 @param isCallMe YES means "Call Me"
 @return YES means call this method successfully.
 */
- (BOOL)cancelDialOut:(BOOL)isCallMe;

/*!
 @brief This method is used to check whether Call Room Device is supported in meeting.
 @return YES means supported
 */
- (BOOL)isCallRoomDeviceSupported;

/*!
 @brief This method is used to check whether there exists a call room device in process.
 @return YES means that a call room device in process.
 */
- (BOOL)isCallingRoomDevice;

/*!
 @brief This method is used to cancel call room device.
 @return YES means call this method successfully.
 */
- (BOOL)cancelCallRoomDevice;

/*!
 @brief This method will return an array of IP Addresses for Call in a room device.
 @return the array of ip address list; or return nil, if there does not exist any IP Address.
 */
- (nullable NSArray*)getIPAddressList;

/*!
 @brief This method will return a meeting password for call in a room device.
 @return meeting password for call H323 device; return nil means on password.
 */
- (nullable NSString*)getH323MeetingPassword;

/*!
 @brief This method will return an array of room devices for call out a room device.
 @return the array of room devices; or return nil, if there does not exist any room device.
 */
- (nullable NSArray*)getRoomDeviceList;

/*!
 @brief This method is used to call in a room device with pairing code.
 @param code the pairing code
 @return YES means call this method successfully.
 */
- (BOOL)sendPairingCode:(nonnull NSString*)code;

/*!
 @brief This method is used to call out a room device.
 @param device the room device
 @return YES means call this method successfully.
 */
- (BOOL)callRoomDevice:(nonnull MobileRTCRoomDevice*)device;

@end
