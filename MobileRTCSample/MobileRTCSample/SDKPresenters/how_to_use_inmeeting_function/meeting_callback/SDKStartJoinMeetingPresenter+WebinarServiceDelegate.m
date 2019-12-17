//
//  SDKStartJoinMeetingPresenter+WebinarServiceDelegate.m
//  MobileRTCSample
//
//  Created by Murray Li on 2018/12/5.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import "SDKStartJoinMeetingPresenter+WebinarServiceDelegate.h"

@implementation SDKStartJoinMeetingPresenter (WebinarServiceDelegate)

- (void)onSinkAllowAttendeeChatNotification:(MobileRTCChatAllowAttendeeChat)currentPrivilege
{
    NSLog(@"onSinkAllowAttendeeChatNotification %zd",currentPrivilege);
}

- (void)onSinkQAAllowAskQuestionAnonymouslyNotification:(BOOL)beAllowed
{
    NSLog(@"onSinkQAAllowAskQuestionAnonymouslyNotification %zd",beAllowed);
}

- (void)onSinkQAAllowAttendeeViewAllQuestionNotification:(BOOL)beAllowed
{
    NSLog(@"onSinkQAAllowAttendeeViewAllQuestionNotification %zd",beAllowed);
}

- (void)onSinkQAAllowAttendeeUpVoteQuestionNotification:(BOOL)beAllowed
{
    NSLog(@"onSinkQAAllowAttendeeUpVoteQuestionNotification %zd",beAllowed);
}

- (void)onSinkQAAllowAttendeeAnswerQuestionNotification:(BOOL)beAllowed
{
    NSLog(@"onSinkQAAllowAttendeeAnswerQuestionNotification %zd",beAllowed);
}

- (void)onSinkPromptAttendee2PanelistResult:(MobileRTCWebinarPromoteorDepromoteError)errorCode
{
    NSLog(@"onSinkPromptAttendee2PanelistResult %zd",errorCode);
}

- (void)onSinkDePromptPanelist2AttendeeResult:(MobileRTCWebinarPromoteorDepromoteError)errorCode
{
    NSLog(@"onSinkDePromptPanelist2AttendeeResult %zd",errorCode);
}

#if 1
#pragma mark - Webinar Q&A
- (void)onSinkQAConnectStarted
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    NSLog(@"Webinar Q&A--onSinkQAConnectStarted QA Enable:%d...", [ms isQAEnabled]);
}

- (void)onSinkQAConnected:(BOOL)connected
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    NSLog(@"Webinar Q&A--onSinkQAConnected %d, QA Enable:%d...", connected, [ms isQAEnabled]);
}

- (void)onSinkQAOpenQuestionChanged:(NSInteger)count
{
    NSLog(@"Webinar Q&A--onSinkQAOpenQuestionChanged %zd...", count);
}

#endif

@end
