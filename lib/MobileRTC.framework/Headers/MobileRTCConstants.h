//
//  MobileRTCConstants.h
//  MobileRTC
//
//  Created by Zoom Video Communications on 8/7/14.
//  Copyright (c) 2019 Zoom Video Communications, Inc. All rights reserved.
//

//MobileRTC Base Domain
#define kMobileRTCBaseDomain @"zoom.us"

/*!
 @brief An enumeration of SDK authentication.
 */
typedef enum {
    ///Authentication is successful
    MobileRTCAuthError_Success,
    ///Key or secret is empty
    MobileRTCAuthError_KeyOrSecretEmpty,
    ///Key or secret is wrong
    MobileRTCAuthError_KeyOrSecretWrong,
    ///Client account does not support
    MobileRTCAuthError_AccountNotSupport,
    ///Client account does not enable SDK
    MobileRTCAuthError_AccountNotEnableSDK,
    ///Unknown error
    MobileRTCAuthError_Unknown,
    ///Service is busy
    MobileRTCAuthError_ServiceBusy,
    ///<Initial status.
    MobileRTCAuthError_None,
    ///Request over time
    MobileRTCAuthError_OverTime,
    ///<Network issues.
    MobileRTCAuthError_NetworkIssue,
    ///Account does not support this SDK version
    MobileRTCAuthError_ClientIncompatible,

}MobileRTCAuthError;

/*!
 @brief MobileRTCMeetError An enumeration of Meeting States.
 */
typedef enum {
    ///Start/Join meeting successfully.
    MobileRTCMeetError_Success                          = 0,
    ///Network issue, please check the network connection.
    MobileRTCMeetError_NetworkError                     = 1,
    ///Failed to reconnect the meeting.
    MobileRTCMeetError_ReconnectError                   = 2,
    ///MMR issue, please check MMR configuration.
    MobileRTCMeetError_MMRError                         = 3,
    ///The meeting password is incorrect.
    MobileRTCMeetError_PasswordError                    = 4,
    ///Failed to create video and audio data connection with MMR.
    MobileRTCMeetError_SessionError                     = 5,
    ///Meeting is over.
    MobileRTCMeetError_MeetingOver                      = 6,
    ///Meeting is not started.
    MobileRTCMeetError_MeetingNotStart                  = 7,
    ///The meeting does not exist.
    MobileRTCMeetError_MeetingNotExist                  = 8,
    ///The amount of attendees reaches the upper limit.
    MobileRTCMeetError_MeetingUserFull                  = 9,
    ///The MobileRTC version is incompatible.
    MobileRTCMeetError_MeetingClientIncompatible        = 10,
    ///No MMR is valid.
    MobileRTCMeetError_NoMMR                            = 11,
    ///The meeting is locked by the host.
    MobileRTCMeetError_MeetingLocked                    = 12,
    ///The meeting is restricted.
    MobileRTCMeetError_MeetingRestricted                = 13,   
    ///The meeting is restricted to join before host.
    MobileRTCMeetError_MeetingRestrictedJBH             = 14,
    ///Failed to request the web server.
    MobileRTCMeetError_CannotEmitWebRequest             = 15,
    ///Failed to start meeting with expired token.
    MobileRTCMeetError_CannotStartTokenExpire           = 16,
    ///The user's video does not work.
    MobileRTCMeetError_VideoError                       = 17,
    ///The user's audio cannot auto-start.
    MobileRTCMeetError_AudioAutoStartError              = 18,
    ///The amount of webinar attendees reaches the upper limit.
    MobileRTCMeetError_RegisterWebinarFull              = 19,
    ///User needs to register a webinar account if he wants to start a webinar.
    MobileRTCMeetError_RegisterWebinarHostRegister      = 20,
    ///User needs to register an account if he wants to join the webinar by the link.
    MobileRTCMeetError_RegisterWebinarPanelistRegister  = 21,
    ///The host has denied your webinar registration.
    MobileRTCMeetError_RegisterWebinarDeniedEmail       = 22,
    ///Sign in with the specified account to join webinar.
    MobileRTCMeetError_RegisterWebinarEnforceLogin      = 23,
    ///The certificate of ZC has been changed.
    MobileRTCMeetError_ZCCertificateChanged             = 24,
    ///The vanity URL does not exist.
    MobileRTCMeetError_VanityNotExist                   = 27,
    ///The email address has already been registered in the current webinar.
    MobileRTCMeetError_JoinWebinarWithSameEmail         = 28,
    ///Failed to write configure file.
    MobileRTCMeetError_WriteConfigFile                  = 50,
    ///Meeting is removed by the host.
    MobileRTCMeetError_RemovedByHost                    = 61,
    ///Invalid arguments.
    MobileRTCMeetError_InvalidArguments                 = MobileRTCMeetError_WriteConfigFile + 100,
    ///Invalid user Type.
    MobileRTCMeetError_InvalidUserType,
    ///The user joins already another ongoing meeting.
    MobileRTCMeetError_InAnotherMeeting,
    ///The virtual background error base
    MobileRTCMeetError_VBBase                           = 200,
    ///Set image for virtual background error
    MobileRTCMeetError_VBSetError                       = MobileRTCMeetError_VBBase,
    ///Virtual background image reach to max capacity
    MobileRTCMeetError_VBMaximumNum,
    ///Virtual background save the image error
    MobileRTCMeetError_VBSaveImage,
    ///Virtual background save the image error
    MobileRTCMeetError_VBRemoveNone,
    ///Virtual background not support
    MobileRTCMeetError_VBNoSupport,
    
    ///Unknown error.
    MobileRTCMeetError_Unknown,

}MobileRTCMeetError;

