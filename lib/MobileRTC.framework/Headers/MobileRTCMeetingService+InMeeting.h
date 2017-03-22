//
//  MobileRTCMeetingService+InMeeting.h
//  MobileRTC
//
//  Created by Robust Hu on 2017/2/27.
//  Copyright © 2017年 Zoom Video Communications, Inc. All rights reserved.
//

#import <MobileRTC/MobileRTC.h>
#import <MobileRTC/MobileRTCMeetingUserInfo.h>

/**
 * Category InMeeting is designed for providing interfaces for meeting events
 *
 */
@interface MobileRTCMeetingService (InMeeting)

/**
 * This method is used to tell whether the current user is the host of the meeting or not.
 *
 * @return YES, the current user is the host of the meeting.
 */
- (BOOL)isMeetingHost;

/**
 * This method is used to tell whether the meeting is locked by host or not.
 *
 * @return YES, the meeting has been locked by host.
 */
- (BOOL)isMeetingLocked;

/**
 * This method is used to tell the client whether the meeting audio existed or not.
 *
 * @return YES if the meeting audio does not exist.
 */
- (BOOL)isNoMeetingAudio;

/**
 * This method is used to pause/resume audio in the meeting.
 *
 * @param pause, if YES to pause audio; if NO to resume audio.
 */
- (BOOL)pauseMeetingAudio:(BOOL)pause;

/**
 * This method is used to tell the client whether cloud record is enabled.
 *
 * @return YES if cloud record is enabled.
 */
- (BOOL)isCMREnabled;

/**
 * This method is used to tell the client whether cloud record is in progress.
 *
 * @return YES if cloud record is in progress.
 */
- (BOOL)isCMRInProgress;

/**
 * This method is used to tell the client whether cloud record is paused.
 *
 * @return YES if cloud record is paused.
 */
- (BOOL)isCMRPaused;

/**
 * This method is used to pause/resume cloud record in the meeting.
 *
 * @return YES mean that the action take into effect.
 */
- (BOOL)resumePauseCMR;

/**
 * This method is used to turn on/off cloud record in the meeting.
 *
 * @param on, if YES to turn on cloud record; if NO to turn off cloud record.
 */
- (void)turnOnCMR:(BOOL)on;

/**
 * This method is used to get audio type of myself in meeting.
 *
 * @return 0:voip; 1:telephony; 2:none.
 */
- (MobileRTCAudioType)myAudioType;

/**
 * This method is used to retrieve user's auido output.
 *
 * @return the dscription of audio output.
 *
 * *Note*: description of audio output in meeting as following.
 * "Speaker Off"
 * "Speaker On"
 * "Headphones"
 * "Bluetooth"
 */
- (NSString*)currentAudioOutputDescription;

/**
 * This method is used to check my auido is muted or not.
 *
 * @return YES means that audio is muted.
 */
- (BOOL)isMyAudioMuted;

/**
 * This method is used to check user can unmute his auido or not.
 *
 * @return YES means that can unmute.
 */
- (BOOL)canUnmuteMyAudio;

/**
 * This method is used to check user is sending his video or not.
 *
 * @return YES means that video is sending.
 */
- (BOOL)isSendingMyVideo;

/**
 * This method is used to check user can unmute his video or not.
 *
 * @return YES means that can unmute.
 */
- (BOOL)canUnmuteMyVideo;

/**
 * This method is used to check user is using back camera or not.
 *
 * @return YES means that Back camera is using.
 */
- (BOOL)isBackCamera;

/**
 * This method is used to raise my hand.
 *
 * @return YES to raise hand.
 */
- (BOOL)raiseMyHand;

/**
 * This method is used to lower user's hand.
 *
 * @return YES to lower hand.
 */
- (BOOL)lowerHand:(NSUInteger)userId;

/**
 * This method is used to lower all users' hand.
 *
 * @return YES to lower hand.
 *
 * *Note*: only meeting host can run this function.
 */
- (BOOL)lowerAllHand;

/**
 * This method is used to check chat is disabled in meeting or not.
 *
 * @return YES means that chat is disabled.
 */
- (BOOL)isChatDisabled;

/**
 * This method is used to change user's display name in meeting.
 *
 * @param inputName, the display name which will be used in meeting.
 * @param userId, user's ID in meeting.
 */
- (BOOL)changeName:(NSString*)inputName withUserID:(NSUInteger)userId;

/**
 * This method is used to tell whether the screen share is locked by host or not.
 *
 * @return YES, the screen share has been locked by host.
 */
- (BOOL)isShareLocked;

/**
 * This method is used to get all the users in the meeting.
 *
 * @return user list array, each user is a MobileRTCMeetingUserInfo object.
 */
- (NSArray*)getInMeetingUserList;

/**
 * This method is used to get my user id in the meeting.
 *
 * @return my user id.
 */
- (NSUInteger)getMyUserID;

/**
 * This method is used to get my user info in the meeting.
 *
 * @return my user info, a MobileRTCMeetingUserInfo object.
 */
- (MobileRTCMeetingUserInfo*)getMyUserInfo;

/**
 * This method is used to check the user's video pinned or not.
 *
 * @param userId, the user id in meeting.
 */
- (BOOL)isUserVideoPinned:(NSUInteger)userId;

/**
 * This method is used to pin the user's video or not.
 *
 * @param on, if YES to pin user's video; if NO to cancel pin user's video.
 * @param userId, the user id in meeting.
 */
- (BOOL)pinVideo:(BOOL)on withUser:(NSUInteger)userId;

/**
 * This method is used to assign host role to another user in the meeting.
 *
 * @param userId, the user id in meeting.
 *
 * *Note*: the user should not be myself, and can assign the host role .
 */
- (BOOL)makeHost:(NSUInteger)userId;

/**
 * This method is used to remove a user in the meeting.
 *
 * @param userId, the user id in meeting.
 *
 */
- (BOOL)removeUser:(NSUInteger)userId;

/**
 * This method is used to check whether MuteOnEntry is on in the meeting.
 *
 * @return YES means that MuteOnEntry is on.
 */
- (BOOL)isMuteOnEntryOn;

/**
 * This method is used to check PlayChime or not while user join/leave meeting.
 *
 * @return YES means that PlayChime is on.
 */
- (BOOL)isPlayChimeOn;

/**
 * This method is used to get active video user id in the meeting.
 *
 * @return active video user id.
 */
- (NSUInteger)activeVideoUserID;

/**
 * This method is used to get active share user id in the meeting.
 *
 * @return active share user id.
 */
- (NSUInteger)activeShareUserID;

/**
 * This method is used to judge the same user.
 *
 * @param user1, user2, the user id in meeting.
 */
- (BOOL)isSameUser:(NSUInteger)user1 compareTo:(NSUInteger)user2;

/**
 * This method is used to check the user is host or not.
 *
 * @return YES means host.
 */
- (BOOL)isHostUser:(NSUInteger)userID;

/**
 * This method is used to check the user is myself or not.
 *
 * @return YES means myself.
 */
- (BOOL)isMyself:(NSUInteger)userID;

@end
