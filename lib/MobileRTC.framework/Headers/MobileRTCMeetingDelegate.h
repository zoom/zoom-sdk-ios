//
//  MobileRTCMeetingDelegate.h
//  MobileRTC
//
//  Created by Robust on 2017/11/14.
//  Copyright © 2017年 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RTCJoinMeetingActionBlock)(NSString *, NSString *, BOOL);

#pragma mark - MobileRTCMeetingServiceDelegate
/*!
 @protocol MobileRTCMeetingServiceDelegate
 @brief An Meeting Service will issue the following value when the meeting state changes
 */
@protocol MobileRTCMeetingServiceDelegate <NSObject>

@optional
/*!
 @brief Designated for Meeting Response.
 @param error tell client related to this meeting event.
 @param internalError internal error code
 @waring This callback has been deprecated, please use - (void)onMeetingError:(MobileRTCMeetError)error message:(NSString*)message instead.
 */
//- (void)onMeetingReturn:(MobileRTCMeetError)error internalError:(NSInteger)internalError;

/*!
 @brief Designated for Meeting Error message.
 @param error internal error code.
 @param message the message for meeting error
 */
- (void)onMeetingError:(MobileRTCMeetError)error message:(NSString*)message;

/*!
 @brief Designated for Meeting State Change.
 @param state tell client meeting state chagne.
 */
- (void)onMeetingStateChange:(MobileRTCMeetingState)state;

/*!
 @brief Designated for Join meeting confirmed from web.
 */
- (void)onJoinMeetingConfirmed;

/*!
 @brief Designated for Meeting has been ready.
 */
- (void)onMeetingReady;

/*!
 @brief Designated for join a none-host meeting, Partner can show/hide a customized JBH waiting UI..
 @param cmd JBHCmd_Show or JBHCmd_Hide
 */
- (void)onJBHWaitingWithCmd:(JBHCmd)cmd;

/*!
 @brief Designated for checking cloud recording privilege result..
 @param result, the result of checking CMR privilege.
 */
- (void)onCheckCMRPrivilege:(MobileRTCCMRError)result;

/*!
 @brief Designated for Meeting was ended by some reason..
 @param reason, the reason of meeting ended.
 */
- (void)onMeetingEndedReason:(MobileRTCMeetingEndReason)reason;

/*!
 @brief Designated for No Host Meeting will be terminated after minutes..
 @param minutes, the minutes of meeting will be terminated.
 */
- (void)onNoHostMeetingWillTerminate:(NSUInteger)minutes;

/*!
 @brief Designated for prompt user microphone issues
 */
- (void)onMicrophoneStatusError:(MobileRTCMicrophoneError)error;

/*!
 @brief Designated for need user to provide join meeting info: display name, meeting password.
 @param confirmed when user provide display name or meeting password, continue to join meeting.
 @param cancelled when user cancel to provide display name or meeting password, cancel to join meeting.
 */
- (void)onJoinMeetingInfo:(MobileRTCJoinMeetingInfo)info
               completion:(void (^)(NSString *displayName, NSString *password, BOOL cancel))completion;

/*!
 @brief Designated for need user to provide proxy information: username, password.
 @param host proxy host.
 @param port proxy port.
 @param completion ask user to input proxy info, and determine to set proxy or not.
 */
- (void)onProxyAuth:(NSString*)host
               port:(NSUInteger)port
         completion:(void (^)(NSString *host, NSUInteger port, NSString *username, NSString *password, BOOL cancel))completion;

/*!
 @brief Designated for need user to end other ongoing meeting or not.
 @param completion ask user to end other meeting or not.
 */
- (void)onAskToEndOtherMeeting:(void (^)(BOOL cancel))completion;

/*!
 @brief Designated for tell user no microphone access privilege .
 */
- (void)onMicrophoneNoPrivilege;

/*!
 @brief Designated for tell user no camera access privilege .
 */
- (void)onCameraNoPrivilege;

/*!
 @brief Designated for Free meeting will be ended after 10 minutes.
 @param host, YES means the original host of this meeting.
 @param freeUpgrade, YES means this free meeting can be upgraded. And after upgrade this meeting can last more than 40 minutes.
 @param completion mobileRTC will call this block to upgrade this meeting if param "upgrade" is YES.
 */
- (void)onFreeMeetingReminder:(BOOL)host
               canFreeUpgrade:(BOOL)freeUpgrade
                   completion:(void (^)(BOOL upgrade))completion;

