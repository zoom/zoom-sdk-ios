//
//  CustomMeetingViewController+MeetingDelegate.m
//  MobileRTCSample
//
//  Created by Robust on 2017/12/28.
//  Copyright © 2017年 Zoom Video Communications, Inc. All rights reserved.
//

#import "CustomMeetingViewController+MeetingDelegate.h"

@implementation CustomMeetingViewController (MeetingDelegate)

- (void)onSinkMeetingActiveVideo:(NSUInteger)userID
{
    self.galleryVC.activeVideoID = userID;
    self.shrinkVC.activeVideoID = userID;
    [self updateVideoOrShare];
}

- (void)onSinkMeetingPreviewStopped
{
    if (self.galleryVC.parentViewController)
    {
        [self.galleryVC removePreviewVideoView];
    }
}

- (void)onSinkMeetingAudioStatusChange:(NSUInteger)userID
{
    [self updateMyAudioStatus];
    
    [self updateVideoOrShare];
}

- (void)onSinkMeetingVideoStatusChange:(NSUInteger)userID
{
    [self updateMyVideoStatus];
    
    [self updateVideoOrShare];
}

- (void)onMyVideoStateChange
{
    [self updateMyVideoStatus];
    
    [self updateVideoOrShare];
}

- (void)onSinkMeetingUserJoin:(NSUInteger)userID
{
    [self updateVideoOrShare];
}

- (void)onSinkMeetingUserLeft:(NSUInteger)userID
{
    [self updateVideoOrShare];
}

- (void)onSinkMeetingActiveShare:(NSUInteger)userID
{
    BOOL sharing = (0 != userID);
    if (sharing)
    {
        self.shrinkBtn.hidden = YES;
        MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
        //Local Side Share
        if ([ms isSameUser:[ms myselfUserID] compareTo:userID])
        {
            [self showLocalShareView];
        }
        //Remote Side Share
        else
        {
            self.remoteShareVC.activeShareID = userID;
            [self showRemoteShareView];
        }
    }
    else
    {
        self.shrinkBtn.hidden = NO;
        [self initGuestureRecognizer];
        [self.annoFloatBarView stopAnnotate];
        [self showGalleryView];
    }
}

- (void)onSinkShareSizeChange:(NSUInteger)userID
{
    if (!self.remoteShareVC.parentViewController)
        return;

    [self.remoteShareVC.shareView changeShareScaleWithUserID:userID];
}

- (void)onSinkMeetingShareReceiving:(NSUInteger)userID
{
    if (!self.remoteShareVC.parentViewController)
        return;
    
    [self.remoteShareVC.shareView changeShareScaleWithUserID:userID];
}

- (void)onWaitingRoomStatusChange:(BOOL)needWaiting
{
    if (needWaiting)
    {
        UIViewController *vc = [UIViewController new];
        
        vc.title = @"Need wait for host Approve";
        
        UIBarButtonItem *leaveItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Leave", @"") style:UIBarButtonItemStylePlain target:self action:@selector(onEndButtonClick:)];
        [vc.navigationItem setRightBarButtonItem:leaveItem];
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:nav animated:YES completion:NULL];
        
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}
@end
