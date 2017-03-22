//
//  MobileRTCMeetingService+Customize.h
//  MobileRTC
//
//  Created by Robust Hu on 2017/2/27.
//  Copyright © 2017年 Zoom Video Communications, Inc. All rights reserved.
//

#import <MobileRTC/MobileRTC.h>
#import <MobileRTC/MobileRTCRoomDevice.h>

/**
 * Category Customize is designed for providing interfaces for Dial-out and Call Room Device
 *
 */
@interface MobileRTCMeetingService (Customize)

/**
 * This method is used to customize meeting title for meeting bar while inmeeting status.
 *
 * *Note*: Method need to be call before start or join one meeting & title will be reset after leave/end meeting.
 */
- (void)customizeMeetingTitle:(NSString*)title;

/**
 * This method is used to check whether there exists a dial out in process.
 */
- (BOOL)isDialOutInProgress;

/**
 * This method is used to start a dial out.
 *
 * @param phone, the phone number used to dial out, the phone number should add country code at first, such as "+86123456789".
 * @param me, if YES, means "Call Me"; if NO, means "Invite by Phone".
 * @param username, the display name for invite other by phone. If parameter "me" is YES, the param can be ignored.
 */
- (BOOL)dialOut:(NSString*)phone isCallMe:(BOOL)me withName:(NSString*)username;

/**
 * This method is used to cancel dial out.
 */
- (BOOL)cancelDialOut:(BOOL)isCallMe;

/**
 * This method is used to check whether there exists a call room device in process.
 */
- (BOOL)isCallingRoomDevice;

/**
 * This method is used to cancel call room device.
 */
- (BOOL)cancelCallRoomDevice;

/**
 * This method will return an array of room devices.
 */
- (NSArray*)getRoomDeviceList;

/**
 * This method is used to call in a room device with pairing code.
 */
- (BOOL)sendPairingCode:(NSString*)code;

/**
 * This method is used to call out a room device.
 */
- (BOOL)callRoomDevice:(MobileRTCRoomDevice*)device;

@end
