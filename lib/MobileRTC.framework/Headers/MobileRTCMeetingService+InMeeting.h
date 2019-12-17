//
//  MobileRTCMeetingService+InMeeting.h
//  MobileRTC
//
//  Created by Robust Hu on 2017/2/27.
//  Copyright © 2019年 Zoom Video Communications, Inc. All rights reserved.
//

#import <MobileRTC/MobileRTC.h>
#import <MobileRTC/MobileRTCMeetingUserInfo.h>
#import <MobileRTC/MobileRTCMeetingChat.h>

/*!
 @brief Set to provide interfaces for meeting events
 */
@interface MobileRTCMeetingService (InMeeting)

/*!
 @brief Query if the current user is the host of the meeting.
 @return YES means that the current user is the host of the meeting, otherwise not.
 */
- (BOOL)isMeetingHost;

/*!
 @brief Query if the current user is the co-host of the meeting.
 @return YES means that the current user is the co-host of the meeting, otherwise not.
 */
- (BOOL)isMeetingCoHost;

/*!
 @brief Query if the current user is the webinar attendee of the meeting.
 @return YES means that the current user is the webinar attendee of the meeting, otherwise not.
 @warning only for webinar meeting.
 */
- (BOOL)isWebinarAttendee;

/*!
 @brief Query if the current user is the webinar panelist of the meeting.
 @return YES means that the current user is the webinar panelist of the meeting, otherwise not.
 @warning only for webinar meeting.
 */
- (BOOL)isWebinarPanelist;

/*!
 @brief Notify if the meeting is locked by host. Once the meeting is locked, other users out of the meeting can no longer join it.
 @return YES means that the meeting is locked by host, otherwise not.
 */
- (BOOL)isMeetingLocked;

/*!
 @brief Notify if the share is locked by host. Once the meeting is locked by the host/co-host, other user can not share except the host/co-host.
 @return YES means that the screen share is locked by host, otherwise not.
 */
- (BOOL)isShareLocked;

#pragma mark CMR Related
/*!
 @brief Notify if the cloud recording is enabled.
 @return YES means enabled, otherwise not.
 */
- (BOOL)isCMREnabled;

/*!
 @brief Notify if the cloud recording is in progress.
 @return YES means the cloud recording is in progress, otherwise not.
 */
- (BOOL)isCMRInProgress;

/*!
 @brief Notify if the cloud recording is paused.
 @return YES means that the cloud recording is paused, otherwise not.
 */
- (BOOL)isCMRPaused;

/*!
 @brief Set to pause/resume cloud recording in the meeting.
 @return YES means that the method is called successfully, otherwise not.
 */
- (BOOL)resumePauseCMR;

/*!
 @brief Set to turn on/off the cloud recording in the meeting.
 @param on YES means to turn on cloud recording, otherwise not.
 */
- (void)turnOnCMR:(BOOL)on;

#pragma mark Meeting Info Related
/*!
 @brief Set custom meeting session key
 @param keyArray The array of meeting session keys. 
 @param leave YES means leaving meeting directly, otherwise not.
 @return YES means that the method is called successfully, otherwise not.
 @warning The method is optional.
 */
- (BOOL)handleE2EMeetingKey:(nonnull NSArray*)keyArray withLeaveMeeting:(BOOL)leave;

/*!
 @brief Query if the meeting is external or not.
 @return YES means external, otherwise not.
 @warning The method is optional.
 */
- (BOOL)isExternalMeeting;

/*!
 @brief Query if the meeting is internal or not.
 @return YES means internal, otherwise not.
 @warning The method is optional.
 */
- (BOOL)isInternalMeeting;

/*!
 @brief Query if the meeting is failover.
 @return YES means failover, otherwise not.
 @warning The method is optional.
 */
- (BOOL)isFailoverMeeting;

/*!
 @brief Query if the meeting is Webinar.
 @return YES means Webinar, otherwise not.
 @warning It will return NO as MobileRTCMeetingState is not equal to MobileRTCMeetingState_InMeeting.
 */
- (BOOL)isWebinarMeeting;

/*!
 @brief Set to lock the meeting.
 @return YES means that the method is called successfully, otherwise not.
 @warning Only meeting host/co-host can call the function.
 */
- (BOOL)lockMeeting:(BOOL)lock;

/*!
 @brief Set to lock the share.
 @return YES means that the method is called successfully, otherwise not.
 @warning Only meeting host/co-host can call the function.
 */
- (BOOL)lockShare:(BOOL)lock;

/*!
 @brief Check in-meeting network status.
 @param type Meeting component types, now we can only query three components network status: MobileRTCComponentType_AUDIO, MobileRTCComponentType_VIDEO and MobileRTCComponentType_AS
 @param sending, if YES means that query sending data; if NO means that query receiving data
 @return the level of network quality.
 @warning The method is optional, you can query the network quality of audio, video and sharing.
 */
