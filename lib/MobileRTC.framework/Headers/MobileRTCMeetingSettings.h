//
//  MobileRTCMeetingSettings.h
//  MobileRTC
//
//  Created by Robust Hu on 7/2/15.
//  Copyright (c) 2015 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MobileRTCMeetingSettings : NSObject

/**
 * Show/Hide meeting ID and meeting password in the meeting bar
 */
@property (assign, nonatomic) BOOL meetingTitleHidden;

/**
 * Show/Hide the "End/Leave Meeting" button in the meeting bar
 */
@property (assign, nonatomic) BOOL meetingLeaveHidden;

/**
 * Show/Hide Audio button in the meeting bar
 */
@property (assign, nonatomic) BOOL meetingAudioHidden;

/**
 * Show/Hide Video button in the meeting bar
 */
@property (assign, nonatomic) BOOL meetingVideoHidden;

/**
 * Show/Hide Invite button in the meeting bar
 */
@property (assign, nonatomic) BOOL meetingInviteHidden;

/**
 * Show/Hide Participant button in the meeting bar
 */
@property (assign, nonatomic) BOOL meetingParticipantHidden;

/**
 * Show/Hide Share button in the meeting bar
 */
@property (assign, nonatomic) BOOL meetingShareHidden;

/**
 * Show/Hide More button in the meeting bar
 */
@property (assign, nonatomic) BOOL meetingMoreHidden;

/**
 * Show/Hide Top Bar in the meeting.
 */
@property (assign, nonatomic) BOOL topBarHidden;

/**
 * Show/Hide Bottom Bar in the meeting
 *
 * *Note*: The Bottom Bar is just available in iPhone.
 */
@property (assign, nonatomic) BOOL bottomBarHidden;

/**
 * Enable/Disable Kubi Device in the meeting
 *
 * *Note*: The option is just available in iPad for using Kubi device.
 */
@property (assign, nonatomic) BOOL enableKubi;

/**
 * Show/Hide Thumbnail Video while viewing/starting share in the meeting
 */
@property (assign, nonatomic) BOOL thumbnailHidden;

/**
 * Show/Hide "Leave Meeting" item in host side
 */
@property (assign, nonatomic) BOOL hostLeaveHidden;

/**
 * Show/Hide the hint message in meeting
 */
@property (assign, nonatomic) BOOL hintHidden;

/**
 * To check whether client join meeting with Internet audio or not
 *
 * @return YES if auto connect internet audio, or return NO.
 */
- (BOOL)autoConnectInternetAudio;

/**
 * Set the option of auto connect internet audio.
 *
 * @param connected, the option value.
 */
- (void)setAutoConnectInternetAudio:(BOOL)connected;

/**
 * To check whether client will mute internet audio after joined meeting or not
 *
 * @return YES if muted audio, or return NO.
 */
- (BOOL)muteAudioWhenJoinMeeting;

/**
 * Set the option of mute audio after joined meeting.
 *
 * @param muted, the option value.
 */
- (void)setMuteAudioWhenJoinMeeting:(BOOL)muted;

/**
 * To check whether client will mute video after joined meeting or not
 *
 * @return YES if muted video, or return NO.
 */
- (BOOL)muteVideoWhenJoinMeeting;

/**
 * Set the option of mute video after joined meeting.
 *
 * @param muted, the option value.
 */
- (void)setMuteVideoWhenJoinMeeting:(BOOL)muted;

/**
 * To check whether client disabled Driving Mode or not
 *
 * @return YES if disabled, or return NO.
 */
- (BOOL)driveModeDisabled;

/**
 * Set the option of disabled Driving mode in meeting.
 *
 * @param disabled, the option value.
 */
- (void)disableDriveMode:(BOOL)disabled;

/**
 * To check whether client disabled Call In or not
 *
 * @return YES if disabled, or return NO.
 */
- (BOOL)callInDisabled;

/**
 * Set the option of disabled Call In in meeting.
 *
 * @param disabled, the option value.
 */
- (void)disableCallIn:(BOOL)disabled;

/**
 * To check whether client disabled Call Out or not
 *
 * @return YES if disabled, or return NO.
 */
- (BOOL)callOutDisabled;

/**
 * Set the option of disabled Call Out in meeting.
 *
 * @param disabled, the option value.
 */
- (void)disableCallOut:(BOOL)disabled;

@end
