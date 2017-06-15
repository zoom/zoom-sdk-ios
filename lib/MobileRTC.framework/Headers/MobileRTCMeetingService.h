//
//  MobileRTCMeetingService.h
//  MobileRTC
//
//  Created by Robust Hu on 8/7/14.
//  Copyright (c) 2016 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MobileRTCConstants.h"


/**
 * The key of dictionary for parameter of methods "startMeetingWithDictionary" and "joinMeetingWithDictionary".
 *
 * @key kMeetingParam_UserID, The userId for start meeting.
 * @key kMeetingParam_UserToken, The token for start meeting.
 * @key kMeetingParam_UserType, The user type for start meeting.
 * @key kMeetingParam_Username, The user name for start meeting.
 * @key kMeetingParam_MeetingNumber, The meeting number for start meeting.
 * @key kMeetingParam_MeetingPassword, The meeting password for join meeting.
 * @key kMeetingParam_ParticipantID, the key is optional, If set, user will use the participant ID to join meeting.
 * @key kMeetingParam_IsAppShare, the key is optional, If set @(YES), user will start a meeting for app share.
 * @key kMeetingParam_WebinarToken, the key is optional for joining Webinar, if user wants to join as a panelist.
 * @key kMeetingParam_NoAudio, the key is optional, If set @(YES), user will enter meeting without audio.
 * @key kMeetingParam_NoVideo, the key is optional, If set @(YES), user will enter meeting without video.
*/
extern NSString* kMeetingParam_UserID;
extern NSString* kMeetingParam_UserToken;
extern NSString* kMeetingParam_UserType;
extern NSString* kMeetingParam_Username;
extern NSString* kMeetingParam_MeetingNumber;
extern NSString* kMeetingParam_MeetingPassword;
extern NSString* kMeetingParam_ParticipantID;
extern NSString* kMeetingParam_IsAppShare;
extern NSString* kMeetingParam_WebinarToken;
extern NSString* kMeetingParam_NoAudio;
extern NSString* kMeetingParam_NoVideo;

@protocol MobileRTCMeetingServiceDelegate;

/**
 * MobileRTCMeetingService is an implementation for client to start/join a Meetings.
 * This meeting service assumes there is only one concurrent operation at a time. This means
 * that at any given time, only one API call will be in progress.
 */
@interface MobileRTCMeetingService : NSObject

/**
 * The object that acts as the delegate of the receiving meeting events.
 */
@property (assign, nonatomic) id<MobileRTCMeetingServiceDelegate> delegate;

/**
 * This method is used to start a meeting with parameters in a dictionary.
 *
 * @param dict The dictionary which contains the meeting parameters.
 *
 * @return A MobileRTCMeetError to tell client whether the meeting started or not.
 */
- (MobileRTCMeetError)startMeetingWithDictionary:(NSDictionary*)dict;

/**
 * This method is used to join a meeting with parameters in a dictionary.
 *
 * @param dict The dictionary which contains the meeting parameters.
 *
 * @return A MobileRTCMeetError to tell client whether can join the meeting or not.
 */
- (MobileRTCMeetError)joinMeetingWithDictionary:(NSDictionary*)dict;

/**
 * This method is used to tell the client whether the meeting is ongoing or not.
 *
 * @return A MobileRTCMeetingState to tell client the meeting state currently.
 */
- (MobileRTCMeetingState)getMeetingState;

/**
 * This method is used to end/leave an ongoing meeting.
 *
 * @param cmd, leave meeting by the command type.
 */
- (void)leaveMeetingWithCmd:(LeaveMeetingCmd)cmd;

/**
 * This method will return the view of meeting UI, which provide an access which allow customer to add their own view in the meeting UI.
 *
 * @return the view of meeting if the meeting is ongoing, or return nil.
 */
- (UIView*)meetingView;

@end

