//
//  MobileRTCMeetingService.h
//  MobileRTC
//
//  Created by Robust Hu on 8/7/14.
//  Copyright (c) 2016 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MobileRTCConstants.h"
#import "MobileRTCMeetingDelegate.h"

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
 * @key kMeetingParam_VanityID, The vanity ID for start meeting.
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
extern NSString* kMeetingParam_VanityID;

/*!
 @brief MobileRTCMeetingStartParam provides support for embedded start meeting param.
 */
@interface MobileRTCMeetingStartParam : NSObject
/*!
 @brief This property knows as wether appshare meeting.
 */
@property (nonatomic, assign, readwrite) BOOL  isAppShare;
/*!
 @brief This property knows as do not connect audio while start meeting.
 */
@property (nonatomic, assign, readwrite) BOOL  noAudio;
/*!
 @brief This property knows as do not connect audio while start meeting.
 */
@property (nonatomic, assign, readwrite) BOOL  noVideo;
/*!
 @brief This property knows as participant ID.
 */
@property (nullable, nonatomic, retain, readwrite) NSString * participantID;
/*!
 @brief This property knows as webinar token.
 */
@property (nullable, nonatomic, retain, readwrite) NSString * webinarToken;
/*!
 @brief This property knows as vanity iD.
 */
@property (nullable, nonatomic, retain, readwrite) NSString * vanityID;
/*!
 @brief This property knows as meeting number.
 */
@property (nullable, nonatomic, retain, readwrite) NSString * meetingNumber;
@end

/*!
 @brief MobileRTCMeetingStartParam4LoginlUser provides support for embedded start meeting param for login User.
 */
@interface MobileRTCMeetingStartParam4LoginlUser : MobileRTCMeetingStartParam

@end

/*!
 @brief MobileRTCMeetingStartParam4NoramlUser provides support for embedded start meeting param for Not login User.
 @waring UserToken & ZAK cannot be null
 */
@interface MobileRTCMeetingStartParam4WithoutLoginUser : MobileRTCMeetingStartParam
/*!
 @brief This property knows as user type.
 */
@property (nonatomic, assign, readwrite) MobileRTCUserType userType;
/*!
 @brief This property knows as user name.
 */
@property (nonnull, nonatomic, retain, readwrite) NSString * userName;
/*!
 @brief This property knows as user token.
 @waring userToken cannot be null
 */
@property (nonnull, nonatomic, retain, readwrite) NSString * userToken;
/*!
 @brief This property knows as user id.
 */
@property (nonnull, nonatomic, retain, readwrite) NSString * userID;
/*!
 @brief This property knows as user zak.
 @waring zak cannot be null
 */
@property (nonnull, nonatomic, retain, readwrite) NSString * zak;
@end



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
@property (nullable, assign, nonatomic) id<MobileRTCMeetingServiceDelegate> delegate;

/*!
 @brief The object that acts as the delegate of the receiving meeting events.
 */
@property (nullable, assign, nonatomic) id<MobileRTCCustomizedUIMeetingDelegate> customizedUImeetingDelegate;

/*!
 @brief This method is used to start a meeting with parameters in a dictionary.
 @discussion For user type is MobileRTCUserType_APIUser, the parameters in dict should be included kMeetingParam_UserID, kMeetingParam_UserToken,
    kMeetingParam_UserType, kMeetingParam_Username, kMeetingParam_MeetingNumber; For user type is MobileRTCUserType_ZoomUser/MobileRTCUserType_SSOUser, 
    the parameters in dict just be included kMeetingParam_UserType and kMeetingParam_MeetingNumber(optional, this parameter can be ignored for instant meeting).
 @param dict The dictionary which contains the meeting parameters.
 @return A MobileRTCMeetError to tell client whether the meeting started or not.
 @warning If start meeting with wrong parameter, this method will return MobileRTCMeetError_InvalidArguments
 */
- (MobileRTCMeetError)startMeetingWithDictionary:(nonnull NSDictionary*)dict;

/*!
 @brief This method is used to start a meeting with MobileRTCMeetingStartParam param.
 @discussion For user do not login, pass MobileRTCMeetingStartParam4WithoutLoginUser instance, For login user, pass MobileRTCMeetingStartParam4LoginlUser instance
 @param param MobileRTCMeetingStartParam instance with correct info.
 @return A MobileRTCMeetError to tell client whether the meeting started or not.
 @warning If start meeting with wrong parameter, this method will return MobileRTCMeetError_InvalidArguments
 */
- (MobileRTCMeetError)startMeetingWithStartParam:(nonnull MobileRTCMeetingStartParam*)param;

/*!
 @brief This method is used to join a meeting with parameters in a dictionary.
 @param dict The dictionary which contains the meeting parameters.
 @return A MobileRTCMeetError to tell client whether can join the meeting or not.
 @warning If app is in callkit mode, set parameter:kMeetingParam_Username as empty
 */
- (MobileRTCMeetError)joinMeetingWithDictionary:(nonnull NSDictionary*)dict;

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
