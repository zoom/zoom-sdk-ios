//
//  MobileRTCMeetingSettings.h
//  MobileRTC
//
//  Created by Zoom Video Communications on 7/2/15.
//  Copyright (c) 2019 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @class MobileRTCMeetingSettings
 @brief Set to modify the configurations of the meeting.
 */
@interface MobileRTCMeetingSettings : NSObject

/*!
 @brief Show/Hide meeting title in the meeting bar. 
 */
@property (assign, nonatomic) BOOL meetingTitleHidden;

/*!
 @brief Show/Hide meeting title in the meeting bar.
 */
@property (assign, nonatomic) BOOL meetingPasswordHidden;

/*!
 @brief Show/Hide the END/LEAVE MEETING button in the meeting bar.
 */
@property (assign, nonatomic) BOOL meetingLeaveHidden;

/*!
 @brief Show/Hide AUDIO button in the meeting bar.
 */
@property (assign, nonatomic) BOOL meetingAudioHidden;

/*!
 @brief Show/Hide VIDEO button in the meeting bar.
 */
@property (assign, nonatomic) BOOL meetingVideoHidden;

/*!
 @brief Show/Hide INVITE button in the meeting bar.
 */
@property (assign, nonatomic) BOOL meetingInviteHidden;

/*!
 @brief Show/Hide Chat in the meeting bar.
 */
@property (assign, nonatomic) BOOL meetingChatHidden;

/*!
 @brief Show/Hide PARTICIPANT button in the meeting bar.
 */
@property (assign, nonatomic) BOOL meetingParticipantHidden;

/*!
 @brief Show/Hide SHARE button in the meeting bar.
 */
@property (assign, nonatomic) BOOL meetingShareHidden;

/*!
 @brief Show/Hide MORE button in the meeting bar.
 */
@property (assign, nonatomic) BOOL meetingMoreHidden;

/*!
 @brief Show/Hide the BAR ON THE TOP of view in the meeting.
 */
@property (assign, nonatomic) BOOL topBarHidden;

/*!
 @brief Show/Hide BAR at the bottom of the view in the meeting.
 @warning The BAR at the bottom of the view is available on iPhone.
 */
@property (assign, nonatomic) BOOL bottomBarHidden;

/*!
 @brief Show/Hide disconnect audio button
 */
@property (assign, nonatomic) BOOL disconnectAudioHidden;

/*!
 @brief Enable/Disable Kubi Device in the meeting.
 @warning The option is available only on iPad if you want to use Kubi device. 
 */
@property (assign, nonatomic) BOOL enableKubi;

/*!
 @brief Change thumbnail video layout while viewing a share in the meeting.
 @warning If you set it to YES, the video of attendees will be placed at right of the Landscape(the device screen is oriented horizontally) or the bottom of Portrait(the device screen is oriented vertically) apart from the shared content, which means the video won't cover the content; if you set to NO, it will show only the video of active speaker and the video will be placed in the bottom right of the screen.
 */
@property (assign, nonatomic) BOOL thumbnailInShare;

/*!
 @brief Show/Hide LEAVE MEETING item for the host.
 */
@property (assign, nonatomic) BOOL hostLeaveHidden;

/*!
 @brief Show/Hide the hint message in the meeting.
 */
@property (assign, nonatomic) BOOL hintHidden;

/*!
 @brief Show/Hide the waiting HUD while starting/joining a meeting.
 */
@property (assign, nonatomic) BOOL waitingHUDHidden;

/*!
 @brief Show/Hide "Call in Room System" item in Invite h.323/SIP Room System.
 */
@property (assign, nonatomic) BOOL callinRoomSystemHidden;

/*!
 @brief Show/Hide "Call out Room System" item in Invite h.323/SIP Room System.
 */
@property (assign, nonatomic) BOOL calloutRoomSystemHidden;

/*!
 @brief Show/Hide "Enter Host Key to Claim Host" item in Menu More.
 */
@property (assign, nonatomic) BOOL claimHostWithHostKeyHidden;

/*!
 @brief Show/Hide CLOSE CAPTION in a meeting.
 */
@property (assign, nonatomic) BOOL closeCaptionHidden;

/*!
 @brief Show/Hide Q&A button in webinar meeting.
 */
@property (assign, nonatomic) BOOL qaButtonHidden;

/*!
 @brief Show/Hide "Promote to Panelist" in webinar meeting.
 @warning Only host/co-host can see the option in webinar meeting‘s participants.
 */
@property (assign, nonatomic) BOOL promoteToPanelistHidden;

/*!
@brief Show/Hide "Change to Attendee" in webinar meeting.
@warning Only host/co-host can see the option in webinar meeting‘s participants.
*/
@property (assign, nonatomic) BOOL changeToAttendeeHidden;

/*!
 @brief Enable/Disable Proximity Sensors Monitoring in a meeting. 
 */
@property (assign, nonatomic) BOOL proximityMonitoringDisable;

/*!
 @brief Enable Custom In-Meeting UI in meeting.
 */
