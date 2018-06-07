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

/*!
 @class MobileRTCMeetingService
 @brief MobileRTCMeetingService is an implementation for client to start/join a Meetings.
 @discussion This meeting service assumes there is only one concurrent operation at a time. This means that at any given time, only one API call will be in progress.
 */
@interface MobileRTCMeetingService : NSObject

/*!
 @brief The object that acts as the delegate of the receiving meeting events.
 */
@property (assign, nonatomic) id<MobileRTCMeetingServiceDelegate> delegate;

/*!
 @brief This method is used to start a meeting with parameters in a dictionary.
 @discussion For user type is MobileRTCUserType_APIUser, the parameters in dict should be included kMeetingParam_UserID, kMeetingParam_UserToken,
    kMeetingParam_UserType, kMeetingParam_Username, kMeetingParam_MeetingNumber; For user type is MobileRTCUserType_ZoomUser/MobileRTCUserType_SSOUser, 
    the parameters in dict just be included kMeetingParam_UserType and kMeetingParam_MeetingNumber(optional, this parameter can be ignored for instant meeting).
 @param dict The dictionary which contains the meeting parameters.
 @return A MobileRTCMeetError to tell client whether the meeting started or not.
 @warning If start meeting with wrong parameter, this method will return MobileRTCMeetError_InvalidArguments
 */
- (MobileRTCMeetError)startMeetingWithDictionary:(NSDictionary*)dict;

/*!
 @brief This method is used to join a meeting with parameters in a dictionary.
 @param dict The dictionary which contains the meeting parameters.
 @return A MobileRTCMeetError to tell client whether can join the meeting or not.
 */
- (MobileRTCMeetError)joinMeetingWithDictionary:(NSDictionary*)dict;

/*!
 @brief This method is used to join a meeting with parameters in a dictionary.
 @return A MobileRTCMeetingState to tell client the meeting state currently.
 */
- (MobileRTCMeetingState)getMeetingState;

/*!
 @brief This method is used to end/leave an ongoing meeting.
 @param cmd leave meeting by the command type.
 */
- (void)leaveMeetingWithCmd:(LeaveMeetingCmd)cmd;

/*!
 @brief This method will return the view of meeting UI, which provide an access which allow customer to add their own view in the meeting UI.
 @return the view of meeting if the meeting is ongoing, or return nil.
 */
- (UIView*)meetingView;

@end

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
 */
- (void)onMeetingReturn:(MobileRTCMeetError)error internalError:(NSInteger)internalError;

/*!
 @brief Designated for Meeting Error message.
 @param error internal error code.
 @param message the message for meeting error
 */
- (void)onMeetingError:(NSInteger)error message:(NSString*)message;

/*!
 @brief Designated for Meeting State Change.
 @param state tell client meeting state chagne.
 */
- (void)onMeetingStateChange:(MobileRTCMeetingState)state;

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
 @brief Designated for customize the Invite event.
 @param parentVC parent viewcontroller to present customize Invite UI.
 */
- (void)onClickedInviteButton:(UIViewController*)parentVC;

/*!
 @brief Designated for customize the Participants event.
 @param parentVC parent viewcontroller to present customize Participants UI.
 */
- (BOOL)onClickedParticipantsButton:(UIViewController*)parentVC;

#pragma mark - For AppShare Delegate
/*!
 @brief Designated for App share has started with default splash.
 */
- (void)onAppShareSplash;

/*!
 @brief Designated for clicked the Share button in meeting.
 @return YES, customer handled this action, MobileRTC need not popup share menu; NO, customer ignored this action, MobileRTC take care this action and still popup share menu.
 @warning The previous method "- (void)onClickedShareButton" has been chagned to this method.
 */
- (BOOL)onClickedShareButton;

/*!
 @brief Designated for notify that there does not exist ongoing share.
 */
- (void)onOngoingShareStopped;

#pragma mark - For DialOut Delegate
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

#pragma mark - For Call H.323/SIP Delegate
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

#pragma mark - For User State Delegate

/*!
 @brief Designated for my audio state changed.
 */
- (void)onMyAudioStateChange;

/*!
 @brief Designated for my video state changed.
 */
- (void)onMyVideoStateChange;

/*!
 @brief Designated for my hand state changed (Hand raised/lowered).
 */
- (void)onMyHandStateChange;

/*!
 @brief Designated for audio output changed.
 */
- (void)onAudioOutputChange;

/*!
 @brief Designated for notify user state updated in meeting.
 */
- (void)onInMeetingUserUpdated;

/*!
 @brief Designated for notify that spotlight user video change.
 @param on if YES means spotlighted; if NO means unspotlighted.
 */
- (void)onSpotlightVideoChange:(BOOL)on;

/*!
 @brief Designated for notify that spotlight user video change.
 @param hostId the host user id
 */
- (void)onMeetingHostChange:(NSUInteger)hostId;

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

@end

