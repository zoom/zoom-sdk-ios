//
//  MainViewController+MeetingDelegate.m
//  MobileRTCSample
//
//  Created by Murray Li on 2018/12/5.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import "MainViewController+MeetingDelegate.h"

@implementation MainViewController (MeetingDelegate)

- (void)onJoinMeetingInfo:(MobileRTCJoinMeetingInfo)info
               completion:(void (^)(NSString *displayName, NSString *password, BOOL cancel))completion
{
    if (completion)
        self.joinMeetingBlock = completion;

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Please input display name and password", @"") delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"") otherButtonTitles:NSLocalizedString(@"OK", @""), nil];

    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    alert.tag = 10022;
    [alert textFieldAtIndex:0].placeholder = @"#########";
    [alert textFieldAtIndex:0].keyboardType = UIKeyboardTypeDefault;

    [alert show];
    [alert release];
}

- (void)onMeetingStateChange:(MobileRTCMeetingState)state;
{
    NSLog(@"onMeetingStateChange:%d", state);
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];

    if (state == MobileRTCMeetingState_Idle) {
        [self.view insertSubview:self.webVC.view aboveSubview:self.splashVC.view];
        [self.view insertSubview:self.introVC.view aboveSubview:self.webVC.view];
        
        [self.view bringSubviewToFront:self.meetButton];
        [self.view bringSubviewToFront:self.joinButton];
        [self.view bringSubviewToFront:self.expandButton];
        [self.view bringSubviewToFront:self.shareButton];
        [self.view bringSubviewToFront:self.settingButton];
    }
    
    BOOL inAppShare = [ms isDirectAppShareMeeting] && (state == MobileRTCMeetingState_InMeeting);
    self.expandButton.hidden = !inAppShare;
    self.shareButton.hidden = !inAppShare;
    self.meetButton.hidden = inAppShare;
    self.joinButton.hidden = inAppShare;
    
    if (state != MobileRTCMeetingState_InMeeting)
    {
        self.isSharingWebView = NO;
    }
    
#if 1
    if (state == MobileRTCMeetingState_InMeeting)
    {
        //For customizing the content of Invite by SMS
        NSString *meetingNumber = [[MobileRTCInviteHelper sharedInstance] ongoingMeetingNumber];
        NSString *smsMessage = [NSString stringWithFormat:NSLocalizedString(@"Please join meeting with ID: %@", @""), meetingNumber];
        [[MobileRTCInviteHelper sharedInstance] setInviteSMS:smsMessage];
        
        //For customizing the content of Copy URL
        NSString *joinURL = [[MobileRTCInviteHelper sharedInstance] joinMeetingURL];
        NSString *copyURLMsg = [NSString stringWithFormat:NSLocalizedString(@"Meeting URL: %@", @""), joinURL];
        [[MobileRTCInviteHelper sharedInstance] setInviteCopyURL:copyURLMsg];
    }
    
    else if(state == MobileRTCMeetingState_WebinarPromote)
    {
        NSLog(@"onMeetingStateChange MobileRTCMeetingState_WebinarPromote");
    }
    
    else if(state == MobileRTCMeetingState_WebinarDePromote)
    {
        NSLog(@"onMeetingStateChange MobileRTCMeetingState_WebinarDePromote");
    }
#endif
    
#if 0
    //For adding customize view above the meeting view
    if (state == MobileRTCMeetingState_InMeeting)
    {
        MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
        UIView *v = [ms meetingView];
        
        CGFloat offsetY = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 220 : 180;
        UIView *sv = [[UIView alloc] initWithFrame:CGRectMake(0, offsetY, v.frame.size.width, 50)];
        sv.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin;
        sv.backgroundColor = [UIColor redColor];
        [v addSubview:sv];
        [sv release];
    }
    
#endif
}

- (void)onMeetingReady
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if ([ms isDirectAppShareMeeting])
    {
        if ([ms isStartingShare] || [ms isViewingShare])
        {
            NSLog(@"There exist an ongoing share");
            [ms showMobileRTCMeeting:^(void){
                [ms stopAppShare];
            }];
            return;
        }
        
        BOOL ret = [ms startAppShare];
        NSLog(@"Start App Share... ret:%a", @(ret));
    }
    
    //    [self startClockTimer];
}

- (void)onAppShareSplash
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if (ms)
    {
        [ms appShareWithView:self.splashVC.view];
        [self.shareButton setImage:[UIImage imageNamed:@"icon_resume"] forState:UIControlStateNormal];
        self.isSharingWebView = NO;
    }
}

- (BOOL)onClickedShareButton:(UIViewController*)parentVC addShareActionItem:(NSMutableArray *)array
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if (ms && [ms isDirectAppShareMeeting])
    {
//        if ([ms isStartingShare] || [ms isViewingShare])
//        {
//            NSLog(@"There exist an ongoing share");
//            return YES;
//        }
//
//        [ms hideMobileRTCMeeting:^(void){
//            [ms startAppShare];
//        }];
        
        [ms hideMobileRTCMeeting:^(void){
            if (![ms isStartingShare] && ![ms isViewingShare]) {
                [ms startAppShare];
            }
        }];
        
        return YES;
    }
    
    return NO;
    
#if 0
    //Sample For Add custom share action item
    MobileRTCMeetingShareActionItem * item = [[MobileRTCMeetingShareActionItem itemWithTitle:@"Demo share" Tag:1] autorelease];
    
    item.delegate = self;
    
    [array addObject:item];
    
    return NO;
#endif
}

//Sample for add customized share item
- (void)onShareItemClicked:(NSUInteger)tag completion:(BOOL (^)(UIViewController* shareView))completion
{
    SplashViewController *splashctrl = [[SplashViewController new] autorelease];
    
    if (completion && splashctrl)
    {
        BOOL ret = completion(splashctrl);
        NSLog(@"%@",@(ret));
    }
}