/*!
 @brief Designated for Upgrade free meeting result.
 @param result, 0 means success, or failed to upgrade.
 */
- (void)onUpgradeFreeMeetingResult:(NSUInteger)result;

/*!
 @brief Designated for customize the Invite event.
 @param parentVC parent viewcontroller to present customize Invite UI.
 @param array add Customized InviteActionItem into Invite ActionSheet
 @return Condition that Customer handled this action, MobileRTC need not popup invite menu, return YES; Condition that add Customized InviteActionItem via MobileRTCMeetingInviteActionItem into Invite ActionSheet, return NO
 @waring - (void)onClickedInviteButton:(UIViewController*)parentVC has been deprecated, please use - (BOOL)onClickedInviteButton:(UIViewController*)parentVC addInviteActionItem:(NSMutableArray *)array instead.
 */
- (BOOL)onClickedInviteButton:(UIViewController*)parentVC addInviteActionItem:(NSMutableArray *)array;

/*!
 @brief Designated for customize the Participants event.
 @param parentVC parent viewcontroller to present customize Participants UI.
 */
- (BOOL)onClickedParticipantsButton:(UIViewController*)parentVC;

/*!
 @brief Designated for clicked the Share button in meeting.
 @return YES, customer handled this action, MobileRTC need not popup share menu; NO, customer ignored this action, MobileRTC take care this action and still popup share menu.
 @return Condition that Customer handled this action, MobileRTC need not popup share menu, return YES; Condition that add Customized Share Action Item via MobileRTCMeetingShareActionItem into Share ActionSheet, return NO
 @waring - (BOOL)onClickedShareButton has been deprecated, please use - (BOOL)onClickedShareButton:(UIViewController*)parentVC addShareActionItem:(NSMutableArray *)array instead.
 */
- (BOOL)onClickedShareButton:(UIViewController*)parentVC addShareActionItem:(NSMutableArray *)array;

/*!
 @brief Designated for notify that there does not exist ongoing share.
 */
- (void)onOngoingShareStopped;

/*!
 @brief Designated for customize Dial out.
 @param parentVC parent viewcontroller to present Dial Out UI.
 @param me if YES, means "Call Me"; if NO, means "Invite by Phone".
 */
- (void)onClickedDialOut:(UIViewController*)parentVC isCallMe:(BOOL)me;

/*!
 @brief Designated for Dial Out status change.
 @param status tell client the status of dial out.
 */
- (void)onDialOutStatusChanged:(DialOutStatus)status;

/*!
 @brief Designated for Send pairing code state change.
 @param state if 0 means pairing success, or means that call in failed.
 */
- (void)onSendPairingCodeStateChanged:(NSUInteger)state;

/*!
 @brief Designated for Call Room Device state change.
 @param state tell client the status of calling Room Device.
 */
- (void)onCallRoomDeviceStateChanged:(H323CallOutStatus)state;

/*!
 @brief Designated for notify chat content in meeting.
 @param messageID the message id
 */
- (void)onInMeetingChat:(NSString*)messageID;

/*!
 @brief Designated for notify the meeting is E2E or not.
 @param key the meeting session key
 */
- (void)onWaitExternalSessionKey:(NSData*)key;

/*!
 @brief Designated for live stream status change.
 */
- (void)onLiveStreamStatusChange:(MobileRTCLiveStreamStatus)liveStreamStatus;

/*!
 @brief Designated for ZAK expired.
 */
- (void)onZoomIdentityExpired;

/*!
 @brief Designated for user click share screen item.
 @param parentVC parent viewcontroller to present Share Screen Usage Guide View.
 @waring App would present Share Screen Usage Guide here.
 */
- (void)onClickShareScreen:(UIViewController*)parentVC;

/*!
 @brief Designated for user received closed Caption.
 */
- (void)onClosedCaptionReceived:(NSString*)message;

/*!
 @brief Designated for waiting room status change.
 */
- (void)onWaitingRoomStatusChange:(BOOL)needWaiting;
@end

#pragma mark - MobileRTCAudioServiceDelegate
/*!
 @protocol MobileRTCAudioServiceDelegate
 @brief An Audio Service will issue the following value when the meeting audio changes
 */
@protocol MobileRTCAudioServiceDelegate <MobileRTCMeetingServiceDelegate>

/*!
 @abstract Invoked when participants audio status change event arised.
 @return UserID which Audio Status Changed.
 */
- (void)onSinkMeetingAudioStatusChange:(NSUInteger)userID;

/*!
 @abstract Invoked when my audio type change event arised.
 */
