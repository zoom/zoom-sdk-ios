//
//  MobileRTCMeetingDelegate.h
//  MobileRTC
//
//  Created by Robust on 2017/11/14.
//  Copyright © 2019年 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RTCJoinMeetingActionBlock)(NSString *, NSString *, BOOL);

#pragma mark - MobileRTCMeetingServiceDelegate
/*!
 @protocol MobileRTCMeetingServiceDelegate
 @brief The Meeting Service will issue the following values when the meeting state changes.
 */  
@protocol MobileRTCMeetingServiceDelegate <NSObject>

@optional
/*!
 @brief Specified Meeting Response.
 @param error Internal error code.
 @param internalError Internal error code.
 @waring This callback has been deprecated, please use - (void)onMeetingError:(MobileRTCMeetError)error message:(NSString*)message instead. 
 */
//- (void)onMeetingReturn:(MobileRTCMeetError)error internalError:(NSInteger)internalError;

/*!
 @brief Specified Meeting Errors.
 @param error Internal error code.
 @param message The message for meeting errors.
 */
- (void)onMeetingError:(MobileRTCMeetError)error message:(NSString*)message;

/*!
 @brief Notify the user that the meeting status changes. 
 @param state The meeting status changes.
 */
- (void)onMeetingStateChange:(MobileRTCMeetingState)state;

/*!
 @brief Notify the user that the requirement to join meeting is confirmed.
 */
- (void)onJoinMeetingConfirmed;

/*!
 @brief The meeting is ready.
 */
- (void)onMeetingReady;

/*!
 @brief Join a meeting without host, you can show/hide the custom JBH waiting UI.
 @param cmd Show/Hide JBH command.
 */
- (void)onJBHWaitingWithCmd:(JBHCmd)cmd;

/*!
 @brief Determine if the current user has the cloud recording privilege.  
 @param result The result of checking CMR privilege.
 */
- (void)onCheckCMRPrivilege:(MobileRTCCMRError)result;

/*!
 @brief Meeting is ended by some reasons.
 @param reason The reason why meeting is ended.
 */
- (void)onMeetingEndedReason:(MobileRTCMeetingEndReason)reason;

/*!
 @brief Meeting without host will be ended after some-awhile.
 @param minutes The minutes remaining to end the meeting.
 */
- (void)onNoHostMeetingWillTerminate:(NSUInteger)minutes;

/*!
 @brief Notify user the issues of microphone.
 */
- (void)onMicrophoneStatusError:(MobileRTCMicrophoneError)error;

/*!
 @brief Notify user to provide join meeting information: screen name or meeting password.
 @param displayName User needs to provide screen name to join a meeting.
 @param password User needs to provide meeting password to join a meeting.
 @param cancel Once the user cancels to provide screen name or meeting password, it is canceled to join the meeting.
 */
- (void)onJoinMeetingInfo:(MobileRTCJoinMeetingInfo)info
               completion:(void (^)(NSString *displayName, NSString *password, BOOL cancel))completion;

/*!
 @brief Set to ask user to provide proxy information: username and password.
 @param host Proxy host.
 @param port Proxy port.
 @param completion SDK will ask user to input proxy information once it detects the information changes. 
 */
- (void)onProxyAuth:(NSString*)host
               port:(NSUInteger)port
         completion:(void (^)(NSString *host, NSUInteger port, NSString *username, NSString *password, BOOL cancel))completion;

/*!
 @brief Set if user needs to end another ongoing meeting.
 @param completion Ask user to end another ongoing meeting or not.
 */
- (void)onAskToEndOtherMeeting:(void (^)(BOOL cancel))completion;

/*!
 @brief Notify user that microphone access permission is denied.  
 */
- (void)onMicrophoneNoPrivilege;

/*!
 @brief Notify user that camera access permission is denied. 
 */
- (void)onCameraNoPrivilege;

/*!
 @brief Inform user that free meeting will be ended in 10 minutes.
 @param host YES means the original host of the current meeting, otherwise not.
 @param freeUpgrade YES means the current free meeting will be upgraded. Once upgraded, the current meeting can last for more than 40 minutes.
 @param completion MobileRTC will call the module to upgrade the current meeting once the parameter UPGRADE is YES.
 */
- (void)onFreeMeetingReminder:(BOOL)host
               canFreeUpgrade:(BOOL)freeUpgrade
                   completion:(void (^)(BOOL upgrade))completion;

/*!
 @brief The result of upgrading free meeting.
 @param result ZERO(0) means the upgrade was successful, otherwise it failed.
 */
- (void)onUpgradeFreeMeetingResult:(NSUInteger)result;

