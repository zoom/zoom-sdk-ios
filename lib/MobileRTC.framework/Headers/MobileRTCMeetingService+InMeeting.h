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
 @brief This method is used to tell whether the meeting is locked by host or not.
 @return YES, the meeting has been locked by host.
 */
- (BOOL)isMeetingLocked;

/*!
 @brief This method is used to tell whether the screen share is locked by host or not.
 @return YES, the screen share has been locked by host.
 */
- (BOOL)isShareLocked;

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

/*!
 @brief This method is used to get my audio type in meeting.
 @return my audio type
 */
- (MobileRTCAudioType)myAudioType;

/*!
 @brief This method is used to connect/disconnect my audio in the meeting.
 @param on if YES to connect audio; if NO to disconnect audio.
 @return YES means call this method successfully.
 */
- (BOOL)connectMyAudio:(BOOL)on;

/*!
 @brief This method is used to retrieve my auido output.
 @return the dscription of audio output.
 @warning description of audio output in meeting as following:
    "Speaker Off"
    "Speaker On"
    "Headphones"
    "Bluetooth"
 */
- (NSString*)myAudioOutputDescription;

/*!
 @brief This method is used to check my auido is muted or not.
 @return YES means that audio is muted.
 */
- (BOOL)isMyAudioMuted;

/*!
 @brief This method is used to check user can unmute his auido or not.
 @return YES means that can unmute.
 */
- (BOOL)canUnmuteMyAudio;

/*!
 @brief This method is used to check user is sending his video or not.
 @return YES means that video is sending.
 */
- (BOOL)isSendingMyVideo;

/*!
 @brief This method is used to check user can unmute his video or not.
 @return YES means that can unmute.
 */
- (BOOL)canUnmuteMyVideo;

/*!
 @brief This method is used to check user is using back camera or not.
 @return YES means that Back camera is using.
 */
- (BOOL)isBackCamera;

/*!
 @brief This method is used to raise my hand.
 @return YES means call this method successfully.
 */
- (BOOL)raiseMyHand;

/*!
 @brief This method is used to lower user's hand.
 @return YES means call this method successfully.
 */
- (BOOL)lowerHand:(NSUInteger)userId;

/*!
 @brief This method is used to lower all users' hand.
 @return YES means call this method successfully.
 @warning only meeting host can run this function.
 */
- (BOOL)lowerAllHand;

/*!
 @brief This method is used to check chat is disabled in meeting or not.
 @return YES means that chat is disabled.
 */
- (BOOL)isChatDisabled;

/*!
 @brief This method is used to change user's display name in meeting.
 @param inputName the display name which will be used in meeting.
 @param userId user's ID in meeting.
 @return YES means call this method successfully.
 @warning Non-Host user can change self name, Host can change other attendee's name.
 */
- (BOOL)changeName:(NSString*)inputName withUserID:(NSUInteger)userId;

/*!
 @brief This method is used to get all the users in the meeting.
 @return user id array, each user id is a NSNumber object.
 */
- (NSArray*)getInMeetingUserList;

/*!
 @brief This method is used to get user info in the meeting.
 @param userId user's ID in meeting.
 @return user info, a MobileRTCMeetingUserInfo object.
 */
- (MobileRTCMeetingUserInfo*)userInfoByID:(NSUInteger)userId;

/*!
 @brief This method is used to check the user's video spotlighted or not.
 @param userId user's ID in meeting.
 @return YES means the user's video is spotlighted.
 */
- (BOOL)isUserSpotlighted:(NSUInteger)userId;

/*!
 @brief This method is used to spotlight the user's video or not.
 @param on if YES to spotlight user's video; if NO to cancel spotlight user's video.
 @param userId the user id in meeting.
 @return YES means call this method successfully.
 @warning only meeting host can run this function, and userId should not be myself.
 */
- (BOOL)spotlightVideo:(BOOL)on withUser:(NSUInteger)userId;

/*!
 @brief This method is used to assign host role to another user in the meeting.
 @param userId the user id in meeting.
 @return YES means call this method successfully.
 @warning only meeting host can run this function, and userId should not be myself.
 */
- (BOOL)makeHost:(NSUInteger)userId;

/*!
 @brief This method is used to remove a user in the meeting.
 @param userId the user id in meeting.
 @return YES means call this method successfully.
 @warning only meeting host can run this function, and userId should not be myself.
 */
- (BOOL)removeUser:(NSUInteger)userId;

/*!
 @brief This method is used to check whether MuteOnEntry is on in the meeting.
 @return YES means that MuteOnEntry is on.
 */
- (BOOL)isMuteOnEntryOn;

/*!
 @brief This method is used to check PlayChime or not while user join/leave meeting.
 @return YES means that PlayChime is on.
 */