/**
 * MobileRTCMeetingServiceDelegate
 * An Meeting Service will issue the following value when the meeting state changes:
 *
 * MobileRTCMeetError
 * ============================
 * - MobileRTCMeetError_Success: start/join meeting successfully.
 * - MobileRTCMeetError_IncorrectMeetingNumber: the meeting number is incorrect.
 * - MobileRTCMeetError_MeetingTimeout: start/join meeting timeout.
 * - MobileRTCMeetError_NetworkUnavailable: start/join meeting failed for network issue.
 * - MobileRTCMeetError_MeetingClientIncompatible: cannot start/join meeting for the client is too old.
 * - MobileRTCMeetError_UserFull: cannot start/join meeting for the meeting has reached a maximum of participant.
 * - MobileRTCMeetError_MeetingOver: cannot start/join meeting for the meeting is over.
 * - MobileRTCMeetError_MeetingNotExist: cannot start/join meeting for the meeting doest not exist.
 * - MobileRTCMeetError_MeetingLocked: cannot start/join meeting for the meeting was locked by host.
 * - MobileRTCMeetError_MeetingRestricted: cannot start/join meeting for the meeting restricted.
 * - MobileRTCMeetError_MeetingJBHRestricted: cannot start/join meeting for the meeting restricted for joining before host.
 * - MobileRTCMeetError_InvalidArguments: cannot start/join meeting for invalid augument.
 * - MobileRTCMeetError_Unknown: cannot start/join meeting for unknown reason.
 *
 * MobileRTCMeetingState
 * ============================
 * - MobileRTCMeetingState_Idle: idle now, client can start/join meeting if wanted.
 * - MobileRTCMeetingState_Connecting: the client is starting/joining meeting.
 * - MobileRTCMeetingState_InMeeting: the client is a meeting now.
 */
@protocol MobileRTCMeetingServiceDelegate <NSObject>

@optional
/**
 * Designated for Meeting Response.
 *
 * @param error, tell client related to this meeting event.
 * @param internalError, internal error code
 *
 */
- (void)onMeetingReturn:(MobileRTCMeetError)error internalError:(NSInteger)internalError;

/**
 * Designated for Meeting Error message.
 *
 * @param error, internal error code.
 * @param message, the message for meeting error
 *
 */
- (void)onMeetingError:(NSInteger)error message:(NSString*)message;

/**
 * Designated for Meeting State Change.
 *
 * @param state, tell client meeting state chagne.
 *
 */
- (void)onMeetingStateChange:(MobileRTCMeetingState)state;

/**
 * Designated for Meeting has been ready.
 *
 */
- (void)onMeetingReady;

/**
 * Designated for join a none-host meeting, Partner can show/hide a customized JBH waiting UI.
 *
 */
- (void)onJBHWaitingWithCmd:(JBHCmd)cmd;

/**
 * Designated for customize the Invite event.
 *
 * @param parentVC, parent viewcontroller to present customize Invite UI.
 *
 */
- (void)onClickedInviteButton:(UIViewController*)parentVC;

#pragma mark - For AppShare Delegate
/**
 * Designated for App share has started with default splash.
 *
 */
- (void)onAppShareSplash;

/**
 * Designated for clicked the Share button in meeting.
 *
 */
- (void)onClickedShareButton;

/**
 * Designated for notify that there does not exist ongoing share.
 *
 */
- (void)onOngoingShareStopped;

#pragma mark - For DialOut Delegate
/**
 * Designated for customize Dial out.
 *
 * @param parentVC, parent viewcontroller to present Dial Out UI.
 * @param me, if YES, means "Call Me"; if NO, means "Invite by Phone".
 *
 */
- (void)onClickedDialOut:(UIViewController*)parentVC isCallMe:(BOOL)me;

/**
 * Designated for Dial Out status change.
 *
 * @param status tell client the status of dial out.
 *
 */
- (void)onDialOutStatusChanged:(DialOutStatus)status;

#pragma mark - For Call H.323/SIP Delegate
/**
 * Designated for Send pairing code state change.
 *
 * @param state, if 0 means pairing success, or means that call in failed.
 *
 */
- (void)onSendPairingCodeStateChanged:(NSUInteger)state;

/**
 * Designated for Call Room Device state change.
 *
 * @param state tell client the status of calling Room Device.
 *
 */
- (void)onCallRoomDeviceStateChanged:(H323CallOutStatus)state;

#pragma mark - For User State Delegate

/**
 * Designated for my audio state changed.
 *
 */
- (void)onMyAudioStateChange;

/**
 * Designated for my video state changed.
 *
 */
- (void)onMyVideoStateChange;

/**
 * Designated for my hand state changed (Hand raised/lowered).
 *
 */
- (void)onMyHandStateChange;

/**
 * Designated for audio output changed.
 *
 */
- (void)onAudioOutputChange;

/**
 * Designated for notify user state updated in meeting.
 *
 */
- (void)inMeetingUserUpdated;

/**
 * Designated for notify that spotlight user video change.
 *
 * @param on, if YES means spotlighted; if NO means unspotlighted.
 *
 */
- (void)onSpotlightVideoChange:(BOOL)on;

/**
 * Designated for notify user meeting host change.
 *
 * @param hostId, the host user id.
 *
 */
- (void)onMeetingHostChange:(NSUInteger)hostId;

@end