/*!
 @brief MobileRTCMeetingState An enumeration of meeting states.
 */
typedef enum {
    ///No meeting is running.
    MobileRTCMeetingState_Idle              = 0,
    ///Connect to the meeting server status.
    MobileRTCMeetingState_Connecting        = 1,
    ///Meeting is ready, in meeting status.
    MobileRTCMeetingState_InMeeting         = 2,
    ///Upgrade the attendees to panelist in webinar.
    MobileRTCMeetingState_WebinarPromote    = 3,
    ///Demote the attendees from the panelist.
    MobileRTCMeetingState_WebinarDePromote  = 4,
}MobileRTCMeetingState;

/*!
 @brief MobileRTCUserType An enumeration of user types.
 */
typedef enum {
    ///User logs in with Facebook account.
    MobileRTCUserType_Facebook    = 0,
    ///User logs in with Google authentication.
    MobileRTCUserType_GoogleOAuth = 2,
    ///API user.
    MobileRTCUserType_APIUser     = 99,
    ///User logs in with working email.
    MobileRTCUserType_ZoomUser    = 100,
    ///Single-sign-on user.
    MobileRTCUserType_SSOUser     = 101,
    ///Unknown user type.
    MobileRTCUserType_Unknown     = 102,
}MobileRTCUserType;

/*!
 @brief LeaveMeetingCmd An enumeration of commands for leaving meeting.
 */
typedef enum {
    ///Command of leaving meeting.
    LeaveMeetingCmd_Leave,
    ///Command of ending Meeting.
    LeaveMeetingCmd_End,
}LeaveMeetingCmd;

/*!
 @brief JBHCmd An enumeration of waiting UI when JBH is disabled.
 */
typedef enum {
    ///Show JBH waiting command.
    JBHCmd_Show,
    ///Hide JBH waiting command.
    JBHCmd_Hide,
}JBHCmd;

/*!
 @brief DialOutStatus An enumeration of outgoing call states.
 */
typedef enum {
    ///Unknown outgoing call status.
    DialOutStatus_Unknown  = 0,
    ///Calling in process.
    DialOutStatus_Calling,
    ///In process of ringing.
    DialOutStatus_Ringing,
    ///The call is accepted by the receiver.
    DialOutStatus_Accepted,
    ///The telephone service is busy.
    DialOutStatus_Busy,
    ///The telephone is out of service.
    DialOutStatus_NotAvailable,
    ///The phone is hung up.
    DialOutStatus_UserHangUp,
    ///Other reasons.
    DialOutStatus_OtherFail,
    ///Join meeting successfully.
    DialOutStatus_JoinSuccess,
    ///Outgoing call timeout.
    DialOutStatus_TimeOut,
    ///Start to cancel outgoing call. 
    DialOutStatus_ZoomStartCancelCall,
    ///The outgoing call is canceled.
    DialOutStatus_ZoomCallCanceled,
    ///Failed to cancel outgoing call.
    DialOutStatus_ZoomCancelCallFail,
    ///The call is not answered.
    DialOutStatus_NoAnswer,
    ///Disable the function of international outgoing call before the host joins the meeting.
    DialOutStatus_BlockNoHost,
    ///The call-out is blocked by the system due to high cost.
    DialOutStatus_BlockHighRate,
    ///All the invitees invited by the call should press the button one(1) to join the meeting. In case that many invitees do not press the button that leads to time out, the call invitation for this meeting shall be banned.
    DialOutStatus_BlockTooFrequent,
}DialOutStatus;

