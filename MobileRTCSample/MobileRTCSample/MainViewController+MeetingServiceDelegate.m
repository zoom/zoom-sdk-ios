//
//  MainViewController+MeetingServiceDelegate.m
//  MobileRTCSample
//
//  Created by Robust on 2017/12/28.
//  Copyright © 2017年 Zoom Video Communications, Inc. All rights reserved.
//

#import "MainViewController+MeetingServiceDelegate.h"
#import "CustomMeetingViewController.h"
#import "CustomMeetingViewController+MeetingDelegate.h"

@implementation MainViewController (MeetingServiceDelegate)

- (void)onInitMeetingView
{
    NSLog(@"onInitMeetingView....");
    
    CustomMeetingViewController *vc = [[CustomMeetingViewController alloc] init];
    self.customMeetingVC = vc;
    [vc release];
    
    [self addChildViewController:self.customMeetingVC];
    [self.view addSubview:self.customMeetingVC.view];
    [self.customMeetingVC didMoveToParentViewController:self];
    
    self.customMeetingVC.view.frame = self.view.bounds;
}

- (void)onDestroyMeetingView
{
    NSLog(@"onDestroyMeetingView....");
    
    [self.customMeetingVC willMoveToParentViewController:nil];
    [self.customMeetingVC.view removeFromSuperview];
    [self.customMeetingVC removeFromParentViewController];
    self.customMeetingVC = nil;
}

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

- (void)onSinkMeetingAudioStatusChange:(NSUInteger)userID
{
    if (self.customMeetingVC)
    {
        [self.customMeetingVC onSinkMeetingAudioStatusChange:userID];
    }
}

- (void)onSinkMeetingVideoStatusChange:(NSUInteger)userID
{
    if (self.customMeetingVC)
    {
        [self.customMeetingVC onSinkMeetingVideoStatusChange:userID];
    }
}

- (void)onMyAudioStateChange
{
    if (self.customMeetingVC)
    {
        [self.customMeetingVC onSinkMeetingAudioStatusChange:0];
    }
}

- (void)onMyVideoStateChange
{
    if (self.customMeetingVC)
    {
        [self.customMeetingVC onMyVideoStateChange];
    }
}

- (void)onSinkMeetingUserJoin:(NSUInteger)userID
{
    if (self.customMeetingVC)
    {
        [self.customMeetingVC onSinkMeetingUserJoin:userID];
    }
}

- (void)onSinkMeetingUserLeft:(NSUInteger)userID
{
    if (self.customMeetingVC)
    {
        [self.customMeetingVC onSinkMeetingUserLeft:userID];
    }
}

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

- (void)onWaitingRoomStatusChange:(BOOL)needWaiting
{
    if (self.customMeetingVC)
    {
        [self.customMeetingVC onWaitingRoomStatusChange:needWaiting];
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

- (void)onSinkWebinarNeedRegister:(NSString *)registerURL
{
    NSLog(@"%@",registerURL);
}

- (void)onSinkJoinWebinarNeedUserNameAndEmailWithCompletion:(BOOL (^_Nonnull)(NSString * _Nonnull username, NSString * _Nonnull email, BOOL cancel))completion
{
    if (completion)
    {
        NSString * username = [NSString stringWithString:@"zoomtest"];
        NSString * email = [NSString stringWithString:@"zoomtest@zoom.us"];
        BOOL ret = completion(username,email,NO);
        NSLog(@"%zd",ret);
    }
}

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
@end
