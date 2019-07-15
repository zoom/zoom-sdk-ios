//
//  MainViewController+MeetingDelegate.h
//  MobileRTCSample
//
//  Created by Murray Li on 2018/12/5.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController (MeetingDelegate)

- (void)onJoinMeetingInfo:(MobileRTCJoinMeetingInfo)info
               completion:(void (^)(NSString *displayName, NSString *password, BOOL cancel))completion;

- (void)onMeetingStateChange:(MobileRTCMeetingState)state;

- (void)onMeetingReady;

- (void)onAppShareSplash;

- (BOOL)onClickedShareButton:(UIViewController*)parentVC addShareActionItem:(NSMutableArray *)array;

- (void)onJBHWaitingWithCmd:(JBHCmd)cmd;

- (BOOL)onClickedInviteButton:(UIViewController*)parentVC addInviteActionItem:(NSMutableArray *)inListArray;

- (BOOL)onClickedParticipantsButton:(UIViewController*)parentVC;

- (BOOL)onClickedEndButton:(UIViewController*)parentVC endButton:(UIButton *)endButton;

- (void)onClickedDialOut:(UIViewController*)parentVC isCallMe:(BOOL)me;

- (void)onWaitExternalSessionKey:(NSData*)key;
@end