/*!
 @brief H323CallOutStatus An enumeration of H.323/SIP outgoing call status.  
 */
typedef enum {
    ///OK
    H323CallOutStatus_Success        = 0,
    ///Ring
    H323CallOutStatus_Ring,
    ///Timeout
    H323CallOutStatus_Timeout,
    ///Busy
    H323CallOutStatus_Busy,
    ///Decline
    H323CallOutStatus_Decline,
    ///Failed
    H323CallOutStatus_Failed,
}H323CallOutStatus;

/*!
 @brief MobileRTCH323ParingStatus An enumeration of H.323/SIP pairing status.
 */
typedef NS_ENUM(NSUInteger, MobileRTCH323ParingStatus) {
    ///Success
    MobileRTCH323ParingStatus_Success = 0,
    ///Meeting does not Exist
    MobileRTCH323ParingStatus_MeetingNotExisted,
    ///No permission
    MobileRTCH323ParingStatus_PermissionDenied,
    ///Paring Code is not existed
    MobileRTCH323ParingStatus_ParingcodeNotExisted,
    ///Error
    MobileRTCH323ParingStatus_Error,
};

/*!
 @brief MobileRTCComponentType An enumeration of all component types.
 */
typedef enum {
    ///Default component type.
    MobileRTCComponentType_Def    = 0,
    ///Chat.
    MobileRTCComponentType_Chat,
    ///File Transfer.
    MobileRTCComponentType_FT,
    ///Audio.
    MobileRTCComponentType_AUDIO,
    ///Video.
    MobileRTCComponentType_VIDEO,
    ///Share application.
    MobileRTCComponentType_AS,
}MobileRTCComponentType;

/*!
 @brief MobileRTCNetworkQuality Quality of session network.
 */
typedef enum {
    ///Unknown connection status.
    MobileRTCNetworkQuality_Unknown     = -1,
    ///The connection quality is very poor.
    MobileRTCNetworkQuality_VeryBad     = 0,
    ///The connection quality is very poor.
    MobileRTCNetworkQuality_Bad         = 1,
    ///The connection quality is not good.
    MobileRTCNetworkQuality_NotGood     = 2,
    ///The connection quality is normal.
    MobileRTCNetworkQuality_Normal      = 3,
    ///The connection quality is good.
    MobileRTCNetworkQuality_Good        = 4,
    ///The connection quality is excellent.
    MobileRTCNetworkQuality_Excellent   = 5,
}MobileRTCNetworkQuality;

/*!
 @brief MobileRTCAudioError An enumeration of audio-related operational error states.
 */
typedef enum {
    ///Success
    MobileRTCAudioError_Success                                   = 0,
    ///The application for Audio Session Recording is Denied
    MobileRTCAudioError_AudioPermissionDenied                     = 1,
    ///Do not connect to audio session.
    MobileRTCAudioError_AudioNotConnected                         = 2,
    ///User can not unmute his Audio.
    MobileRTCAudioError_CannotUnmuteMyAudio                       = 3,
}MobileRTCAudioError;

/*!
 @brief MobileRTCVideoError An enumeration of video-related operational error states.
 */
typedef enum {
    ///Success
    MobileRTCVideoError_Success                                   = 0,
    ///Camera Permission is Denied
    MobileRTCVideoError_CameraPermissionDenied                    = 1,
    ///User can not unmute his Audio.
    MobileRTCVideoError_CannotUnmuteMyVideo                       = 3,
}MobileRTCVideoError;

