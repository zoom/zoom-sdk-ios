//
//  SDKStartJoinMeetingPresenter+ShareServiceDelegate.m
//  MobileRTCSample
//
//  Created by Murray Li on 2018/12/5.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import "SDKStartJoinMeetingPresenter+ShareServiceDelegate.h"
#import "CustomMeetingViewController+MeetingDelegate.h"
#import "MainViewController+MeetingDelegate.h"

@implementation SDKStartJoinMeetingPresenter (ShareServiceDelegate)

- (void)onSinkMeetingActiveShare:(NSUInteger)userID
{
    if (self.customMeetingVC)
    {
        [self.customMeetingVC onSinkMeetingActiveShare:userID];
    }
}

- (void)onSinkShareSizeChange:(NSUInteger)userID
{
    if (self.customMeetingVC)
    {
        [self.customMeetingVC onSinkShareSizeChange:userID];
    }
}

- (void)onSinkMeetingShareReceiving:(NSUInteger)userID
{
    if (self.customMeetingVC)
    {
        [self.customMeetingVC onSinkMeetingShareReceiving:userID];
    }
}

- (void)onAppShareSplash
{
    if (self.mainVC) {
        [self.mainVC onAppShareSplash];
    }
}



@end