@property (assign, nonatomic) BOOL enableCustomMeeting;
/*!
 @brief Query if the user joins meeting with audio device. 
 @return YES means the audio device is automatically connected, otherwise not. 
 */
- (BOOL)autoConnectInternetAudio;

/*!
 @brief Set to auto-connect the audio when user joins meeting. 
 @param connected The option value.
 */
- (void)setAutoConnectInternetAudio:(BOOL)connected;

/*!
 @brief Query if user's audio is muted when he joins the meeting. 
 @return YES means muted, otherwise not.
 */
- (BOOL)muteAudioWhenJoinMeeting;

/*!
 @brief Set to mute user's audio when he joins the meeting. 
 @param muted YES means to mute the audio, otherwise not.
 */
- (void)setMuteAudioWhenJoinMeeting:(BOOL)muted;

/*!
 @brief Query if user's video is muted when he joins the meeting. 
 @return YES means muted, otherwise not.
 */
- (BOOL)muteVideoWhenJoinMeeting;

/*!
 @brief Set to mute user's video when he joins the meeting. 
 @param muted YES means to mute the video, otherwise not.
 */
- (void)setMuteVideoWhenJoinMeeting:(BOOL)muted;

/*!
 @brief Query Touch up my appearance enable or not
 @param muted YES means enable, otherwise not.
 */
- (BOOL)faceBeautyEnabled;

/*!
 @brief Set Touch up my appearance enable or not
 @param muted YES means successful, otherwise not.
 */
- (void)setFaceBeautyEnabled:(BOOL)enable;

/*!
 @brief Query if driving mode is disabled.
 @return YES means muted, otherwise not.
 */
- (BOOL)driveModeDisabled;

/*!
 @brief Set to disable the Driving mode in the meeting.
 @param disabled YES means disabled, otherwise not.
 */
- (void)disableDriveMode:(BOOL)disabled;

/*!
 @brief Query if Gallery View is disabled.
 @return YES means muted, otherwise not.
 */
- (BOOL)galleryViewDisabled;

/*!
 @brief Set to disable the Gallery View in the meeting.
 @param disabled YES means disabled, otherwise not.
 */
- (void)disableGalleryView:(BOOL)disabled;

/*!
 @brief Query if it is disabled to call in.
 @return YES means disabled, otherwise not.
 */
- (BOOL)callInDisabled;

/*!
 @brief Set to disable the incoming calls.
 @param disabled The option value.
 */
- (void)disableCallIn:(BOOL)disabled;

/*!
 @brief Query if it is disabled to call out.
 @return YES means disabled, otherwise not.
 */
- (BOOL)callOutDisabled;

/*!
 @brief Set to disable the outgoing calls. 
 @param disabled The option value.
 */
- (void)disableCallOut:(BOOL)disabled;

/*!
 @brief Query if it is disabled to Minimize Meeting.
 @return YES means disabled, otherwise not.
 */
- (BOOL)minimizeMeetingDisabled;

/*!
 @brief Set to disable the Minimize Meeting.
 @param disabled The option value.
 */
- (void)disableMinimizeMeeting:(BOOL)disabled;

/*!
 @brief Query Meeting setting of speaker off when present meeting.
 @return YES means speaker off, otherwise not.
 */
- (BOOL)speakerOffWhenInMeeting;

/*!
 @brief Set speaker off.  Default value is No, Need set to NO when not used.
 @param YES means speaker off, otherwise not
 */
- (void)setSpeakerOffWhenInMeeting:(BOOL)speakerOff;

/*!
 @brief Query show meeting elapse time.
 @return YES means show meeting elapse time, otherwise not.
 */
- (BOOL)showMyMeetingElapseTime;

/*!
 @brief Enable show meeting elapse time.
 @param enable YES means show meeting elapse time, otherwise not.
 */
- (void)enableShowMyMeetingElapseTime:(BOOL)enable;

/*!
@brief Query mic original input enable or not.
@return YES means mic original input enable, otherwise not.
*/
- (BOOL)micOriginalInputEnabled;

/*!
 @brief Enable mic original input.
 @param enable YES means enable mic original input, otherwise not.
 */
- (void)enableMicOriginalInput:(BOOL)enable;

/*!
@brief Set the visibility of reaction on meeting UI. Default is displaying.
@param hidden YES means hide reaction emotion.
*/
- (void)hideReactionsOnMeetingUI:(BOOL)hidden;

/*!
@brief Query if it is disabled to show video preview when join meeting.
@return YES means disabled, otherwise not.
*/
- (BOOL)showVideoPreviewWhenJoinMeetingDisabled;

/*!
@brief Set to disable show video preview when join meeting.
@param disabled The option value.
*/
- (void)disableShowVideoPreviewWhenJoinMeeting:(BOOL)disabled;

/*!
@brief pre populate webinar registration info.
@param email registration email address.
@param username registration username.
*/
- (void)prePopulateWebinarRegistrationInfo:(nonnull NSString *)email username:(nonnull NSString *)username;
@end