/*!
 @brief Customize the invitation event.
 @param parentVC Parent viewcontroller to present custom Invite UI. 
 @param array Add custom InviteActionItem to Invite ActionSheet.
 @return NO if user wants to custom the invite items, add items to Invite ActionSheet via MobileRTCMeetingInviteActionItem. Otherwise YES, user will use the default UI.
 */
- (BOOL)onClickedInviteButton:(UIViewController*)parentVC addInviteActionItem:(NSMutableArray *)array;

/*!
 @brief Customize the audio button clicked event.
 @param parentVC Parent viewcontroller to present custom Invite UI.
 @return YES if user wants to custom the audio button clicked event, Otherwise NO, will use the default method.
 */
- (BOOL)onClickedAudioButton:(UIViewController*)parentVC;

/*!
 @brief Custom the UI of Participants management.
 @param parentVC Parent viewcontroller to present custom Participants UI. 
 */
- (BOOL)onClickedParticipantsButton:(UIViewController*)parentVC;

/*!
 @brief User needs to click the SHARE button in meeting.
 @return NO if user wants to custom Share Action Item, add items to Share ActionSheet via MobileRTCMeetingShareActionItem. Otherwise YES, user will use the default UI.
 */
- (BOOL)onClickedShareButton:(UIViewController*)parentVC addShareActionItem:(NSMutableArray *)array;

/*!
 @brief Custom the UI of Leave Meeting Alert.
 @param parentVC Parent viewcontroller to present custom Participants UI.
 */
- (BOOL)onClickedEndButton:(UIViewController*)parentVC endButton:(UIButton *)endButton;

/*!
 @brief Notify users that there is no sharing for the moment.
 */
- (void)onOngoingShareStopped;

/*!
 @brief Customize outgoing call interface.
 @param parentVC Parent viewcontroller to present outgoing call UI.
 @param me YES means to CALL ME; NO means INVITE BY PHONE.
 */
- (void)onClickedDialOut:(UIViewController*)parentVC isCallMe:(BOOL)me;

/*!
 @brief Callback event that outgoing call status changes.  
 @param status Notify user the outgoing call status.
 */
- (void)onDialOutStatusChanged:(DialOutStatus)status;

/*!
 @brief Callback event while calling H.323 device, and you should input the pairing code.
 @param state ZERO(0) means pairing successfully, otherwise failed.
 */
- (void)onSendPairingCodeStateChanged:(MobileRTCH323ParingStatus)state MeetingNumber:(unsigned long long)meetingNumber;

/*!
 @brief Callback event when Room Device state changes. 
 @param state Notify user the status of calling Room Device.
 */
- (void)onCallRoomDeviceStateChanged:(H323CallOutStatus)state;

/*!
 @brief Callback event of new message.
 @param messageID The message ID.
 */
- (void)onInMeetingChat:(NSString*)messageID;

/*!
 @brief Notify user if the meeting is end to end. 
 @param key The meeting session key.
 */
- (void)onWaitExternalSessionKey:(NSData*)key;

/*!
 @brief Callback event that live stream status changes. 
 */
- (void)onLiveStreamStatusChange:(MobileRTCLiveStreamStatus)liveStreamStatus;

/*!
 @brief Callback event that ZAK expired.
 */
- (void)onZoomIdentityExpired;

/*!
 @brief Callback event that user clicks the sharing screen.
 @param parentVC Parent viewcontroller to present the view of Sharing Screen Usage Guide.
 @waring Application will present Share Screen Usage Guide.
 */
- (void)onClickShareScreen:(UIViewController*)parentVC;

/*!
 @brief Callback event that user receives the Closed Caption.
 */
- (void)onClosedCaptionReceived:(NSString*)message;

/*!
 @brief Callback event that waiting room status changes. 
 */
- (void)onWaitingRoomStatusChange:(BOOL)needWaiting;
@end

#pragma mark - MobileRTCAudioServiceDelegate
/*!
 @protocol MobileRTCAudioServiceDelegate
 @brief An Audio Service will issue the following values when the meeting audio changes.
 */
@protocol MobileRTCAudioServiceDelegate <MobileRTCMeetingServiceDelegate>

/*!
 @brief Callback event that the participant's audio status changes. 
 @return UserID The ID of user whose audio status changes.
 */
- (void)onSinkMeetingAudioStatusChange:(NSUInteger)userID;

/*!
 @brief Callback event that the audio type of the current user changes. 
 */
- (void)onSinkMeetingMyAudioTypeChange;

/*!
 @brief Callback event that the output type of the current user's audio source changes. 
 */
