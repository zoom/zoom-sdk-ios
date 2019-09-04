//
//  SDKStartJoinMeetingPresenter+VideoServiceDelegate.m
//  MobileRTCSample
//
//  Created by Murray Li on 2018/12/5.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import "SDKStartJoinMeetingPresenter+VideoServiceDelegate.h"
#import "CustomMeetingViewController+MeetingDelegate.h"

@implementation SDKStartJoinMeetingPresenter (VideoServiceDelegate)

#pragma mark - Video Service Delegate

- (void)onSinkMeetingActiveVideo:(NSUInteger)userID
{
    if (self.customMeetingVC)
    {
        [self.customMeetingVC onSinkMeetingActiveVideo:userID];
    }
}

- (void)onSinkMeetingPreviewStopped
{
    if (self.customMeetingVC)
    {
        [self.customMeetingVC onSinkMeetingPreviewStopped];
    }
}


- (void)onSinkMeetingVideoStatusChange:(NSUInteger)userID
{
    if (self.customMeetingVC)
    {
        [self.customMeetingVC onSinkMeetingVideoStatusChange:userID];
    }
}

- (void)onMyVideoStateChange
{
    if (self.customMeetingVC)
    {
        [self.customMeetingVC onMyVideoStateChange];
    }
}

- (void)onSinkMeetingVideoQualityChanged:(MobileRTCNetworkQuality)qality userID:(NSUInteger)userID
{
    NSLog(@"onSinkMeetingVideoQualityChanged: %zd userID:%zd",qality,userID);
}

- (void)onSinkMeetingVideoRequestUnmuteByHost:(void (^)(BOOL Accept))completion
{
    if (completion)
    {
        completion(YES);
    }
}

@end
