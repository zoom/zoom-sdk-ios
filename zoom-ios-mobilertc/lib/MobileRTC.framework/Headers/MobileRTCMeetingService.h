//
//  MobileRTCMeetingService.h
//  MobileRTC
//
//  Created by Robust Hu on 8/7/14.
//  Copyright (c) 2016 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MobileRTCConstants.h"

typedef enum {
    //API user type
    MobileRTCUserType_APIUser     = 99,
    //Work email user type
    MobileRTCUserType_ZoomUser    = 100,
    //Single-sign-on user type
    MobileRTCUserType_SSOUser     = 101,
}MobileRTCUserType;

typedef enum {
    //Leave meeting
    LeaveMeetingCmd_Leave,
    //End Meeting
    LeaveMeetingCmd_End,
}LeaveMeetingCmd;

typedef enum {
    //Show JBH waiting
    JBHCmd_Show,
    //Hide JBH waiting
    JBHCmd_Hide,
}JBHCmd;

typedef enum {
    DialOutStatus_Unknown  = 0,
    DialOutStatus_Calling,
    DialOutStatus_Ringing,
    DialOutStatus_Accepted,
    DialOutStatus_Busy,
    DialOutStatus_NotAvailable,
    DialOutStatus_UserHangUp,
    DialOutStatus_OtherFail,
    DialOutStatus_JoinSuccess,
    DialOutStatus_TimeOut,  //For client not get response, maybe network reason
    DialOutStatus_ZoomStartCancelCall,
    DialOutStatus_ZoomCallCanceled,
    DialOutStatus_ZoomCancelCallFail,
    DialOutStatus_NoAnswer,  //Indicate the phone ring but no-one answer
    DialOutStatus_BlockNoHost,  //JBH case, disable international callout before host join
    DialOutStatus_BlockHighRate,  //The price of callout phone number is too expensive which has been blocked by system
    DialOutStatus_BlockTooFrequent,  //Invite by phone with pressONE required, but invitee frequently does NOT press one then timeout
}DialOutStatus;

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
 * This method is used to end/leave an ongoing meeting.
 *
 * @param cmd, leave meeting by the command type.
 */
- (void)leaveMeetingWithCmd:(LeaveMeetingCmd)cmd;

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
 * This method is used to turn on/off cloud record in the meeting.
 *
 * @param on, if YES to turn on cloud record; if NO to turn off cloud record.
 */
- (void)turnOnCMR:(BOOL)on;

/**
 * This method will return the view of meeting UI, which provide an access which allow customer to add their own view in the meeting UI.
 *
 * @return the view of meeting if the meeting is ongoing, or return nil.
 */
- (UIView*)meetingView;

/**
 * This method is used to tell the client is starting share or not.
 *
 * @return YES if the client is starting share.
 *
 */
- (BOOL)isStartingShare;

/**
 * This method is used to tell the client is viewing share or not.
 *
 * @return YES if the client is viewing share.
 *
 */
- (BOOL)isViewingShare;

/**
 * This method is used to tell the client whether the meeting is an app share meeting.
 *
 * @return YES if the meeting is an app share meeting.
 *
 * *Note*: This method is just for special customer.
 */
- (BOOL)isDirectAppShareMeeting;
/**
 * This method is used to change the view of share content.
 *
 * @param view, the view will be shared.
 *
 * *Note*: This method is just for special customer.
 */
- (void)appShareWithView:(UIView*)view;

/**
 * This method is used to show UI of meeting.
 *
 * @param completion, can be used to do some action after showing meeting UI.
 *
 * *Note*: This method is just for special customer.
 */
- (void)showMobileRTCMeeting:(void (^)(void))completion;

/**
 * This method is used to hide UI of meeting.
 *
 * @param completion, can be used to do some action after hiding meeting UI.
 *
 * *Note*: This method is just for special customer.
 */
- (void)hideMobileRTCMeeting:(void (^)(void))completion;

/**
 * This method is used to start app share.
 *
 * *Note*: This method is just for special customer.
 */
- (BOOL)startAppShare;

/**
 * This method is used to stop app share.
 *
 * *Note*: This method is just for special customer.
 */
- (void)stopAppShare;

/**
 * This method is used to customize meeting title for meeting bar while inmeeting status.
 *
 * *Note*: This method is just for special customer.
 * *Note*: Method need to be call before start or join one meeting & title will be reset after leave/end meeting.
 */
- (void)customizeMeetingTitle:(NSString*)title;

/**
 * This method is used to check whether there exists a dial out in process.
 *
 * *Note*: This method is just for special customer.
 */
- (BOOL)isDialOutInProgress;

/**
 * This method is used to start a dial out.
 *
 * @param phone, the phone number used to dial out, the phone number should add country code at first, such as "+86123456789".
 * @param me, if YES, means "Call Me"; if NO, means "Invite by Phone".
 * @param username, the display name for invite other by phone. If parameter "me" is YES, the param can be ignored.
 *
 * *Note*: This method is just for special customer.
 */
- (BOOL)dialOut:(NSString*)phone isCallMe:(BOOL)me withName:(NSString*)username;

/**
 * This method is used to cancel dial out.
 *
 * *Note*: This method is just for special customer.
 */
- (BOOL)cancelDialOut:(BOOL)isCallMe;

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
 * Designated for App share has started with default splash.
 *
 * *Note*: This method is just for special customer.
 */
- (void)onAppShareSplash;

/**
 * Designated for clicked the Share button in meeting.
 *
 * *Note*: This method is just for special customer.
 */
- (void)onClickedShareButton;

/**
 * Designated for notify that there does not exist ongoing share.
 *
 * *Note*: This method is just for special customer.
 */
- (void)onOngoingShareStopped;

/**
 * Designated for join a none-host meeting, Partner can show/hide a customized JBH waiting UI.
 *
 * *Note*: This method is just for special customer.
 */
- (void)onJBHWaitingWithCmd:(JBHCmd)cmd;

/**
 * Designated for customize the Invite event.
 *
 * @param parentVC, parent viewcontroller to present customize Invite UI.
 *
 * *Note*: This method is just for special customer.
 */
- (void)onClickedInviteButton:(UIViewController*)parentVC;

/**
 * Designated for customize Dial out.
 *
 * @param parentVC, parent viewcontroller to present Dial Out UI.
 * @param me, if YES, means "Call Me"; if NO, means "Invite by Phone".
 *
 * *Note*: This method is just for special customer.
 */
- (void)onClickedDialOut:(UIViewController*)parentVC isCallMe:(BOOL)me;

/**
 * Designated for Dial Out status change.
 *
 * @param status tell client the status of dial out.
 *
 */
- (void)onDialOutStatusChanged:(DialOutStatus)status;

@end

