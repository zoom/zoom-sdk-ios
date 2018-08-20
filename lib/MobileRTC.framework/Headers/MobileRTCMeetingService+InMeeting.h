//
//  MobileRTCMeetingService+InMeeting.h
//  MobileRTC
//
//  Created by Robust Hu on 2017/2/27.
//  Copyright © 2017年 Zoom Video Communications, Inc. All rights reserved.
//

#import <MobileRTC/MobileRTC.h>
#import <MobileRTC/MobileRTCMeetingUserInfo.h>
#import <MobileRTC/MobileRTCMeetingChat.h>

/*!
 @brief Category InMeeting is designed for providing interfaces for meeting events
 */
@interface MobileRTCMeetingService (InMeeting)

/*!
 @brief This method is used to tell whether the current user is the host of the meeting or not.
 @return YES, the current user is the host of the meeting
 */
- (BOOL)isMeetingHost;

/*!
 @brief This method is used to tell whether the current user is the cohost of the meeting or not.
 @return YES, the current user is the cohost of the meeting
 */
- (BOOL)isMeetingCoHost;

/*!
 @brief This method is used to tell whether the meeting is locked by host or not.
 @return YES, the meeting has been locked by host.
 */
- (BOOL)isMeetingLocked;

/*!
 @brief This method is used to tell whether the screen share is locked by host or not.
 @return YES, the screen share has been locked by host.
 */
- (BOOL)isShareLocked;

#pragma mark CMR Related
/*!
 @brief This method is used to tell the client whether cloud record is enabled.
 @return YES if cloud record is enabled.
 */
- (BOOL)isCMREnabled;

/*!
 @brief This method is used to tell the client whether cloud record is in progress.
 @return YES if cloud record is in progress.
 */
- (BOOL)isCMRInProgress;

/*!
 @brief This method is used to tell the client whether cloud record is paused.
 @return YES if cloud record is paused.
 */
- (BOOL)isCMRPaused;

/*!
 @brief This method is used to pause/resume cloud record in the meeting.
 @return YES means call this method successfully.
 */
- (BOOL)resumePauseCMR;

/*!
 @brief This method is used to turn on/off cloud record in the meeting.
 @param on if YES to turn on cloud record; if NO to turn off cloud record.
 */
- (void)turnOnCMR:(BOOL)on;

#pragma mark Meeting Info Related
/*!
 @brief This method is used to set customized meeting session key.
 @param keyArray the array of meeting session keys
 @param leave YES means leave meeting directly; NO means not leave meeting
 @return YES means call this method successfully.
 @warning The method is optional.
 */
- (BOOL)handleE2EMeetingKey:(nonnull NSArray*)keyArray withLeaveMeeting:(BOOL)leave;

/*!
 @brief This method is used to get the meeting is external or not.
 @return YES means external meeting.
 @warning The method is optional.
 */
- (BOOL)isExternalMeeting;

/*!
 @brief This method is used to get the meeting is internal or not.
 @return YES means internal meeting.
 @warning The method is optional.
 */
- (BOOL)isInternalMeeting;

/*!
 @brief This method is used to check whether the meeting is failover or not.
 @return YES means failover meeting.
 @warning The method is optional.
 */
- (BOOL)isFailoverMeeting;

/*!
 @brief This method is used to check whether the meeting is Webinar.
 @return YES means Webinar meeting.
 @warning It will return NO as MobileRTCMeetingState is not equal to MobileRTCMeetingState_InMeeting.
 */
- (BOOL)isWebinarMeeting;

/*!
 @brief This method is used to lock meeting.
 @return YES means call this method successfully.
 @warning only meeting host/cohost can run this function.
 */
- (BOOL)lockMeeting:(BOOL)lock;

/*!
 @brief This method is used to query network status in meeting.
 @param type, meeting component type, now we just support to query three components network status:MobileRTCComponentType_AUDIO, MobileRTCComponentType_VIDEO, MobileRTCComponentType_AS
 @param sending, if YES means that query sending data; if NO means that query receiving data
 @return the level of network quality.
 @warning The method is optional, now we just provide query network quality of Audio, Video and Share in meeting.
 */
- (MobileRTCNetworkQuality)queryNetworkQuality:(MobileRTCComponentType)type withDataFlow:(BOOL)sending;

/*!
 @brief This method is used to present Zoom original Meeting Chat ViewController.
 @param parentVC which use to present ViewController
 @return YES means call this method successfully.
 */
- (BOOL)presentMeetingChatViewController:(nonnull UIViewController*)parentVC;

/*!
 @brief This method is used to present Zoom original Pariticipants ViewController.
 @param parentVC which use to present ViewController
 @return YES means call this method successfully.
 */
- (BOOL)presentParticipantsViewController:(nonnull UIViewController*)parentVC;

/*!
 @brief This method is used to config DSCP Value.
 @param audioValue Related Audio Value in meeting
 @param videoValue Related Video Value in meeting
 @return YES means call this method successfully.
 @warning The method should be invoked before start meeting.
 */
- (BOOL)configDSCPWithAudioValue:(NSUInteger)audioValue VideoValue:(NSUInteger)videoValue;

/*!
 @brief This method is used to hide Full Phone Number for Pure Call-IN User.
 @param bHide indicate hide or not.
 @return YES means call this method successfully.
 @warning The method should be invoked before start meeting.
 */
- (BOOL)hideFullPhoneNumberForPureCallInUser:(BOOL)bHide;

#pragma mark Live Stream
/*!
 @brief This method is used to start Live Stream.
 @param streamingURL indicate streaming URL.
 @param key indicate streaming key.
 @param broadcastURL indicate live streaming page URL.
 @return YES means call this method successfully.
 @warning Only meeting host can start live Stream successfully.
 */
- (BOOL)startLiveStreamWithStreamingURL:(nonnull NSString*)streamingURL StreamingKey:(nonnull NSString*)key BroadcastURL:(nonnull NSString*)broadcastURL;
/*!
 @brief This method is used to get live stream URL.
 @return Live Stream Url dictionary if Success.
 @warning only meeting host can run this function, and get correct live stream url.
 For Facebook Live Stream Service, fb_workplace action the key in Dictionary
 For Custom Live Stream Service, custom action the key in Dictionary
 */
- (nullable NSDictionary*)getLiveStreamURL;

/*!
 @brief This method is used to stop live stream.
 @return YES means stop live stream successfully.
 @warning Only meeting host can stop live Stream successfully.
 */
- (BOOL)stopLiveStream;

#pragma mark Display/Hide Meeting UI
/*!
 @brief This method is used to show UI of meeting.
 @param completion can be used to do some action after showing meeting UI.
 @return YES means call this method successfully.
 @warning Method do not works for the condition that you had set mobileRTCRootController via [MobileRTC setMobileRTCRootController]
 */
- (BOOL)showMobileRTCMeeting:(void (^)(void))completion;

/*!
 @brief This method is used to hide UI of meeting.
 @param completion can be used to do some action after hiding meeting UI.
 @return YES means call this method successfully.
 @warning Method do not works for the condition that you had set mobileRTCRootController via [MobileRTC setMobileRTCRootController]
 */
- (BOOL)hideMobileRTCMeeting:(void (^)(void))completion;

#pragma mark - Q&A Related
/*!
 @brief This method is used to check Q&A enabled or not.
 @return YES means Q&A enabled.
 */
- (BOOL)isQAEnabled;

/*!
 @brief This method is used to present Zoom original Q&A ViewController.
 @param parentVC which use to present ViewController
 @return YES means call this method successfully.
 */
- (BOOL)presentQAViewController:(nonnull UIViewController*)parentVC;

@end
