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


typedef enum {
    //Auth Success
    MobileRTCAuthError_Success,
    //Key or Secret is empty
    MobileRTCAuthError_KeyOrSecretEmpty,
    //Key or Secret is wrong
    MobileRTCAuthError_KeyOrSecretWrong,
    //Client Account does not support
    MobileRTCAuthError_AccountNotSupport,
    //Client account does not enable SDK
    MobileRTCAuthError_AccountNotEnableSDK,
    //Auth Unknown error
    MobileRTCAuthError_Unknown,
}MobileRTCAuthError;

typedef enum {
    //Success
    MobileRTCMeetError_Success                    = 0,
    //Incorrect meeting number
    MobileRTCMeetError_IncorrectMeetingNumber     = 1,
    //Meeting Timeout
    MobileRTCMeetError_MeetingTimeout             = 2,
    //Network Unavailable
    MobileRTCMeetError_NetworkUnavailable         = 3,
    //Client Version Incompatible
    MobileRTCMeetError_MeetingClientIncompatible  = 4,
    //User is Full
    MobileRTCMeetError_UserFull                   = 5,
    //Meeting is over
    MobileRTCMeetError_MeetingOver                = 6,
    //Meeting does not exist
    MobileRTCMeetError_MeetingNotExist            = 7,
    //Meeting has been locked
    MobileRTCMeetError_MeetingLocked              = 8,
    //Meeting Restricted
    MobileRTCMeetError_MeetingRestricted          = 9,
    //JBH Meeting Restricted
    MobileRTCMeetError_MeetingJBHRestricted       = 10,
    
    //Invalid Arguments
    MobileRTCMeetError_InvalidArguments           = 99,
    //Invalid Arguments
    MobileRTCMeetError_InvalidUserType            = 100,
    //Already In another ongoing meeting
    MobileRTCMeetError_InAnotherMeeting           = 101,
    //Unknown error
    MobileRTCMeetError_Unknown                    = 102,
    
}MobileRTCMeetError;

typedef enum {
    //Idle
    MobileRTCMeetingState_Idle        = 0,
    //Connecting
    MobileRTCMeetingState_Connecting  = 1,
    //In Meeting
    MobileRTCMeetingState_InMeeting   = 2,
    
}MobileRTCMeetingState;


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
