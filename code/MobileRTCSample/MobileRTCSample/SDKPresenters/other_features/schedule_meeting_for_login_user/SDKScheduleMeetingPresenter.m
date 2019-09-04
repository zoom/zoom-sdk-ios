//
//  SDKScheduleMeetingPresenter.m
//  MobileRTCSample
//
//  Created by Murray Li on 2018/11/27.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import "SDKScheduleMeetingPresenter.h"

@implementation SDKScheduleMeetingPresenter


- (BOOL)scheduleMeeting:(nonnull id<MobileRTCMeetingItem>)meetingItem WithScheduleFor:(nullable NSString *)userEmail
{
    return [[[MobileRTC sharedRTC] getPreMeetingService] scheduleMeeting:meetingItem WithScheduleFor:userEmail];
}

- (BOOL)deleteMeeting:(id<MobileRTCMeetingItem>)meetingItem
{
     return [[[MobileRTC sharedRTC] getPreMeetingService] deleteMeeting:meetingItem];
}

@end