- (void)onSinkMeetingMyAudioTypeChange;

/*!
 @brief Designated for audio output changed.
 */
- (void)onAudioOutputChange;

/*!
 @brief Designated for my audio state changed.
 */
- (void)onMyAudioStateChange;
@end

#pragma mark - MobileRTCVideoServiceDelegate
/*!
 @protocol MobileRTCVideoServiceDelegate
 @brief An Video Service will issue the following value when the meeting video changes
 */
@protocol MobileRTCVideoServiceDelegate <MobileRTCMeetingServiceDelegate>

/*!
 @abstract Invoked when active video switch event arised.
 @return Active Video UserID at present.
 */
- (void)onSinkMeetingActiveVideo:(NSUInteger)userID;

/*!
 @abstract Invoked when participants Video status change event arised.
 @return UserID which Video Status Changed.
 */
- (void)onSinkMeetingVideoStatusChange:(NSUInteger)userID;

/*!
 @brief Designated for my video state changed.
 */
- (void)onMyVideoStateChange;

/*!
 @brief Designated for notify that spotlight user video change.
 @param on if YES means spotlighted; if NO means unspotlighted.
 */
- (void)onSpotlightVideoChange:(BOOL)on;

/*!
 @brief Designated for notify that SDK force stopped video in MobileRTCPreviewVideoView.
 @waring MobileRTCPreviewVideoView will stop render, App need to adjust UI, remove MobileRTCPreviewVideoView instance if needed.
 */
- (void)onSinkMeetingPreviewStopped;

/*!
 @abstract Invoked when active video for deck event arised.
 @return userID that video need to be refreshed.
 */
- (void)onSinkMeetingActiveVideoForDeck:(NSUInteger)userID;

/*!
 @brief Designated for notify that user video quality changed.
 @return quality of the Video & UserID which Video Quality Changed.
 */
- (void)onSinkMeetingVideoQualityChanged:(MobileRTCNetworkQuality)qality userID:(NSUInteger)userID;

/*!
 @brief Designated for notify that host request to unmute my video.
 */
- (void)onSinkMeetingVideoRequestUnmuteByHost:(void (^)(BOOL Accept))completion;
@end

#pragma mark - MobileRTCUserServiceDelegate
/*!
 @protocol MobileRTCUserServiceDelegate
 @brief An User Service will issue the following value when the meeting user status changes
 */
@protocol MobileRTCUserServiceDelegate <MobileRTCMeetingServiceDelegate>

/*!
 @brief Designated for my hand state changed (Hand raised/lowered).
 */
- (void)onMyHandStateChange;

/*!
 @brief Designated for notify user state updated in meeting.
 */
- (void)onInMeetingUserUpdated;

/*!
 @abstract Invoked when user join event arised.
 @return UserID which joined meeting.
 */
- (void)onSinkMeetingUserJoin:(NSUInteger)userID;

/*!
 @abstract Invoked when user left event arised.
 @return UserID which left meeting.
 */
- (void)onSinkMeetingUserLeft:(NSUInteger)userID;

/*!
 @abstract Invoked when user raise hand event arised.
 @return UserID which raise hand.
 */
- (void)onSinkMeetingUserRaiseHand:(NSUInteger)userID;

/*!
 @abstract Invoked when user lower hand event arised.
 @return UserID which lower hand.
 */
- (void)onSinkMeetingUserLowerHand:(NSUInteger)userID;

/*!
 @brief Designated for notify that spotlight user video change.
 @param hostId the host user id
 */
- (void)onMeetingHostChange:(NSUInteger)hostId;

/*!
 @brief Designated for notify that cohost changed.
 @param cohostId the cohost user id
 */
- (void)onMeetingCoHostChange:(NSUInteger)cohostId;

/*!
 @brief Designated for notify user Claim Host Result.
 */
- (void)onClaimHostResult:(MobileRTCClaimHostError)error;
@end

#pragma mark - MobileRTCShareServiceDelegate
/*!
 @protocol MobileRTCShareServiceDelegate
 @brief An Share Service will issue the following value when the meeting share status changes
 */
@protocol MobileRTCShareServiceDelegate <MobileRTCMeetingServiceDelegate>

/*!
 @brief Designated for App share has started with default splash.
 */
- (void)onAppShareSplash;

/*!
 @abstract Invoked when active share event arised.
 @return UserID which starting share.
 */
- (void)onSinkMeetingActiveShare:(NSUInteger)userID;

