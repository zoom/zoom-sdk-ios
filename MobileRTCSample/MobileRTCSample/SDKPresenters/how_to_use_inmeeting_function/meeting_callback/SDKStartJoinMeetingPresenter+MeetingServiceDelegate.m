//
//  SDKStartJoinMeetingPresenter+MeetingServiceDelegate.m
//  MobileRTCSample
//
//  Created by Murray Li on 2018/11/21.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import "SDKStartJoinMeetingPresenter+MeetingServiceDelegate.h"
#import "CustomMeetingViewController+MeetingDelegate.h"
#import "MainViewController+MeetingDelegate.h"

@implementation SDKStartJoinMeetingPresenter (MeetingServiceDelegate)

#pragma mark - Meeting Service Delegate

- (void)onJoinMeetingConfirmed
{
    NSString *meetingNo = [[MobileRTCInviteHelper sharedInstance] ongoingMeetingNumber];
    NSLog(@"onJoinMeetingConfirmed MeetingNo: %@", meetingNo);
}

- (void)onJoinMeetingInfo:(MobileRTCJoinMeetingInfo)info
               completion:(void (^)(NSString *displayName, NSString *password, BOOL cancel))completion
{
    if (self.mainVC) {
        [self.mainVC onJoinMeetingInfo:info completion:(void (^)(NSString *displayName, NSString *password, BOOL cancel))completion];
    }
}

#pragma mark -- For CustomUI Meeting
- (void)onWaitingRoomStatusChange:(BOOL)needWaiting
{
    if (self.customMeetingVC)
    {
        [self.customMeetingVC onWaitingRoomStatusChange:needWaiting];
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

- (void)onMeetingError:(MobileRTCMeetError)error message:(NSString*)message
{
    NSLog(@"onMeetingError:%zd, message:%@", error, message);
}

- (void)onMeetingStateChange:(MobileRTCMeetingState)state
{
    if (self.mainVC) {
        [self.mainVC onMeetingStateChange:state];
    }
}

- (void)onMeetingReady
{
    if (self.mainVC) {
        [self.mainVC onMeetingReady];
    }
}

- (BOOL)onClickedShareButton:(UIViewController*)parentVC addShareActionItem:(NSMutableArray *)array
{
    return [self.mainVC onClickedShareButton:parentVC addShareActionItem:array];
}

- (void)onOngoingShareStopped
{
    NSLog(@"There does not exist ongoing share");
    //    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    //    if (ms)
    //    {
    //        [ms startAppShare];
    //    }
}

- (BOOL)onClickedAudioButton:(UIViewController*)parentVC {
    
    return NO; // will show the default SDK UI
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if (!ms) {
        return NO;
    }
    
    MobileRTCAudioType audioType = [ms myAudioType];
    switch (audioType)
    {
        case MobileRTCAudioType_VoIP: //voip
        case MobileRTCAudioType_Telephony: //phone
        {
            if (![ms canUnmuteMyAudio])
            {
                break;
            }
            BOOL isMuted = [ms isMyAudioMuted];
            [ms muteMyAudio:!isMuted];
            break;
        }
        case MobileRTCAudioType_None:
        {
            //Supported VOIP
            if ([ms isSupportedVOIP])
            {
                if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8"))
                {
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"To hear others\n please join audio", @"")
                                                                                             message:nil
                                                                                      preferredStyle:UIAlertControllerStyleAlert];
                    
                    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Call via Internet", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        //Join VOIP
                        MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
                        if (ms)
                        {
                            [ms connectMyAudio:YES];
                        }
                    }]];
                    
                    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                    }]];
                    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                    [[appDelegate topViewController] presentViewController:alertController animated:YES completion:nil];
                }
            }
            break;
        }
    }
    
    return YES;
}

- (void)onSinkMeetingShowMinimizeMeetingOrBackZoomUI:(MobileRTCMinimizeMeetingState)state
{
    NSLog(@"onSinkMeetingShowMinimizeMeetingOrBackZoomUI %@",@(state));
}

- (void)onSinkAttendeeChatPriviledgeChanged:(MobileRTCMeetingChatPriviledgeType)currentPrivilege
{
    NSLog(@"onSinkAttendeeChatPriviledgeChanged %@",@(currentPrivilege));
}

#if 0
- (void)onMeetingEndedReason:(MobileRTCMeetingEndReason)reason
{
    NSLog(@"onMeetingEndedReason %d", reason);
}
#endif

#if 0
- (void)onMicrophoneStatusError:(MobileRTCMicrophoneError)error
{
    NSLog(@"onMicrophoneStatusError %d", error);
}
#endif

#if 0
- (void)onJBHWaitingWithCmd:(JBHCmd)cmd
{
    if (self.mainVC) {
        [self.mainVC onJBHWaitingWithCmd:cmd];
    }
}
#endif

#if 0
- (BOOL)onClickedInviteButton:(UIViewController*)parentVC addInviteActionItem:(NSMutableArray *)array
{
    return [self.mainVC onClickedInviteButton:parentVC addInviteActionItem:array];
}
#endif

#if 0
- (BOOL)onClickedParticipantsButton:(UIViewController*)parentVC;
{
    return [self.mainVC onClickedParticipantsButton:parentVC];
}
#endif

#if 0
- (BOOL)onClickedEndButton:(UIViewController*)parentVC endButton:(UIButton *)endButton
{
    return [self.mainVC onClickedEndButton:parentVC endButton:endButton];
}
#endif

#if 0
- (void)onClickedDialOut:(UIViewController*)parentVC isCallMe:(BOOL)me
{
    if (self.mainVC) {
        [self.mainVC onClickedDialOut:parentVC isCallMe:me];
    }
}

- (void)onDialOutStatusChanged:(DialOutStatus)status
{
    NSLog(@"onDialOutStatusChanged: %zd", status);
}
#endif

#pragma mark - Handle Session Key
#if 0
- (void)onWaitExternalSessionKey:(NSData*)key
{
    if (self.mainVC) {
        [self.mainVC onWaitExternalSessionKey:key];
    }
}
#endif

#pragma mark - H.323/SIP call state changed
#if 0
- (void)onSendPairingCodeStateChanged:(MobileRTCH323ParingStatus)state MeetingNumber:(unsigned long long)meetingNumber
{
    NSLog(@"onSendPairingCodeStateChanged %zd", state);
}

- (void)onCallRoomDeviceStateChanged:(H323CallOutStatus)state
{
    NSLog(@"onCallRoomDeviceStateChanged %zd", state);
}
#endif

#pragma mark - ZAK expired
#if 0
- (void)onZoomIdentityExpired
{
    NSLog(@"onZoomIdentityExpired");
}

#pragma mark - Closed Caption
- (void)onClosedCaptionReceived:(NSString *)message
{
    NSLog(@"onClosedCaptionReceived : %@",message);
}
#endif

@end
