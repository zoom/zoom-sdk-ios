//
//  SDKStartJoinMeetingPresenter+AudioServiceDelegate.m
//  MobileRTCSample
//
//  Created by Murray Li on 2018/12/5.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import "SDKStartJoinMeetingPresenter+AudioServiceDelegate.h"
#import "CustomMeetingViewController+MeetingDelegate.h"

@implementation SDKStartJoinMeetingPresenter (AudioServiceDelegate)

#pragma mark - Audio Service Delegate

- (void)onSinkMeetingAudioStatusChange:(NSUInteger)userID
{
    if (self.customMeetingVC)
    {
        [self.customMeetingVC onSinkMeetingAudioStatusChange:userID];
    }
}

- (void)onMyAudioStateChange
{
    if (self.customMeetingVC)
    {
        [self.customMeetingVC onSinkMeetingAudioStatusChange:0];
    }
}

#if 0
- (void)onSinkMeetingAudioRequestUnmuteByHost
{
    NSLog(@"the host require meeting attendants to enable microphone");
}
#endif

@end
