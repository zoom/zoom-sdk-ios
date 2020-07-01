//
//  MobileRTCMeetingService+Audio.h
//  MobileRTC
//
//  Created by Zoom Video Communications on 2018/6/6.
//  Copyright © 2019 Zoom Video Communications, Inc. All rights reserved.
//

#import <MobileRTC/MobileRTC.h>

@interface MobileRTCMeetingService (Audio)

/*!
 @brief Get the in-meeting audio type of the current user.
 @return The audio type.
 */
- (MobileRTCAudioType)myAudioType;

/*!
 @brief Set whether to connect the audio in the meeting.
 @param on YES means to connect, otherwise not.
 @return YES means that the method is called successfully, otherwise not.
 */
- (BOOL)connectMyAudio:(BOOL)on;

/*!
 @brief Set to retrieve the audio output type of the current user.
 @return The descriptions of audio output types.
 */
- (MobileRTCAudioOutput)myAudioOutputDescription;

/*!
 @brief Query if the audio of the current user is muted.
 @return YES means muted, otherwise not.
 */
- (BOOL)isMyAudioMuted;

/*!
 @brief Query if the user can unmute his audio.
 @return YES means that he can unmute his audio, otherwise not.
 */
- (BOOL)canUnmuteMyAudio;

/*!
 @brief Query if is enabled to mute attendees when they join the meeting. 
 @return YES means enabled, otherwise not.
 */
- (BOOL)isMuteOnEntryOn;

/*!
 @brief Set if attendees join the meeting with audio muted. 
 @return YES means muted, otherwise not.
 @warning Only meeting host can run the function.
 */
- (BOOL)muteOnEntry:(BOOL)on;

/*!
 @brief Query if the user's audio is muted.
 @param userID The ID of user to be checked.
 @return YES means muted, otherwise not.
 */
- (BOOL)isUserAudioMuted:(NSUInteger)userID;

/*!
 @brief Set whether to mute user's audio.
 @param mute YES means to mute, otherwise not.
 @param userID The ID of user.
 @return YES means that the method is called successfully, otherwise not.
 @warning Only meeting host can run the function.
 */
- (BOOL)muteUserAudio:(BOOL)mute withUID:(NSUInteger)userID;

/*!
 @brief Set to mute audio of all attendees.
 @param allowSelfUnmute YES means that attendee can unmute the audio himself, otherwise not.
 @return YES means that the method is called successfully, otherwise not.
 @warning Only meeting host can run the function.
 */
- (BOOL)muteAllUserAudio:(BOOL)allowSelfUnmute;

/*!
 @brief Query if the meeting supports VoIP.
 @return YES means supported, otherwise not.
 */
- (BOOL)isSupportedVOIP;

/*!
 @brief Query if chime is enabled when user joins/leaves meeting.
 @return YES means enabled, otherwise not.
 */
- (BOOL)isPlayChimeOn;

/*!
 @brief Set whether chime are enabled when the user joins/leaves meeting.
 @return YES means enabled, otherwise not.
 @warning Only meeting host/cohost can run the function when in meeting.
 */
- (BOOL)playChime:(BOOL)on;

/*!
 @brief Set to mute the audio of the current user.
 @param mute YES means the audio is muted, otherwise not.
 @return The result of operation, muted or not.
 */
- (MobileRTCAudioError)muteMyAudio:(BOOL)mute;

/*!
 @brief Set to switch audio source of the current user.
 */
- (MobileRTCAudioError)switchMyAudioSource;

/*!
 @brief Reset Meeting Audio Session including Category and Mode.
 */
- (void)resetMeetingAudioSession;

/*!
 @brief Reset Meeting Audio Session including Category and Mode. When the call comes in or goes out, click hold or swap in the dial-up UI to restore the zoom sound.
 */
- (void)resetMeetingAudioForCallKitHeld;

@end