/*!
 @brief MobileRTCCameraError An enumeration of camera-related operational error states.
 */
typedef enum {
    ///Success
    MobileRTCCameraError_Success                                   = 0,
    ///The permission to enable the camera is denied
    MobileRTCCameraError_CameraPermissionDenied                    = 1,
    ///The camera can not connect to video session
    MobileRTCCameraError_VideoNotSending                           = 2,
}MobileRTCCameraError;

/*!
 @brief MobileRTCLiveStreamStatus An enumeration of Live Stream status in meeting.
 */
typedef enum {
    ///Start live stream successfully.
    MobileRTCLiveStreamStatus_StartSuccessed               = 0,
    ///Start live stream failed
    MobileRTCLiveStreamStatus_StartFailedOrEnded           = 1,
    ///Start live stream timeout
    MobileRTCLiveStreamStatus_StartTimeout                 = 2,
}MobileRTCLiveStreamStatus;

/*!
 @brief MobileRTCClaimHostError An enumeration of CLAIM HOST results in meeting.
 */
typedef enum {
    ///Claim host successfully.
    MobileRTCClaimHostError_Successed                = 0,
    ///Host Key Errors.
    MobileRTCClaimHostError_HostKeyError             = 1,
    ///Network Errors.
    MobileRTCClaimHostError_NetWorkError             = 2,
}MobileRTCClaimHostError;

/*!
 @brief MobileRTCSendChatError An enumeration of SENDING CHAT MESSAGE result in meeting.
 */
typedef enum {
    ///Send chat message successfully.
    MobileRTCSendChatError_Successed                = 0,
    ///Send chat message failed.
    MobileRTCSendChatError_Failed                   = 1,
    ///No permission.
    MobileRTCSendChatError_PermissionDenied         = 2,
}MobileRTCSendChatError;

/*!
 @brief MobileRTCAnnotationError An enumeration of annotation-related operational error states.
 */
typedef enum {
    ///Succeeded
    MobileRTCAnnotationError_Successed                = 0,
    ///Failed
    MobileRTCAnnotationError_Failed                   = 1,
    ///No permission.
    MobileRTCAnnotationError_PermissionDenied         = 2,
}MobileRTCAnnotationError;

/*!
 @brief MobileRTCCMRError An enumeration of CMR-related result error states.
 */
typedef enum {
    ///Succeeded
    MobileRTCCMRError_Successed                = 0,
    ///Failed
    MobileRTCCMRError_Failed                   = 1,
    ///The storage is full
    MobileRTCCMRError_StorageFull              = 2,
}MobileRTCCMRError;

/*!
 @brief MobileRTCJoinMeetingInfo An enumeration of information needed to Join Meeting.
 */
typedef enum {
    ///Display name is needed.
    MobileRTCJoinMeetingInfo_NeedName                = 0,
    ///Meeting password is needed. 
    MobileRTCJoinMeetingInfo_NeedPassword            = 1,
    ///Meeting password is wrong.
    MobileRTCJoinMeetingInfo_WrongPassword           = 2,
    ///Screen name and meeting Password are needed.
    MobileRTCJoinMeetingInfo_NeedNameAndPwd          = 3,
}MobileRTCJoinMeetingInfo;

/*!
 @brief MobileRTCAudioError An enumeration of Audio Errors.
 */
typedef enum {
    ///Microphone is muted while speaking.
    MobileRTCMicrophoneError_MicMuted                = 0,
    ///Audio feedback is detected when join meeting.
    MobileRTCMicrophoneError_FeedbackDetected        = 1,
    ///Microphone is unavailable.
    MobileRTCMicrophoneError_MicUnavailable          = 2,
}MobileRTCMicrophoneError;

/*!
 @brief MobileRTCAudioError An enumeration of Audio Errors.
 */
