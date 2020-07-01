//
//  MobileRTCMeetingService+AppShare.h
//  MobileRTC
//
//  Created by Zoom Video Communications on 2017/2/27.
//  Copyright © 2019年 Zoom Video Communications, Inc. All rights reserved.
//

#import <MobileRTC/MobileRTC.h>

/*!
 @brief Starts an App share meeting.
 */
@interface MobileRTCMeetingService (AppShare)

/*!
 @brief Query if the current meeting is enabled with App share. 
 @return YES means that meeting starts by App share, otherwise not.
 */
- (BOOL)isDirectAppShareMeeting;

/*!
 @brief Share a content.
 @param view The view shared.
 @warning view, recommend to pass a single UIView's object, such as UIView, UIImageView or WKWebView.
 @warning It is not recommended to pass UIView after add subview WKWebView or UIImageView.
 */
- (void)appShareWithView:(nonnull id)view;

/*!
 @brief Share content with ReplayKit.
 @warning Available only for iOS 11 version minimum.
 @warning Once the interface has been called, the view will be updated 2.5s later than the operation. ReplayKit won't send the view out if the UI content does not change.
 */
- (void)appShareWithReplayKit DEPRECATED_ATTRIBUTE;

/*!
 @brief Set to enable App share.
 @return YES means starting App share successfully, otherwise not.
 */
- (BOOL)startAppShare;

/*!
 @brief Set to stop App share.
 */
- (void)stopAppShare;

/*!
 @brief Notify the current user if he is sharing. 
 @return YES means that the current user is sharing, otherwise not.
 */
- (BOOL)isStartingShare;

/*!
 @brief Notify the current user if he is viewing the share.
 @return YES means that user is viewing the share, otherwise not.
 */
- (BOOL)isViewingShare;

/*!
 @brief Notify the current user if he can annotate.
 @return YES means able, otherwise not.
 */
- (BOOL)isAnnotationOff;

/*!
 @brief suspend sharing.
 @return YES means sucessful, otherwise not.
 @warning When the customer goes to share a content, consider the pressure of device performance, and use this method to pause share when UI changes, and resume share when UI changes stop, see WebViewController.m in sample project.
 */
- (BOOL)suspendSharing:(BOOL)suspend;

@end
