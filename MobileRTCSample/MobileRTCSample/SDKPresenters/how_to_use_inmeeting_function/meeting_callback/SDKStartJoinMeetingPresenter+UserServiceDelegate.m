//
//  SDKStartJoinMeetingPresenter+UserServiceDelegate.m
//  MobileRTCSample
//
//  Created by Murray Li on 2018/11/30.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import "SDKStartJoinMeetingPresenter+UserServiceDelegate.h"
#import "CustomMeetingViewController+MeetingDelegate.h"

@implementation SDKStartJoinMeetingPresenter (UserServiceDelegate)

#pragma mark - User Service Delegate

- (void)onSinkMeetingUserJoin:(NSUInteger)userID
{
    if (self.customMeetingVC)
    {
        [self.customMeetingVC onSinkMeetingUserJoin:userID];
    }
}

- (void)onSinkMeetingUserLeft:(NSUInteger)userID
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    MobileRTCMeetingUserInfo *leftUser = [ms userInfoByID:userID];
    NSLog(@"User Left : %@", leftUser);
    if (self.customMeetingVC)
    {
        [self.customMeetingVC onSinkMeetingUserLeft:userID];
    }
}

#pragma mark - In meeting users' state updated
- (void)onInMeetingUserUpdated
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    NSArray *users = [ms getInMeetingUserList];
    NSLog(@"In Meeting users:%@", users);
}

- (void)onInMeetingChat:(NSString *)messageID
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    NSLog(@"In Meeting Chat:%@ content:%@", messageID, [ms meetingChatByID:messageID]);
}

@end