- (MobileRTCNetworkQuality)queryNetworkQuality:(MobileRTCComponentType)type withDataFlow:(BOOL)sending;

/*!
 @brief Set to present Zoom original Meeting Chat ViewController.
 @param parentVC which use to present ViewController.
 @param userId userId of the user you would like to chat.
 @return YES means that the method is called successfully, otherwise not.
 @warning If userId = 0 or nil, it will send to everyone.
 */
- (BOOL)presentMeetingChatViewController:(nonnull UIViewController*)parentVC userId:(NSInteger)userId;

/*!
 @brief Set to present Zoom original Participants ViewController.
 @param parentVC which use to present ViewController
 @return YES means that the method is called successfully, otherwise not.
 */
- (BOOL)presentParticipantsViewController:(nonnull UIViewController*)parentVC;

/*!
 @brief Configure DSCP values for audio and video.
 @param audioValue Audio values in the meeting.
 @param videoValue Video values in the meeting
 @return YES means that the method is called successfully, otherwise not.
 @warning The function should be invoked before meeting starts.
 */
- (BOOL)configDSCPWithAudioValue:(NSUInteger)audioValue VideoValue:(NSUInteger)videoValue;

/*!
 @brief Set to hide the Full Phone Number of purely Call-in User.
 @param bHide YES means hide, otherwise not.
 @return YES means that the method is called successfully, otherwise not.
 @warning The method should be invoked before meeting starts.
 */
- (BOOL)hideFullPhoneNumberForPureCallInUser:(BOOL)bHide;

#pragma mark Live Stream
/*!
 @brief Set to start Live Stream.
 @param streamingURL The live stream URL by which you can live the meeting. 
 @param key Stream key offered by the third platform on which you want to live stream your meeting. 
 @param broadcastURL The URL of live stream page.
 @return YES means that the method is called successfully, otherwise not.
 @warning Only meeting host can start live Stream successfully.
 */
- (BOOL)startLiveStreamWithStreamingURL:(nonnull NSString*)streamingURL StreamingKey:(nonnull NSString*)key BroadcastURL:(nonnull NSString*)broadcastURL;
/*!
 @brief Get live stream server URL.
 @return The dictionary of live stream URL if the function succeeds.
 @warning The function is available only for host. 
 For Facebook Live Stream Service, fb_workplace action the key in Dictionary
 For Custom Live Stream Service, custom action the key in Dictionary
 */
- (nullable NSDictionary*)getLiveStreamURL;

/*!
 @brief Set to stop live streaming.
 @return YES means stopping live streaming successfully, otherwise not.
 @warning The function is available only for host. 
 */
- (BOOL)stopLiveStream;

#pragma mark Display/Hide Meeting UI
/*!
 @brief Set to show UI of meeting.
 @param completion User can do other operations once the meeting UI comes out.
 @return YES means that the method is called successfully, otherwise not.
 @warning The method does not work if you have set mobileRTCRootController via [MobileRTC setMobileRTCRootController]
 */
- (BOOL)showMobileRTCMeeting:(void (^_Nonnull)(void))completion;

/*!
 @brief Set to hide the UI of meeting.
 @param completion User can do other operations once the meeting UI hide.
 @return YES means that the method is called successfully, otherwise not.
 @warning The method does not work if you have set mobileRTCRootController via [MobileRTC setMobileRTCRootController]
 */
- (BOOL)hideMobileRTCMeeting:(void (^_Nonnull)(void))completion;

/*!
 @brief If you add a full-screen view to our zoom meeting UI, you can display the control bar by this method when the control bar is hidden
 @warning The zoom meeting UI is only valid, the customized UI is invalid.
 */
- (void)showMeetingControlBar;

#pragma mark - Q&A Related
/*!
 @brief Query if Q&A is enabled.
 @return YES means that Q&A is enabled, otherwise not.
 */
- (BOOL)isQAEnabled;

/*!
 @brief Set to present Zoom original Q&A ViewController.
 @param parentVC which use to present ViewController
 @return YES means that the method is called successfully, otherwise not.
 */
- (BOOL)presentQAViewController:(nonnull UIViewController*)parentVC;

/*!
 @brief Get current meeting's password
 @return The current meeting's password
 */
- (NSString *_Nullable)getMeetingPassword;

/*!
 @brief call the method to show Minimize meeting when in Zoom UI meeting.
 @warning The method only for Zoom UI.
 */
- (BOOL)showMinimizeMeetingFromZoomUIMeeting;

/*!
 @brief call the methond to back Zoom UI meeting when in minimize meeting.
 @warning The method only for Zoom UI
 */
- (BOOL)backZoomUIMeetingFromMinimizeMeeting;

@end
