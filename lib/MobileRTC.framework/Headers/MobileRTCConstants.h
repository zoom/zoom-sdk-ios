//
//  MobileRTCConstants.h
//  MobileRTC
//
//  Created by Robust Hu on 8/7/14.
//  Copyright (c) 2016 Zoom Video Communications, Inc. All rights reserved.
//

//MobileRTC Base Domain
#define kMobileRTCBaseDomain @"zoom.us"

//Client Key or Secret is empty
#define kMobileRTCAuthKeyOrSecretEmpty        300
//Client Key or Secret is wrong
#define kMobileRTCAuthKeyOrSecretWrong        3023
//Account does not support SDK feature
#define kMobileRTCAuthAccountNotSupport       3024
//Account has not enabled SDK feature
#define kMobileRTCAuthAccountNotEnableSDK     3025

/*!
 @brief MobileRTCAuthError An Enum which provide all of SDK Auth Error state.
 */
typedef enum {
    ///Auth Success
    MobileRTCAuthError_Success,
    ///Key or Secret is empty
    MobileRTCAuthError_KeyOrSecretEmpty,
    ///Key or Secret is wrong
    MobileRTCAuthError_KeyOrSecretWrong,
    ///Client Account does not support
    MobileRTCAuthError_AccountNotSupport,
    ///Client account does not enable SDK
    MobileRTCAuthError_AccountNotEnableSDK,
    ///Auth Unknown error
    MobileRTCAuthError_Unknown,
}MobileRTCAuthError;

/*!
 @brief MobileRTCMeetError An Enum which provide all of Meeting Error state.
 */
typedef enum {
    ///start/join meeting successfully
    MobileRTCMeetError_Success                          = 0,
    ///network issue, please check network connection
    MobileRTCMeetError_NetworkError                     = 1,
    ///failed to reconnect meeting
    MobileRTCMeetError_ReconnectError                   = 2,
    ///mmr issue, please check mmr configuration
    MobileRTCMeetError_MMRError                         = 3,
    ///meeting password incorrect
    MobileRTCMeetError_PasswordError                    = 4,
    ///failed to create video and audio data connection with mmr
    MobileRTCMeetError_SessionError                     = 5,
    ///the meeting is over
    MobileRTCMeetError_MeetingOver                      = 6,
    ///the meeting does not start
    MobileRTCMeetError_MeetingNotStart                  = 7,
    ///the meeting does not exist
    MobileRTCMeetError_MeetingNotExist                  = 8,
    ///the meeting has reached a maximum of participants
    MobileRTCMeetError_MeetingUserFull                  = 9,
    ///the mobilertc version is incompatible
    MobileRTCMeetError_MeetingClientIncompatible        = 10,
    ///there does not exist valid mmr
    MobileRTCMeetError_NoMMR                            = 11,
    ///the meeting was locked by host
    MobileRTCMeetError_MeetingLocked                    = 12,
    ///the meeting was restricted
    MobileRTCMeetError_MeetingRestricted                = 13,   
    ///the meeting was restricted join before host
    MobileRTCMeetError_MeetingRestrictedJBH             = 14,
    ///failed to send creat meeting command to web server
    MobileRTCMeetError_CannotEmitWebRequest             = 15,
    ///failed to start meeting with expired token
    MobileRTCMeetError_CannotStartTokenExpire           = 16,
    ///the user video cannot work
    MobileRTCMeetError_VideoError                       = 17,
    ///the user audio cannot auto start
    MobileRTCMeetError_AudioAutoStartError              = 18,
    ///webinar has reached its maximum
    MobileRTCMeetError_RegisterWebinarFull              = 19,
    ///sign in to start the webinar
    MobileRTCMeetError_RegisterWebinarHostRegister      = 20,
    ///join the webinar from the link
    MobileRTCMeetError_RegisterWebinarPanelistRegister  = 21,
    ///host has denied your webinar registration
    MobileRTCMeetError_RegisterWebinarDeniedEmail       = 22,
    ///sign in with the specified account to join webinar
    MobileRTCMeetError_RegisterWebinarEnforceLogin      = 23,
    ///the certificate of ZC has been changed
    MobileRTCMeetError_ZCCertificateChanged             = 24,
    ///the vanity url does not exist
    MobileRTCMeetError_VanityNotExist                   = 27,
    ///the email address has already been register in this webinar
    MobileRTCMeetError_JoinWebinarWithSameEmail         = 28,
    ///failed to write config file
    MobileRTCMeetError_WriteConfigFile                  = 50,
    ///Removed By host
    MobileRTCMeetError_RemovedByHost                    = 61,
    ///Invalid Arguments
    MobileRTCMeetError_InvalidArguments                 = MobileRTCMeetError_WriteConfigFile + 100,
    ///Invalid User Type
    MobileRTCMeetError_InvalidUserType,
    ///Already In another ongoing meeting
    MobileRTCMeetError_InAnotherMeeting,
    ///Unknown error
    MobileRTCMeetError_Unknown,

}MobileRTCMeetError;