typedef enum {
    ///User leaves meeting.
    MobileRTCMeetingEndReason_SelfLeave                 = 0,
    ///The user is removed from meeting by the host.
    MobileRTCMeetingEndReason_RemovedByHost             = 1,
    ///Host ends the meeting.
    MobileRTCMeetingEndReason_EndByHost                 = 2,
    ///Join the meeting before host (JBH) timeout.
    MobileRTCMeetingEndReason_JBHTimeout                = 3,
    ///Meeting ends when the free service is over.
    MobileRTCMeetingEndReason_FreeMeetingTimeout        = 4,
    ///Meeting ends by the host for he will start another meeting.
    MobileRTCMeetingEndReason_HostEndForAnotherMeeting  = 6,
    ///Meeting ends for SDK disconnects, such as network issue.
    MobileRTCMeetingEndReason_ConnectBroken             = 7,
    ///Meeting ends by unknown reasons.
    MobileRTCMeetingEndReason_Unknown,
}MobileRTCMeetingEndReason;

/*!
 @brief MobileRTCRemoteControlError An enumeration of remote control-related operational result in meeting.
 */
typedef enum {
    ///Succeeded
    MobileRTCRemoteControlError_Successed                = 0,
    ///stop
    MobileRTCRemoteControlError_Stop                     = 1,
    ///Failed
    MobileRTCRemoteControlError_Failed                   = 2,
    ///No Permission 
    MobileRTCRemoteControlError_PermissionDenied            = 3,
}MobileRTCRemoteControlError;

/*!
 @brief MobileRTCAudioOutput An enumeration of audio output description.
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
    ///Blue-tooth
    MobileRTCAudioOutput_Bluetooth      = 4,
};

/*!
 @brief MobileRTCWebinarAllowAttendeeChat An enumeration of attendee chat permission in webinar.
 */
typedef NS_ENUM(NSUInteger, MobileRTCChatAllowAttendeeChat) {
    ///Chat is disabled
    MobileRTCChatAllowAttendeeChat_ChatWithNone              = 1,
    ///Chat with all
    MobileRTCChatAllowAttendeeChat_ChatWithAll               = 2,
    ///Chat with panelist
    MobileRTCChatAllowAttendeeChat_ChatWithPanelist          = 3,
};

/*!
 @brief MobileRTCWebinarPromoteorDepromoteError An enumeration of promoting/demoting attendee and panelist errors in webinar.
 */
typedef NS_ENUM(NSUInteger, MobileRTCWebinarPromoteorDepromoteError) {
    ///Promote/demote successfully.
    MobileRTCWebinarPromoteorDepromoteError_Success                                                  = 0,
    ///The amount of panelist in webinar reaches the upper limit. 
    MobileRTCWebinarPromoteorDepromoteError_Webinar_Panelist_Capacity_Exceed                         = 3035,
    ///The attendees in webinar are not found.
    MobileRTCWebinarPromoteorDepromoteError_Not_Found_Webinar_Attendee                               = 3029,
};

/*!
 @brief MobileRTCMeetingItemAudioType An enumeration of audio types in meeting.
 */
typedef NS_ENUM(NSUInteger, MobileRTCMeetingItemAudioType) {
    ///Unknown
    MobileRTCMeetingItemAudioType_Unknown                    = 0,
    ///Telephone Only
    MobileRTCMeetingItemAudioType_TelephoneOnly              = 1,
    ///VoIP Only
    MobileRTCMeetingItemAudioType_VoipOnly                   = 2,
    ///Telephone And VoIP
    MobileRTCMeetingItemAudioType_TelephoneAndVoip           = 3,
    ///The 3rd Party Audio
    MobileRTCMeetingItemAudioType_3rdPartyAudio              = 4,
};

/*!
 @brief MobileRTCMeetingItemRecordType An enumeration of meeting recording types in meeting.
 */
typedef NS_ENUM(NSUInteger, MobileRTCMeetingItemRecordType) {
    ///Automatic recording is disabled
    MobileRTCMeetingItemRecordType_AutoRecordDisabled               = 0,
    ///Local Recording
    MobileRTCMeetingItemRecordType_LocalRecord                      = 1,
    ///Cloud Recording
    MobileRTCMeetingItemRecordType_CloudRecord                      = 2,
};

/*!
 @brief MobileRTCMeetingChatPriviledgeType An enumeration of meeting chat types in meeting.
 */
