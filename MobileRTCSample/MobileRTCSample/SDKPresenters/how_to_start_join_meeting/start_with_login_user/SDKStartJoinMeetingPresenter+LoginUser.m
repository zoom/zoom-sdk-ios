//
//  SDKStartJoinMeetingPresenter+LoginUser.m
//  MobileRTCSample
//
//  Created by Murray Li on 2018/11/19.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import "SDKStartJoinMeetingPresenter+LoginUser.h"

@implementation SDKStartJoinMeetingPresenter (LoginUser)

- (void)startMeeting_emailLoginUser:(BOOL)appShare
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
    MobileRTCMeetingStartParam4LoginlUser * user = [[[MobileRTCMeetingStartParam4LoginlUser alloc]init]autorelease];
    param = user;
    param.meetingNumber = kSDKMeetNumber; // if kSDKMeetNumber is empty, it‘s a instant meeting.
    param.isAppShare = appShare;
    MobileRTCMeetError ret = [ms startMeetingWithStartParam:param];
    NSLog(@"onMeetNow ret:%d", ret);
    return;
}

@end