- (void)onJBHWaitingWithCmd:(JBHCmd)cmd
{
    switch (cmd) {
        case JBHCmd_Show:
        {
            UIViewController *vc = [UIViewController new];
            
            NSString *meetingNumber = [MobileRTCInviteHelper sharedInstance].ongoingMeetingNumber;
            vc.title = meetingNumber;
            
            UIBarButtonItem *leaveItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Leave", @"") style:UIBarButtonItemStylePlain target:self action:@selector(onLeave:)];
            [vc.navigationItem setRightBarButtonItem:leaveItem];
            
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            nav.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:nav animated:YES completion:NULL];
        }
            break;
            
        case JBHCmd_Hide:
        default:
        {
            [self dismissViewControllerAnimated:YES completion:NULL];
        }
            break;
    }
}

- (BOOL)onClickedInviteButton:(UIViewController*)parentVC addInviteActionItem:(NSMutableArray *)inListArray
{
    //Sample For Add custom invite action item
    MobileRTCMeetingInviteActionItem * item = [[MobileRTCMeetingInviteActionItem itemWithTitle:@"test" Action:^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"add invite item test", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"Cancel", @"") otherButtonTitles:NSLocalizedString(@"OK", @""), nil];
        [alert show];
        [alert release];
    }] autorelease];

    [inListArray addObject:item];
    return NO;

    //Sample For show user customized InviteViewController
//    InviteViewController *inviteVC = [[InviteViewController alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:inviteVC];
//    nav.modalPresentationStyle = UIModalPresentationFormSheet;
//
//    [parentVC presentViewController:nav animated:YES completion:NULL];
//    return YES;
}

- (BOOL)onClickedParticipantsButton:(UIViewController*)parentVC
{
    InviteViewController *inviteVC = [[InviteViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:inviteVC];
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [parentVC presentViewController:nav animated:YES completion:NULL];
    
    return YES;
}

- (BOOL)onClickedEndButton:(UIViewController*)parentVC endButton:(UIButton *)endButton
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    
    

    
    
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    
    if (ms) {
        [alertController addAction:[UIAlertAction actionWithTitle:@"Leave Meeting"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              [ms leaveMeetingWithCmd:LeaveMeetingCmd_Leave];
                                                          }]];
        if ([ms isMeetingHost]) {
            [alertController addAction:[UIAlertAction actionWithTitle:@"End Meeting"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action) {
                                                                  [ms leaveMeetingWithCmd:LeaveMeetingCmd_End];
                                                              }]];
        }
    }
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }]];
    
    UIPopoverPresentationController *popover = alertController.popoverPresentationController;
    if (popover)
    {
        popover.sourceView = endButton;
        popover.sourceRect = endButton.bounds;
        popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
    }
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [[appDelegate topViewController] presentViewController:alertController animated:YES completion:nil];
    
    return YES;
}

- (void)onClickedDialOut:(UIViewController*)parentVC isCallMe:(BOOL)me
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if (!ms)
        return;
    
    if ([ms isDialOutInProgress])
    {
        NSLog(@"There already exists an ongoing call");
        return;
    }
    
    NSString *callName = me ? nil : @"Dialer";
    BOOL ret = [ms dialOut:@"+866004" isCallMe:me withName:callName];
    NSLog(@"Dial out result: %@", @(ret));
}

#pragma mark - Handle Session Key
- (void)onWaitExternalSessionKey:(NSData*)key
{
    NSLog(@"session key: %@", key);
    Byte byte[] = {0x90,0xd7,0x19,0x28,0x7c,0xa5,0x4c,0xfd,0xca,0x89,0x5a,0x31,0x3f,0xf1,0xbc,0x8f,0x9b,0x6c,0x6b,0x4b,0x3e,0xcd,0xfc,0xa8,0xdf,0xda,0x0e,0xe7,0x00,0x4f,0x32,0xc5};
    NSData *keyData = [[NSData alloc] initWithBytes:byte length:32];
    NSLog(@"data: %@", keyData);
    
    MobileRTCE2EMeetingKey *mkChat = [[[MobileRTCE2EMeetingKey alloc] init] autorelease];
    mkChat.type = MobileRTCComponentType_Chat;
    mkChat.meetingKey = keyData;
    mkChat.meetingIv = nil;
    MobileRTCE2EMeetingKey *mkAudio = [[[MobileRTCE2EMeetingKey alloc] init] autorelease];
    mkAudio.type = MobileRTCComponentType_AUDIO;
    mkAudio.meetingKey = keyData;
    mkAudio.meetingIv = nil;
    MobileRTCE2EMeetingKey *mkVideo = [[[MobileRTCE2EMeetingKey alloc] init] autorelease];
    mkVideo.type = MobileRTCComponentType_VIDEO;
    mkVideo.meetingKey = keyData;
    mkVideo.meetingIv = nil;
    MobileRTCE2EMeetingKey *mkShare = [[[MobileRTCE2EMeetingKey alloc] init] autorelease];
    mkShare.type = MobileRTCComponentType_AS;
    mkShare.meetingKey = keyData;
    mkShare.meetingIv = nil;
    MobileRTCE2EMeetingKey *mkFile = [[[MobileRTCE2EMeetingKey alloc] init] autorelease];
    mkFile.type = MobileRTCComponentType_FT;
    mkFile.meetingKey = keyData;
    mkFile.meetingIv = nil;
    
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    BOOL ret = [ms handleE2EMeetingKey:@[mkChat, mkAudio, mkVideo, mkShare, mkFile] withLeaveMeeting:NO];
    NSLog(@"handleE2EMeetingKey ret:%@", @(ret));
}


@end
