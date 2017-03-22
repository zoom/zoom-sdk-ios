//
//  MobileRTCMeetingService+AppShare.h
//  MobileRTC
//
//  Created by Robust Hu on 2017/2/27.
//  Copyright © 2017年 Zoom Video Communications, Inc. All rights reserved.
//

#import <MobileRTC/MobileRTC.h>

/**
 * Category AppShare is designed for an App Share meeting 
 *
 */
@interface MobileRTCMeetingService (AppShare)

/**
 * This method is used to tell the client whether the meeting is an app share meeting.
 *
 * @return YES if the meeting is an app share meeting.
 */
- (BOOL)isDirectAppShareMeeting;
/**
 * This method is used to change the view of share content.
 *
 * @param view, the view will be shared.
 */
- (void)appShareWithView:(UIView*)view;

/**
 * This method is used to show UI of meeting.
 *
 * @param completion, can be used to do some action after showing meeting UI.
 */
- (void)showMobileRTCMeeting:(void (^)(void))completion;

/**
 * This method is used to hide UI of meeting.
 *
 * @param completion, can be used to do some action after hiding meeting UI.
 */
- (void)hideMobileRTCMeeting:(void (^)(void))completion;

/**
 * This method is used to start app share.
 */
- (BOOL)startAppShare;

/**
 * This method is used to stop app share.
 */
- (void)stopAppShare;

/**
 * This method is used to tell the client is starting share or not.
 *
 * @return YES if the client is starting share.
 *
 */
- (BOOL)isStartingShare;

/**
 * This method is used to tell the client is viewing share or not.
 *
 * @return YES if the client is viewing share.
 *
 */
- (BOOL)isViewingShare;

@end
