//
//  MobileRTCMeetingService+AppShare.h
//  MobileRTC
//
//  Created by Robust Hu on 2017/2/27.
//  Copyright © 2017年 Zoom Video Communications, Inc. All rights reserved.
//

#import <MobileRTC/MobileRTC.h>

/*!
 @brief Category AppShare is designed for an App Share meeting
 */
@interface MobileRTCMeetingService (AppShare)

/*!
 @brief This method is used to tell the client whether the meeting is an app share meeting.
 @return YES if the meeting is an app share meeting
 */
- (BOOL)isDirectAppShareMeeting;

/*!
 @brief This method is used to change the view of share content.
 @param view the view will be shared.
 */
- (void)appShareWithView:(nonnull UIView*)view;

/*!
 @brief This method is used to share content with ReplayKit.
 @discussion This method will take effect in iOS 11 or new.
 @warning After this interface has been called, App UI content should update after about 0.25 second for ReplayKit cannot send out if UI content does not change.
 */
- (void)appShareWithReplayKit;

/*!
 @brief This method is used to start app share.
 @return YES means that start app share successfully.
 */
- (BOOL)startAppShare;

/*!
 @brief This method is used to stop app share.
 */
- (void)stopAppShare;

/*!
 @brief This method is used to tell the client is starting share or not.
 @return YES if the client is starting share.
 */
- (BOOL)isStartingShare;

/*!
 @brief This method is used to tell the client is viewing share or not.
 @return YES if the client is viewing share.
 */
- (BOOL)isViewingShare;

/*!
 @brief This method is used to tell the client if the annotation is available.
 @return YES if the client is available.
 */
- (BOOL)isAnnotationOff;

@end
