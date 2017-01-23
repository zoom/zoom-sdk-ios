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

#if defined(_ZM_BOX_SDK_)
/**
 * Design for enable BoxSDK in MobileRTC.
 *
 * **Note**: Before using MobileRTC, the client should setup App Key and Secret of BoxSDK by [[NSUserDefaults standardUserDefaults] setObject:@"xxx" forKey:kBoxSDKAppKey], [[NSUserDefaults standardUserDefaults] setObject:@"yyy" forKey:kBoxSDKAppSecret].
 */
#define kBoxSDKAppKey               @"BoxSDK.AppKey"
#define kBoxSDKAppSecret            @"BoxSDK.AppSecret"
#endif

#if defined(_ZM_DROPBOX_SDK_)
/**
 * Design for enable Dropbox in MobileRTC.
 *
 * **Note**: Before using MobileRTC, the client should setup App Key and Secret of DropboxSDK by [[NSUserDefaults standardUserDefaults] setObject:@"xxx" forKey:kDropboxSDKAppKey], [[NSUserDefaults standardUserDefaults] setObject:@"yyy" forKey:kDropboxSDKAppSecret].
 */
#define kDropboxSDKAppKey           @"DropboxSDK.AppKey"
#define kDropboxSDKAppSecret        @"DropboxSDK.AppSecret"
#endif


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

