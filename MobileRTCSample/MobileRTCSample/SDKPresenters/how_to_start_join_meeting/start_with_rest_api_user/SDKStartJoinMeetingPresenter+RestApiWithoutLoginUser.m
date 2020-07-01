//
//  SDKStartJoinMeetingPresenter+RestApiWithoutLoginUser.m
//  MobileRTCSample
//
//  Created by Zoom Video Communications on 2018/11/19.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import "SDKStartJoinMeetingPresenter+RestApiWithoutLoginUser.h"
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

typedef enum {
    ///Token
    MobileRTCSampleTokenType_Token,
    ///ZAK
    MobileRTCSampleTokenType_ZAK,
}MobileRTCSampleTokenType;

@implementation SDKStartJoinMeetingPresenter (RestApiWithoutLoginUser)

- (void)startMeeting_RestApiWithoutLoginUser:(BOOL)appShare
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if (ms)
    {
#if 0
        //customize meeting title
        [ms customizeMeetingTitle:@"Sample Meeting Title"];
#endif
    }
    
    //Sample for Start Param interface
    MobileRTCMeetingStartParam * param = nil;

    MobileRTCMeetingStartParam4WithoutLoginUser * user = [[[MobileRTCMeetingStartParam4WithoutLoginUser alloc]init] autorelease];
    user.userType = MobileRTCUserType_APIUser;
    user.meetingNumber = kSDKMeetNumber;
    user.userName = kSDKUserName;
    user.userID = kSDKUserID;
    user.isAppShare = appShare;
    
    /**
    * We recommend that, you can generate kZAK on your own server instead of hardcore in the code.
    * We hardcore it here, just to run the demo.
    *
    * requires you to request the rest API to get Zak
    * @See https://marketplace.zoom.us/docs/api-reference/zoom-api/users/usertoken
    *
    */
    user.zak = kZAK;
    param = user;
    
    MobileRTCMeetError ret = [ms startMeetingWithStartParam:param];
    NSLog(@"onMeetNow ret:%d", ret);
    return;
}

@end
