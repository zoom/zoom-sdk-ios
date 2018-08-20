//
//  CustomMeetingViewController+MeetingDelegate.h
//  MobileRTCSample
//
//  Created by Robust on 2017/12/28.
//  Copyright © 2017年 Zoom Video Communications, Inc. All rights reserved.
//

#import "CustomMeetingViewController.h"

@interface CustomMeetingViewController (MeetingDelegate) 

- (void)onSinkMeetingActiveVideo:(NSUInteger)userID;

- (void)onSinkMeetingAudioStatusChange:(NSUInteger)userID;

- (void)onSinkMeetingVideoStatusChange:(NSUInteger)userID;

- (void)onMyVideoStateChange;

- (void)onSinkMeetingUserJoin:(NSUInteger)userID;

- (void)onSinkMeetingUserLeft:(NSUInteger)userID;

- (void)onSinkMeetingActiveShare:(NSUInteger)userID;

- (void)onSinkShareSizeChange:(NSUInteger)userID;

- (void)onSinkMeetingShareReceiving:(NSUInteger)userID;

- (void)onWaitingRoomStatusChange:(BOOL)needWaiting;

- (void)onSinkMeetingPreviewStopped;
@end