- (void)onAudioOutputChange;

/*!
 @brief Callback event that the audio state of the current user changes.
 */
- (void)onMyAudioStateChange;
@end

#pragma mark - MobileRTCVideoServiceDelegate
/*!
 @protocol MobileRTCVideoServiceDelegate
 @brief A video service will issue the following values when the meeting video changes.
 */
@protocol MobileRTCVideoServiceDelegate <MobileRTCMeetingServiceDelegate>

/*!
 @brief The function will be invoked once the active video status changes. 
 @return The ID of user whose video is active at present.  
 */
- (void)onSinkMeetingActiveVideo:(NSUInteger)userID;

/*!
 @brief The function will be invoked once the participant's video status changes.
 @return The ID of user whose video status changes.
 */
- (void)onSinkMeetingVideoStatusChange:(NSUInteger)userID;

/*!
 @brief Callback event that my video state changes. 
 */
- (void)onMyVideoStateChange;

/*!
 @brief Callback event that the video status of spotlight user changes. Spotlight user means that the view will show only the specified user and won't change even other speaks.
 @param on YES means spotlight hotspot; NO means spotlight falloff.
 */
- (void)onSpotlightVideoChange:(BOOL)on;

/*!
 @brief Notify user that preview video is stopped by SDK. Usually the video will show the user himself when there is no other user joins.
 @waring The method MobileRTCPreviewVideoView will stop render, and App will adjust UI. Remove MobileRTCPreviewVideoView instance if it is necessary.
 */
- (void)onSinkMeetingPreviewStopped;

/*!
 @brief Callback event of active video changes when there is a new speaker. 
 @return UserID of new speaker.
 */
- (void)onSinkMeetingActiveVideoForDeck:(NSUInteger)userID;

/*!
 @brief Notify that user's video quality changes.
 @return The quality of the Video and the UserID.
 */
- (void)onSinkMeetingVideoQualityChanged:(MobileRTCNetworkQuality)qality userID:(NSUInteger)userID;

/*!
 @brief Callback event that host requests to unmute the user's video. 
 */
- (void)onSinkMeetingVideoRequestUnmuteByHost:(void (^)(BOOL Accept))completion;
@end

#pragma mark - MobileRTCUserServiceDelegate
/*!
 @protocol MobileRTCUserServiceDelegate
 @brief Callback event when the attendee's status changes. 
 */
@protocol MobileRTCUserServiceDelegate <MobileRTCMeetingServiceDelegate>

/*!
 @brief Callback event that the current user's hand state changes.
 */
- (void)onMyHandStateChange;

/*!
 @brief Callback event that the user state is updated in meeting.
 */
- (void)onInMeetingUserUpdated;

/*!
 @brief The function will be invoked once the user joins the meeting.
 @return The ID of user who joins the meeting.
 */
- (void)onSinkMeetingUserJoin:(NSUInteger)userID;

/*!
 @brief The function will be invoked once the user leaves the meeting.
 @return The ID of user who leaves the meeting.
 */
- (void)onSinkMeetingUserLeft:(NSUInteger)userID;

/*!
 @brief The function will be invoked once user raises hand.
 @return The ID of user who raises hand.
 */
- (void)onSinkMeetingUserRaiseHand:(NSUInteger)userID;

/*!
 @brief The function will be invoked once user lowers hand.
 @return The ID of user who lowers hand.
 */
- (void)onSinkMeetingUserLowerHand:(NSUInteger)userID;

/*!
 @brief Notify user that meeting host changes.
 @param hostId The user ID of host.
 */
- (void)onMeetingHostChange:(NSUInteger)hostId;

/*!
 @brief Callback event that co-host changes.
 @param cohostId The user ID of co-host.
 */
- (void)onMeetingCoHostChange:(NSUInteger)cohostId;

/*!
 @brief Callback event that user claims the host.
 */
- (void)onClaimHostResult:(MobileRTCClaimHostError)error;
@end

#pragma mark - MobileRTCShareServiceDelegate
/*!
 @protocol MobileRTCShareServiceDelegate
 @brief Callback event when the meeting sharing status changes.
 */
@protocol MobileRTCShareServiceDelegate <MobileRTCMeetingServiceDelegate>

/*!
 @brief Callback event of starting a meeting by sharing.
 */
- (void)onAppShareSplash;

/*!
 @brief Callback event when the share starts.
 @return The user ID of presenter. 
 @warning userID == 0, which means that the user stopped sharing.
 */
- (void)onSinkMeetingActiveShare:(NSUInteger)userID;