/*!
 @brief MobileRTCMeetingState An Enum which provide all of Meeting state.
 */
typedef enum {
    ///Idle
    MobileRTCMeetingState_Idle              = 0,
    ///Connecting
    MobileRTCMeetingState_Connecting        = 1,
    ///In Meeting
    MobileRTCMeetingState_InMeeting         = 2,
    ///Webinar Meeting Promote
    MobileRTCMeetingState_WebinarPromote    = 3,
    ///Webinar Meeting DePromote
    MobileRTCMeetingState_WebinarDePromote  = 4,
}MobileRTCMeetingState;

/*!
 @brief MobileRTCUserType An Enum which provide all of User Type.
 */
typedef enum {
    ///Facebook user type
    MobileRTCUserType_Facebook    = 0,
    ///Google OAuth
    MobileRTCUserType_GoogleOAuth = 2,
    ///Device User
    MobileRTCUserType_DeviceUser  = 97,
    ///API user type
    MobileRTCUserType_APIUser     = 99,
    ///Work email user type
    MobileRTCUserType_ZoomUser    = 100,
    ///Single-sign-on user type
    MobileRTCUserType_SSOUser     = 101,
    ///Unknown
    MobileRTCUserType_Unknown     = 102,
}MobileRTCUserType;

/*!
 @brief LeaveMeetingCmd An Enum which provide command to leave meeting.
 */
typedef enum {
    ///Leave meeting
    LeaveMeetingCmd_Leave,
    ///End Meeting
    LeaveMeetingCmd_End,
}LeaveMeetingCmd;

/*!
 @brief JBHCmd An Enum which provide command to show waiting UI.
 */
typedef enum {
    ///Show JBH waiting
    JBHCmd_Show,
    ///Hide JBH waiting
    JBHCmd_Hide,
}JBHCmd;

/*!
 @brief DialOutStatus An Enum which provide all of states for Dial out.
 */
typedef enum {
    ///Unknown
    DialOutStatus_Unknown  = 0,
    ///Calling
    DialOutStatus_Calling,
    ///Ringing
    DialOutStatus_Ringing,
    ///Accepted
    DialOutStatus_Accepted,
    ///Busy
    DialOutStatus_Busy,
    ///Not Available
    DialOutStatus_NotAvailable,
    ///Hang Up
    DialOutStatus_UserHangUp,
    ///Other Fail Reason
    DialOutStatus_OtherFail,
    ///Join Success
    DialOutStatus_JoinSuccess,
    ///For client not get response, maybe network reason
    DialOutStatus_TimeOut,
    ///Start Cancel Call
    DialOutStatus_ZoomStartCancelCall,
    ///Call Canceled
    DialOutStatus_ZoomCallCanceled,
    ///Cancel Call Fail
    DialOutStatus_ZoomCancelCallFail,
    ///Indicate the phone ring but no-one answer
    DialOutStatus_NoAnswer,
    ///JBH case, disable international callout before host join
    DialOutStatus_BlockNoHost,
    ///The price of callout phone number is too expensive which has been blocked by system
    DialOutStatus_BlockHighRate,
    ///Invite by phone with pressONE required, but invitee frequently does NOT press one then timeout
    DialOutStatus_BlockTooFrequent,
}DialOutStatus;

/*!
 @brief H323CallOutStatus An Enum which provide all of states for Call out H.323/SIP.
 */
typedef enum {
    ///OK
    H323CallOutStatus_OK        = 0,
    ///Calling
    H323CallOutStatus_Calling,
    ///Busy
    H323CallOutStatus_Busy,
    ///Failed
    H323CallOutStatus_Failed,
}H323CallOutStatus;

/*!
 @brief MobileRTCComponentType An Enum which provide all of component types.
 */