typedef NS_ENUM(NSUInteger, MobileRTCMeetingChatPriviledgeType) {
    /// Unknown type
    MobileRTCMeetingChatPriviledge_Unknown = 0,
    /// allow attendee to chat with everyone
    MobileRTCMeetingChatPriviledge_Everyone_Publicly_And_Privately,
    /// allow attendee to chat with host only
    MobileRTCMeetingChatPriviledge_Host_Only,
    /// allow attendee to chat with no one
    MobileRTCMeetingChatPriviledge_No_One,
    /// allow attendee to chat with host and public
    MobileRTCMeetingChatPriviledge_Everyone_Publicly,
};

typedef NS_ENUM(NSUInteger, MobileRTCVideoType) {
    ///Video Camera Data
    MobileRTCVideoType_VideoData  = 1,
    ///Share Data
    MobileRTCVideoType_ShareData,
};

/*!
 @brief MobileRTCVideoResolution An enumeration of video raw data resolution.
 */
typedef NS_ENUM(NSUInteger, MobileRTCVideoResolution) {
    /// video resolution 90
    MobileRTCVideoResolution_90,
    /// video resolution 180
    MobileRTCVideoResolution_180,
    /// video resolution 360
    MobileRTCVideoResolution_360,
    /// video resolution 720
    MobileRTCVideoResolution_720,
};

/*!
 @brief MobileRTCVideoResolution An enumeration of video raw data format.
 */
typedef NS_ENUM(NSUInteger, MobileRTCVideoRawDataFormat) {
    MobileRTCVideoRawDataFormatI420            = 1,
    MobileRTCVideoRawDataFormatI420_Limit,
};

/*!
 @brief MobileRTCVideoResolution The direction of video.
 */
typedef NS_ENUM(NSInteger, MobileRTCVideoRawDataRotation) {
    /// video direction 0
    MobileRTCVideoRawDataRotationNone      = 1,
    /// video direction 90
    MobileRTCVideoRawDataRotation90,
    /// video direction 180
    MobileRTCVideoRawDataRotation180,
    /// video direction 270
    MobileRTCVideoRawDataRotation270,
};

/*!
 @brief MobileRTCRawDataError An enumeration of raw data.
 */
typedef NS_ENUM(NSUInteger,MobileRTCRawDataError)
{
    MobileRTCRawData_Success,
    MobileRTCRawData_Uninitialized,
    MobileRTCRawData_Malloc_Failed,
    MobileRTCRawData_Wrongusage,
    MobileRTCRawData_Invalid_Param,
    MobileRTCRawData_Not_In_Meeting,
    MobileRTCRawData_No_License,
    
    MobileRTCRawData_Video_Module_Not_Ready,
    MobileRTCRawData_Video_Module_Error,
    MobileRTCRawData_Video_device_error,
    MobileRTCRawData_No_Video_Data,
    
    MobileRTCRawData_Share_Module_Not_Ready,
    MobileRTCRawData_Hare_Module_Error,
    MobileRTCRawData_No_Share_Data,
    
    MobileRTCRawData_Audio_Module_Not_Ready,
    MobileRTCRawData_Audio_Module_Error,
    MobileRTCRawData_No_Audio_Data,
};

/*!
 @brief Rawdata memory mode.
 */
typedef NS_ENUM(NSUInteger, MobileRTCRawDataMemoryMode) {
    MobileRTCRawDataMemoryModeStack,
    MobileRTCRawDataMemoryModeHeap
};

/*!
 @brief Locale fo Customer.
 */
typedef NS_ENUM(NSUInteger, MobileRTC_ZoomLocale) {
    MobileRTC_ZoomLocale_Default,
    MobileRTC_ZoomLocale_CN
};

/*!
 @brief for SMS service usage.
 */
typedef NS_ENUM(NSUInteger, MobileRTCSMSServiceErr) {
    Unknown,
    Success,
    Retrieve_SendSMSFailed,
    Retrieve_InvalidPhoneNum,
    Retrieve_PhoneNumAlreadyBound,
    Retrieve_PhoneNumSendTooFrequent,
    Verify_CodeIncorrect,
    Verify_CodeExpired,
    Verify_UnknownError,
};

/*!
 @brief Minimize Meeting state in Zoom UI.
 */
typedef NS_ENUM(NSUInteger, MobileRTCMinimizeMeetingState) {
    MobileRTCMinimizeMeeting_ShowMinimizeMeeting,
    MobileRTCMinimizeMeeting_BackFullScreenMeeting
};
