//
//  SDKStartJoinMeetingPresenter+JoinMeetingOnly.m
//  MobileRTCSample
//
//  Created by Murray Li on 2018/11/20.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import "SDKStartJoinMeetingPresenter+JoinMeetingOnly.h"

@implementation SDKStartJoinMeetingPresenter (JoinMeetingOnly)

- (void)joinMeeting:(NSString*)meetingNo withPassword:(NSString*)pwd
{
    if (![meetingNo length])
        return;
    
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if (ms)
    {
#if 0
        //customize meeting title
        [ms customizeMeetingTitle:@"Sample Meeting Title"];
#endif
        
        //For Join a meeting with password
        NSDictionary *paramDict = @{
                                    kMeetingParam_Username:kSDKUserName,
                                    kMeetingParam_MeetingNumber:meetingNo,
                                    kMeetingParam_MeetingPassword:pwd,
                                    //kMeetingParam_ParticipantID:kParticipantID,
                                    //kMeetingParam_WebinarToken:kWebinarToken,
                                    //kMeetingParam_NoAudio:@(YES),
                                    //kMeetingParam_NoVideo:@(YES),
                                    };
        //            //For Join a meeting
        //            NSDictionary *paramDict = @{
        //                                        kMeetingParam_Username:kSDKUserName,
        //                                        kMeetingParam_MeetingNumber:meetingNo,
        //                                        kMeetingParam_MeetingPassword:pwd,
        //                                        };
        
        MobileRTCMeetError ret = [ms joinMeetingWithDictionary:paramDict];
        
        NSLog(@"onJoinaMeeting ret:%d", ret);
    }
}

@end