typedef enum {
    ///Default
    MobileRTCComponentType_Def    = 0,
    ///Chat Module
    MobileRTCComponentType_Chat,
    ///File Transfer Module
    MobileRTCComponentType_FT,
    ///Audio Module
    MobileRTCComponentType_AUDIO,
    ///Video Module
    MobileRTCComponentType_VIDEO,
    ///Share Module
    MobileRTCComponentType_AS,
}MobileRTCComponentType;

/*!
 @brief MobileRTCNetworkQuality An Enum which provide network quality in meeting.
 */
typedef enum {
    ///Unknown
    MobileRTCNetworkQuality_Unknown     = -1,
    ///Very Bad
    MobileRTCNetworkQuality_VeryBad     = 0,
    ///Bad
    MobileRTCNetworkQuality_Bad         = 1,
    ///Not Good
    MobileRTCNetworkQuality_NotGood     = 2,
    ///Normal
    MobileRTCNetworkQuality_Normal      = 3,
    ///Good
    MobileRTCNetworkQuality_Good        = 4,
    ///Excellent
    MobileRTCNetworkQuality_Excellent   = 5,
}MobileRTCNetworkQuality;

/*!
 @brief MobileRTCAudioError An Enum which provide all of Audio related Action Error state.
 */
typedef enum {
    ///Success
    MobileRTCAudioError_Success                                   = 0,
    ///AudioSessionRecordPermissionDenied
    MobileRTCAudioError_AudioPermissionDenied                     = 1,
    ///Do not connect to audio session
    MobileRTCAudioError_AudioNotConnected                         = 2,
    ///Can not Unmute My Audio
    MobileRTCAudioError_CannotUnmuteMyAudio                       = 3,
}MobileRTCAudioError;

/*!
 @brief MobileRTCVideoError An Enum which provide all of Video related Action Error state.
 */
typedef enum {
    ///Success
    MobileRTCVideoError_Success                                   = 0,
    ///Camera PermissionDenied
    MobileRTCVideoError_CameraPermissionDenied                    = 1,
    ///Can not Unmute My Audio
    MobileRTCVideoError_CannotUnmuteMyVideo                       = 3,
}MobileRTCVideoError;

/*!
 @brief MobileRTCCameraError An Enum which provide all of Camera related Action Error state.
 */
typedef enum {
    ///Success
    MobileRTCCameraError_Success                                   = 0,
    ///Camera PermissionDenied
    MobileRTCCameraError_CameraPermissionDenied                    = 1,
    ///Do not connect to video session
    MobileRTCCameraError_VideoNotSending                           = 2,
}MobileRTCCameraError;

/*!
 @brief MobileRTCLiveStreamStatus An Enum which provide Live Stream status in meeting.
 */
typedef enum {
    ///Start Successed
    MobileRTCLiveStreamStatus_StartSuccessed               = 0,
    ///Start Failed
    MobileRTCLiveStreamStatus_StartFailedOrEnded           = 1,
    ///Start Timeout
    MobileRTCLiveStreamStatus_StartTimeout                 = 2,
}MobileRTCLiveStreamStatus;

/*!
 @brief MobileRTCClaimHostError An Enum which provide claim host result in meeting.
 */
typedef enum {
    ///Successed
    MobileRTCClaimHostError_Successed                = 0,
    ///Host Key Error
    MobileRTCClaimHostError_HostKeyError             = 1,
    //Network Error
    MobileRTCClaimHostError_NetWorkError             = 2,
}MobileRTCClaimHostError;

/*!
 @brief MobileRTCSendChatError An Enum which provide send chat result in meeting.
 */
typedef enum {
    ///Successed
    MobileRTCSendChatError_Successed                = 0,
    ///Call Failed
    MobileRTCSendChatError_Failed                   = 1,
    ///PermissionDenied
    MobileRTCSendChatError_PermissionDenied         = 2,
}MobileRTCSendChatError;

/*!
 @brief MobileRTCAnnotationError An Enum which provide annotation related action result in meeting.
 */
typedef enum {
    ///Successed
    MobileRTCAnnotationError_Successed                = 0,
    ///Failed
    MobileRTCAnnotationError_Failed                   = 1,
    ///PermissionDenied
    MobileRTCAnnotationError_PermissionDenied         = 2,
}MobileRTCAnnotationError;

/*!
 @brief MobileRTCCMRError An Enum which provide CMR related result.
 */
typedef enum {
    ///Successed
    MobileRTCCMRError_Successed                = 0,
    ///Failed
    MobileRTCCMRError_Failed                   = 1,
    ///Storage Full
    MobileRTCCMRError_StorageFull              = 2,
}MobileRTCCMRError;