/*!
 @abstract Invoked when active share content received event arised.
 @return Recevied share content of UserID which started share.
 */
- (void)onSinkMeetingShareReceiving:(NSUInteger)userID;

/*!
 @abstract Invoked when active share content size change event arised.
 @return Shared content size change of UserID which started share.
 */
- (void)onSinkShareSizeChange:(NSUInteger)userID;

@end

#pragma mark - MobileRTCWebinarServiceDelegate
/*!
 @protocol MobileRTCWebinarServiceDelegate
 @brief An Webinar Service will issue the following value when the Webinar meeting event changes
 */
@protocol MobileRTCWebinarServiceDelegate <MobileRTCMeetingServiceDelegate>

/*!
 @abstract Invoked when Q&A connect started.
 */
- (void)onSinkQAConnectStarted;

/*!
 @abstract Invoked when Q&A connected or disconnected.
 @param connected, flag of Q&A connected or disconected.
 */
- (void)onSinkQAConnected:(BOOL)connected;

/*!
 @abstract Invoked when Q&A open question changed.
 @param count, number of open questions.
 */
- (void)onSinkQAOpenQuestionChanged:(NSInteger)count;

/*!
 @abstract Invoked when status of wether can ask question anonymously change.
 @return beAllowed is allowed to ask question anonymously or not.
 */
- (void)onSinkQAAllowAskQuestionAnonymouslyNotification:(BOOL)beAllowed;

/*!
 @abstract Invoked when status of wether attendee is allowed view all question change.
 @return beAllowed is allowed view all question or not.
 */
- (void)onSinkQAAllowAttendeeViewAllQuestionNotification:(BOOL)beAllowed;

/*!
 @abstract Invoked when status of wether attendee is allowed upvote question change.
 @return beAllowed is allowed upvote question or not.
 */
- (void)onSinkQAAllowAttendeeUpVoteQuestionNotification:(BOOL)beAllowed;

/*!
 @abstract Invoked when status of wether attendee is allowed answer question change.
 @return beAllowed is allowed answer question or not.
 */
- (void)onSinkQAAllowAttendeeAnswerQuestionNotification:(BOOL)beAllowed;

/*!
 @abstract Invoked when joined one webinar that need manual approval.
 @param registerURL, register URL.
 */
- (void)onSinkWebinarNeedRegister:(NSString *)registerURL;

/*!
 @abstract Invoked when joined one webinar that need username & email.
 @param cancelled when user cancel to provide display name or meeting password, cancel to join meeting.
 @param completion ask user to username & email info, and determine to join meeting or not.
 */
- (void)onSinkJoinWebinarNeedUserNameAndEmailWithCompletion:(BOOL (^_Nonnull)(NSString * _Nonnull username, NSString * _Nonnull email, BOOL cancel))completion;

/*!
 @abstract Invoked when Panelist capactity Exceed.
 */
- (void)onSinkPanelistCapacityExceed;

/*!
 @abstract Invoked when Attendee has been Prompt from Attendee to Panelist Successfully.
 @return errorCode: success or error type.
 */
- (void)onSinkPromptAttendee2PanelistResult:(MobileRTCWebinarPromoteorDepromoteError)errorCode;

/*!
 @abstract Invoked when Panelist has been DePrompt from Panelist to Attendee Successfully.
 @return errorCode: success or error type.
 */
- (void)onSinkDePromptPanelist2AttendeeResult:(MobileRTCWebinarPromoteorDepromoteError)errorCode;

/*!
 @abstract Invoked when Attendee chat priviliege change.
 @return currentPrivilege the current Attendee chat priviliege.
 */
- (void)onSinkAllowAttendeeChatNotification:(MobileRTCChatAllowAttendeeChat)currentPrivilege;
@end

#pragma mark - MobileRTCCustomizedUIMeetingDelegate
/*!
 @protocol MobileRTCCustomizedUIMeetingDelegate
 @brief A class conforming to the MobileRTCCustomizedUIMeetingDelegate protocol can provide
        methods for tracking the In-Meeting Event and for deciding policy for each Event.
 @discussion MobileRTCCustomizedUIMeetingDelegate protocol would be Necessary while Customized In-Meeting UI View.
 */
@protocol MobileRTCCustomizedUIMeetingDelegate <NSObject>

@required
/*!
 @brief Designated for notify user Create Custom-InMeeting UI View.
 */
- (void)onInitMeetingView;

/*!
 @brief Designated for notify user Destroy Custom-InMeeting UI View.
 */
- (void)onDestroyMeetingView;

@end



