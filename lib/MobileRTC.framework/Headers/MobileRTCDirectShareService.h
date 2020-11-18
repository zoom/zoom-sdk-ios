//
//  MobileRTCDirectShareService.h
//  MobileRTC
//
//  Created by Zoom Video Communications on 2020/10/20.
//  Copyright © 2020 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
@brief Direct sharing by meeting ID or pairing code helper interface.
*/
@interface MobileRTCDirectShareViaMeetingIDOrPairingCodeHandler : NSObject
/*!
@brief Try to match with the specified meeting number.
@param meetingNumber Specifies the meeting number.
@return The result of the function.
*/
- (BOOL)TryWithMeetingNumber:(NSString *_Nonnull)meetingNumber;

/*!
@brief Try to match with the pairing code.
@param pairingCode Specifies the pairing code.
@return The result of the function.
*/
- (BOOL)TryWithPairingCode:(NSString *_Nonnull)pairingCode;

/*!
@brief Delete the present direct sharing..
@return The result of the function.
*/
- (BOOL)cancel;
@end

@protocol MobileRTCDirectShareServiceDelegate <NSObject>
@optional
/*!
@brief The callback event will be triggered if the status of direct sharing changes.
@param status Specifies the status of direct sharing. For more details, see MobileRTCDirectShareStatus.
@param handler A pointer to the MobileRTCDirectShareViaMeetingIDOrPairingCodeHandler. It is only valid when the value of status is MobileRTCDirectShareStatus_Need_MeetingID_Or_PairingCode.The SDK user must set the value of the pairingCode or meetingNumber via the functions of MobileRTCDirectShareViaMeetingIDOrPairingCodeHandler to start direct sharing. For more details, see IDirectShareViaMeetingIDOrPairingCodeHandler.
*/
- (void)onDirectShareStatusUpdate:(MobileRTCDirectShareStatus)status handler:(MobileRTCDirectShareViaMeetingIDOrPairingCodeHandler  *_Nullable)handler;
@end

/*!
@brief Direct sharing helper Interface.
@warning You can only use this feature over iOS12
*/
@interface MobileRTCDirectShareService : NSObject
/*!
@class MobileRTCDirectShareServiceDelegate
@brief Direct sharing helper callback.
*/
@property (assign, nonatomic) id<MobileRTCDirectShareServiceDelegate> _Nullable delegate;

/*!
@brief Determine if it is able to start the direct sharing.
@return The result of the operation.
*/
- (BOOL)canStartDirectShare;

/*!
@brief Determine if direct sharing is in progress.
@return The result of the function.
*/
- (BOOL)isDirectShareInProgress;

/*!
@brief Start direct sharing.
@return The result of the function.
*/
- (BOOL)startDirectShare;

/*!
@brief Stop direct sharing.
@return The result of the function.
*/
- (BOOL)stopDirectShare;
@end


