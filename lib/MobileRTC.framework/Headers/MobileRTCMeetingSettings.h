//
//  MobileRTCMeetingSettings.h
//  MobileRTC
//
//  Created by Robust Hu on 7/2/15.
//  Copyright (c) 2015 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @class MobileRTCMeetingSettings
 @brief MobileRTCMeetingSettings is designed for changing some settings for meeting.
 */
@interface MobileRTCMeetingSettings : NSObject

/*!
 @brief Show/Hide meeting ID and meeting password in the meeting bar.
 */
@property (assign, nonatomic) BOOL meetingTitleHidden;

/*!
 @brief Show/Hide meeting password in the meeting bar.
 */
@property (assign, nonatomic) BOOL meetingPasswordHidden;

/*!
 @brief Show/Hide the "End/Leave Meeting" button in the meeting bar.
 */
@property (assign, nonatomic) BOOL meetingLeaveHidden;

/*!
 @brief Show/Hide Audio button in the meeting bar.
 */
@property (assign, nonatomic) BOOL meetingAudioHidden;

/*!
 @brief Show/Hide Video button in the meeting bar.
 */
@property (assign, nonatomic) BOOL meetingVideoHidden;

/*!
 @brief Show/Hide Invite button in the meeting bar.
 */
@property (assign, nonatomic) BOOL meetingInviteHidden;

/*!
 @brief Show/Hide Participant button in the meeting bar.
 */
@property (assign, nonatomic) BOOL meetingParticipantHidden;

/*!
 @brief Show/Hide Share button in the meeting bar.
 */
@property (assign, nonatomic) BOOL meetingShareHidden;

/*!
 @brief Show/Hide More button in the meeting bar.
 */
@property (assign, nonatomic) BOOL meetingMoreHidden;

/*!
 @brief Show/Hide Top Bar in the meeting.
 */
@property (assign, nonatomic) BOOL topBarHidden;

/*!
 @brief Show/Hide Bottom Bar in the meeting.
 @warning The Bottom Bar is just available in iPhone.
 */
@property (assign, nonatomic) BOOL bottomBarHidden;

/*!
 @brief Enable/Disable Kubi Device in the meeting.
 @warning The option is just available in iPad for using Kubi device.
 */
@property (assign, nonatomic) BOOL enableKubi;

/*!
 @brief change thumbnail video layout while viewing share in the meeting.
 @discussion YES, the share content will be shrinked and thumbnail video will be shown in the right side in Landscape, or in the bottom side in Portrait; NO, the share content will still in fullscreen mode, the thumbnail video will keep the same as what Zoom iOS app did.
 */
@property (assign, nonatomic) BOOL thumbnailInShare;

/*!
 @brief Show/Hide "Leave Meeting" item in host side.
 */
@property (assign, nonatomic) BOOL hostLeaveHidden;

/*!
 @brief Show/Hide the hint message in meeting.
 */
@property (assign, nonatomic) BOOL hintHidden;

/*!
 @brief Show/Hide the waiting HUD while starting/joining a meeting.
 */
@property (assign, nonatomic) BOOL waitingHUDHidden;

/*!
 @brief Show/Hide "Call out Room System" item in Invite h.323/SIP Room System.
 */
@property (assign, nonatomic) BOOL calloutRoomSystemHidden;

/*!
 @brief Show/Hide "Enter Host Key to Claim Host" item in More Menu.
 */
@property (assign, nonatomic) BOOL claimHostWithHostKeyHidden;

/*!
 @brief Show/Hide Close Caption in a meeting.
 */
@property (assign, nonatomic) BOOL closeCaptionHidden;

/*!
 @brief Enable Csutom In-Meeting UI in meeting.
 */
@property (assign, nonatomic) BOOL enableCustomMeeting;
/*!
 @brief To check whether client join meeting with Internet audio or not.
 @return YES if auto connect internet audio, or return NO.
 */
- (BOOL)autoConnectInternetAudio;

/*!
 @brief Set the option of auto connect internet audio.
 @param connected the option value.
 */
- (void)setAutoConnectInternetAudio:(BOOL)connected;

/*!
 @brief To check whether client will mute internet audio after joined meeting or not.
 @return YES if muted audio, or return NO.
 */
- (BOOL)muteAudioWhenJoinMeeting;

/*!
 @brief To check whether client will mute internet audio after joined meeting or not.
 @param muted the option value.
 */
- (void)setMuteAudioWhenJoinMeeting:(BOOL)muted;

/*!
 @brief To check whether client will mute video after joined meeting or not.
 @return YES if muted video, or return NO.
 */
- (BOOL)muteVideoWhenJoinMeeting;

/*!
 @brief Set the option of mute video after joined meeting.
 @param muted the option value.
 */
- (void)setMuteVideoWhenJoinMeeting:(BOOL)muted;

/*!
 @brief To check whether client disabled Driving Mode or not.
 @return YES if disabled, or return NO.
 */
- (BOOL)driveModeDisabled;

/*!
 @brief Set the option of disabled Driving mode in meeting.
 @param disabled  the option value.
 */
- (void)disableDriveMode:(BOOL)disabled;

/*!
 @brief To check whether client disabled Call In or not.
 @return YES if disabled, or return NO.
 */
- (BOOL)callInDisabled;

/*!
 @brief To check whether client disabled Call In or not.
 @param disabled the option value.
 */
- (void)disableCallIn:(BOOL)disabled;

/*!
 @brief To check whether client disabled Call Out or not.
 @return YES if disabled, or return NO.
 */
- (BOOL)callOutDisabled;

/*!
 @brief Set the option of disabled Call Out in meeting.
 @param disabled the option value.
 */
- (void)disableCallOut:(BOOL)disabled;

@end
