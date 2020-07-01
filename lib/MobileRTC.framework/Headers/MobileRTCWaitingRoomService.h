//
//  MobileRTCWaitingRoomService.h
//  MobileRTC
//
//  Created by Zoom Video Communications on 2019/3/6.
//  Copyright © 2019 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @class MobileRTCWaitingRoomServiceDelegate
 @brief Meeting host enabled the waiting room feature, then the delegate will receive this notification  #only for custom UI#.
 */
@protocol MobileRTCWaitingRoomServiceDelegate <NSObject>
@optional

/*!
 @class MobileRTCWaitingRoomServiceDelegate
 @brief Meeting host enabled the waiting room feature, then the delegate will receive this notification  #only for custom UI#.
         onWaitingRoomUserJoin: will notify the host someone entery the waiting room.
         onWaitingRoomUserLeft: will notify the host someone left from waiting room.
 */
- (void)onWaitingRoomUserJoin:(NSUInteger)userId;
- (void)onWaitingRoomUserLeft:(NSUInteger)userId;
@end

@interface MobileRTCWaitingRoomService : NSObject

/*!
 @brief Waiting Room service delegate.
 */
@property (nullable, assign, nonatomic) id<MobileRTCWaitingRoomServiceDelegate> delegate;

/*!
 @brief Is this meeting support Waiting Room feature.
 @return Yes if support waiting room.
 */
-(BOOL)isSupportWaitingRoom;

/*!
 @brief Is this meeting enabled Waiting Room feature.
 @return Yes if enabled.
 */
-(BOOL)isWaitingRoomOnEntryFlagOn;

/*!
 @brief enable or disable waiting room feature of this meeting.
 @return the result of this operation.
 */
- (MobileRTCMeetError)enableWaitingRoomOnEntry:(BOOL)bEnable;

/*!
 @brief get the waiting room user id list.
 @return waiting room user list.
 */
- (nullable NSArray *)waitingRoomList;

/*!
 @brief get the user detail information in waiting room.
 @return waiting room user information.
 */
- (nullable MobileRTCMeetingUserInfo*)waitingRoomUserInfoByID:(NSUInteger)userId;

/*!
 @brief admit the user go to meeting fram waiting room.
 @return the result of this operation.
 @warning Only meeting host/co-host can run the function.
 */
- (BOOL)admitToMeeting:(NSUInteger)userId;

/*!
 @brief put the user to waiting room from meeting.
 @return the result of this operation.
 @warning Only meeting host/co-host can run the function.
 */
- (BOOL)putInWaitingRoom:(NSUInteger)userId;

@end