/*!
 @brief Callback event when the sharing content changes.  
 @return The user ID of presenter. 
 */
- (void)onSinkMeetingShareReceiving:(NSUInteger)userID;

/*!
 @brief Callback event when presenter resizes the sharing content. 
 @return New size of the shared content and UserID
 */
- (void)onSinkShareSizeChange:(NSUInteger)userID;

@end

#pragma mark - MobileRTCWebinarServiceDelegate
/*!
 @protocol MobileRTCWebinarServiceDelegate
 @brief Callback event when the Webinar changes.
 */
@protocol MobileRTCWebinarServiceDelegate <MobileRTCMeetingServiceDelegate>

/*!
 @brief Callback event when Question and Answer(Q&A) conneAnswerction starts.【【【可能要XX】】】
 */
- (void)onSinkQAConnectStarted;

/*!
 @brief Callback event when Q&A is connected/disconnected.
 @param connected The flag of Q&A is connected/disconnected.
 */
- (void)onSinkQAConnected:(BOOL)connected;

/*!
 @brief Callback event when the open-ended question changes.
 @param count The amount of open-ended questions.
 */
- (void)onSinkQAOpenQuestionChanged:(NSInteger)count;

/*!
 @brief Callback event of the permission that user is allowed to ask questions anonymously is changed.
 @return YES means that user can ask question anonymously, otherwise not.
 */
- (void)onSinkQAAllowAskQuestionAnonymouslyNotification:(BOOL)beAllowed;

/*!
 @brief Callback event of the permission that attendee is allowed to view all questions is changed.
 @return YES means that user can view all questions, otherwise not.
 */
- (void)onSinkQAAllowAttendeeViewAllQuestionNotification:(BOOL)beAllowed;

/*!
 @brief Callback event of the permission that attendee is allowed to submit questions is changed.
 @return YES means that the user can submit questions, otherwise not.
 */
- (void)onSinkQAAllowAttendeeUpVoteQuestionNotification:(BOOL)beAllowed;

/*!
 @brief Callback event of the permission that user is allowed to answer questions is changed.
 @return YES means that user can answer question, otherwise not.
 */
- (void)onSinkQAAllowAttendeeAnswerQuestionNotification:(BOOL)beAllowed;

/*!
 @brief Callback event that user joins a webinar which requires manual approval.
 @param registerURL The register URL.
 */
- (void)onSinkWebinarNeedRegister:(NSString *)registerURL;

/*!
 @brief Callback event that user joins a webinar which requires username and email.
 @param cancel Cancel to join meeting if user does not provide screen name or meeting password.
 @param completion User needs to provide username and email to join meeting. 
 */
- (void)onSinkJoinWebinarNeedUserNameAndEmailWithCompletion:(BOOL (^_Nonnull)(NSString * _Nonnull username, NSString * _Nonnull email, BOOL cancel))completion;

/*!
 @brief The function will be invoked once the amount of panelist exceed the upper limit.
 */
- (void)onSinkPanelistCapacityExceed;

/*!
 @brief The function will be invoked once the amount of the attendee is promoted successfully from attendee to panelist.
 @return errorCode Promotion successful or error type.
 */
- (void)onSinkPromptAttendee2PanelistResult:(MobileRTCWebinarPromoteorDepromoteError)errorCode;

/*!
 @brief The function will be invoked when panelist is demoted successfully from panelist to attendee.
 @return errorCode Demotion successful or error type.
 */
- (void)onSinkDePromptPanelist2AttendeeResult:(MobileRTCWebinarPromoteorDepromoteError)errorCode;

/*!
 @brief The function will be invoked when the chat privilege of attendees changes.
 @return currentPrivilege The chat privilege of the current attendee.
 */
- (void)onSinkAllowAttendeeChatNotification:(MobileRTCChatAllowAttendeeChat)currentPrivilege;
@end

#pragma mark - MobileRTCCustomizedUIMeetingDelegate
/*!
 @protocol MobileRTCCustomizedUIMeetingDelegate
 @brief The class that conform to the MobileRTCCustomizedUIMeetingDelegate protocol can provide
        methods for tracking the In-Meeting Event and determining policy for each Event.
 @discussion The MobileRTCCustomizedUIMeetingDelegate protocol is required in the custom meeting UI view.
 */ 
@protocol MobileRTCCustomizedUIMeetingDelegate <NSObject>

@required
/*!
 @brief Notify user to create a custom in-meeting UI. 
 */
- (void)onInitMeetingView;

/*!
 @brief Notify user to destroy the custom in-meeting UI. 
 */
- (void)onDestroyMeetingView;

@end



