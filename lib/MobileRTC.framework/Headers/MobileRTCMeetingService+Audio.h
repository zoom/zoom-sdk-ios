//
//  MobileRTCMeetingService+Audio.h
//  MobileRTC
//
//  Created by Chao Bai on 2018/6/6.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import <MobileRTC/MobileRTC.h>

@interface MobileRTCMeetingService (Audio)

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
 */
- (MobileRTCAudioOutput)myAudioOutputDescription;

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
 @brief This method is used to check whether MuteOnEntry is on in the meeting.
 @return YES means that MuteOnEntry is on.
 */
- (BOOL)isMuteOnEntryOn;

/*!
 @brief This method is used to set MuteOnEntry n the meeting.
 @return YES means that set MuteOnEntry successfully.
 @warning only meeting host can run this function.
 */
- (BOOL)muteOnEntry:(BOOL)on;

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
 @brief This method is used to check meeting support VOIP or not.
 @return YES means VOIP Supported.
 */
- (BOOL)isSupportedVOIP;

/*!
 @brief This method is used to check PlayChime or not while user join/leave meeting.
 @return YES means that PlayChime is on.
 */
- (BOOL)isPlayChimeOn;

/*!
 @brief This method is used to mute My Audio.
 @param mute: if YES means that mute my audio
 @return mute my audio result.
 */
- (MobileRTCAudioError)muteMyAudio:(BOOL)mute;

/*!
 @brief This method is used to Switch Audio Source.
 */
- (MobileRTCAudioError)switchMyAudioSource;

/*!
 @brief This method is used to reset Meeting Audio Session, which include Category and Mode.
 */
- (void)resetMeetingAudioSession;

@end