- (BOOL)isPlayChimeOn;

/*!
 @brief This method is used to get my user id in the meeting.
 @return my user id.
 */
- (NSUInteger)myselfUserID;

/*!
 @brief This method is used to get active user id in the meeting.
 @return active user id.
 */
- (NSUInteger)activeUserID;

/*!
 @brief This method is used to get active share user id in the meeting.
 @return active share user id.
 */
- (NSUInteger)activeShareUserID;

/*!
 @brief This method is used to judge the same user.
 @param user1 the user id in meeting
 @param user2 the user id in meeting
 @return YES means the same user.
 */
- (BOOL)isSameUser:(NSUInteger)user1 compareTo:(NSUInteger)user2;

/*!
 @brief This method is used to check the user is host or not.
 @param userID the user id in meeting
 @return YES means host.
 */
- (BOOL)isHostUser:(NSUInteger)userID;

/*!
 @brief This method is used to check the user is myself or not.
 @param userID the user id in meeting
 @return YES means myself.
 */
- (BOOL)isMyself:(NSUInteger)userID;

/*!
 @brief This method is used to check the user audio is muted or not.
 @param userID the user id in meeting
 @return YES means audio muted.
 */
- (BOOL)isUserAudioMuted:(NSUInteger)userID;

/*!
 @brief This method is used to mute/numute user's audio.
 @param mute YES means mute; NO means unmute
 @param userID the user id in meeting
 @return YES means call this method successfully.
 @warning only meeting host can run this function.
 */
- (BOOL)muteUserAudio:(BOOL)mute withUID:(NSUInteger)userID;

/*!
 @brief This method is used to mute all other users' audio.
 @param allowSelfUnmute YES means allow self unmute; NO means cannot self unmute
 @return YES means call this method successfully.
 @warning only meeting host can run this function.
 */
- (BOOL)muteAllUserAudio:(BOOL)allowSelfUnmute;

/*!
 @brief This method is used to unmute all other users' audio.
 @return YES means call this method successfully.
 @warning only meeting host can run this function.
 */
- (BOOL)unmuteAllUserAudio;

/*!
 @brief This method is used to check the user video is sending or not.
 @param userID the user id in meeting
 @return YES means video is sending.
 */
- (BOOL)isUserVideoSending:(NSUInteger)userID;

/*!
 @brief This method is used to stop user's video.
 @param userID the user id in meeting, the userID should not be host himself
 @return YES means call this method successfully.
 @warning only meeting host can run this function.
 */
- (BOOL)stopUserVideo:(NSUInteger)userID;

/*!
 @brief This method is used to ask to start user's video.
 @param userID the user id in meeting, the userID should not be host himself
 @return YES means call this method successfully.
 @warning only meeting host can run this function.
 */
- (BOOL)askUserStartVideo:(NSUInteger)userID;

/*!
 @brief This method is used to get chat content in meeting.
 @param messageID the message ID in meeting chat
 @return an instance of meeting chat.
 @warning The method is optional.
 */
- (MobileRTCMeetingChat*)meetingChatByID:(NSString*)messageID;

/*!
 @brief This method is used to set customized meeting session key.
 @param keyArray the array of meeting session keys
 @param leave YES means leave meeting directly; NO means not leave meeting
 @return YES means call this method successfully.
 @warning The method is optional.
 */
- (BOOL)handleE2EMeetingKey:(NSArray*)keyArray withLeaveMeeting:(BOOL)leave;

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
 @brief This method is used to query network status in meeting.
 @param type, meeting component type, now we just support to query three components network status:MobileRTCComponentType_AUDIO, MobileRTCComponentType_VIDEO, MobileRTCComponentType_AS
 @param sending, if YES means that query sending data; if NO means that query receiving data
 @return the level of network quality.
 @warning The method is optional, now we just provide query network quality of Audio, Video and Share in meeting.
 */
- (MobileRTCNetworkQuality)queryNetworkQuality:(MobileRTCComponentType)type withDataFlow:(BOOL)sending;

/*!
 @brief This method is used to mute My Video.
 @param mute indicate the status wanted to swicth
 @return YES means call this method successfully.
 */
- (BOOL)muteMyVideo:(BOOL)mute;

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

/*!
 @brief This method is used to get live stream URL.
 @return Live Stream Url dictionary if Success.
 @warning only meeting host can run this function, and get correct live stream url.
 For Facebook Live Stream Service, fb_workplace action the key in Dictionary
 For Custom Live Stream Service, custom action the key in Dictionary
 */
- (NSDictionary*)getLiveStreamURL;

/*!
 @brief This method is used to stop live stream.
 @return YES means stop live stream successfully.
 @warning only meeting host can run this function, and get correct live stream url.
 */
- (BOOL)stopLiveStreamURL;

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

@end