/*!
 @brief MobileRTCJoinMeetingInfo An Enum which need provide Join Meeting Info.
 */
typedef enum {
    ///Need Display name
    MobileRTCJoinMeetingInfo_NeedName                = 0,
    ///Need Meeting password
    MobileRTCJoinMeetingInfo_NeedPassword            = 1,
    ///Wrong Meeting password
    MobileRTCJoinMeetingInfo_WrongPassword           = 2,
    ///Need Display name and Meeting Password
    MobileRTCJoinMeetingInfo_NeedNameAndPwd          = 3,
}MobileRTCJoinMeetingInfo;

/*!
 @brief MobileRTCAudioError An Enum of Audio Error.
 */
typedef enum {
    ///microphone muted while speaking
    MobileRTCMicrophoneError_MicMuted                = 0,
    ///audio feedback detected just join into meeting
    MobileRTCMicrophoneError_FeedbackDetected        = 1,
    ///microphone unavailable
    MobileRTCMicrophoneError_MicUnavailable          = 2,
}MobileRTCMicrophoneError;

/*!
 @brief MobileRTCAudioError An Enum of Audio Error.
 */
typedef enum {
    ///Leave meeting by myself
    MobileRTCMeetingEndReason_SelfLeave                 = 0,
    ///Remove from meeting by host
    MobileRTCMeetingEndReason_RemovedByHost             = 1,
    ///meeting end by host
    MobileRTCMeetingEndReason_EndByHost                 = 2,
    ///Join meeting before host timeout
    MobileRTCMeetingEndReason_JBHTimeout                = 3,
    ///free meeting end by timeout
    MobileRTCMeetingEndReason_FreeMeetingTimeout        = 4,
    ///Host end meeting for another meeting
    MobileRTCMeetingEndReason_HostEndForAnotherMeeting  = 6,
    ///Meeting end by connection broken, such as network issue
    MobileRTCMeetingEndReason_ConnectBroken             = 7,

    ///Meeting end by unknown reason
    MobileRTCMeetingEndReason_Unknown,
}MobileRTCMeetingEndReason;

/*!
 @brief MobileRTCRemoteControlError An Enum which provide RemoteControl related action result in meeting.
 */
typedef enum {
    ///Successed
    MobileRTCRemoteControlError_Successed                = 0,
    ///stop
    MobileRTCRemoteControlError_Stop                     = 1,
    ///Failed
    MobileRTCRemoteControlError_Failed                   = 2,
    ///PermissionDenied
    MobileRTCRemoteControlError_PermissionDenied            = 3,
}MobileRTCRemoteControlError;

/*!
 @brief MobileRTCAudioOutput An Enum which provide audio output description.
 */
typedef NS_ENUM(NSUInteger, MobileRTCAudioOutput) {
    ///Unknown
    MobileRTCAudioOutput_Unknown         = 0,
    ///Receiver
    MobileRTCAudioOutput_Receiver        = 1,
    ///Speaker
    MobileRTCAudioOutput_Speaker         = 2,
    ///Headphones
    MobileRTCAudioOutput_Headphones     = 3,
    ///Bluetooth
    MobileRTCAudioOutput_Bluetooth      = 4,
};

/*!
 @brief MobileRTCWebinarAllowAttendeeChat An Enum which provide Webinar Meeting Attendee chat Privilegae description.
 */
typedef NS_ENUM(NSUInteger, MobileRTCChatAllowAttendeeChat) {
    ///Disable Chat
    MobileRTCChatAllowAttendeeChat_ChatWithNone              = 1,
    ///Chat with All
    MobileRTCChatAllowAttendeeChat_ChatWithAll               = 2,
    ///Chat with Panelist
    MobileRTCChatAllowAttendeeChat_ChatWithPanelist          = 3,
};

/*!
 @brief MobileRTCWebinarPromoteorDepromoteError An Enum which provide Webinar Meeting Promote/Depromote Attendee and panelist error type description.
 */
typedef NS_ENUM(NSUInteger, MobileRTCWebinarPromoteorDepromoteError) {
    ///Success
    MobileRTCWebinarPromoteorDepromoteError_Success                                                  = 0,
    ///Chat with All
    MobileRTCWebinarPromoteorDepromoteError_Webinar_Panelist_Capacity_Exceed                         = 3035,
    ///Chat with Panelist
    MobileRTCWebinarPromoteorDepromoteError_Not_Found_Wwbinar_Attendee                               = 3029,
};
