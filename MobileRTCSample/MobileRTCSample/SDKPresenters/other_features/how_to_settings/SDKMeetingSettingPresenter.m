//
//  SDKMeetingSettingPresenter.m
//  MobileRTCSample
//
//  Created by Murray Li on 2018/11/27.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import "SDKMeetingSettingPresenter.h"

@implementation SDKMeetingSettingPresenter

- (void)setAutoConnectInternetAudio:(BOOL)connected
{
    [[[MobileRTC sharedRTC] getMeetingSettings] setAutoConnectInternetAudio:connected];
}

- (void)setMuteAudioWhenJoinMeeting:(BOOL)muted
{
    [[[MobileRTC sharedRTC] getMeetingSettings] setMuteAudioWhenJoinMeeting:muted];
}

- (void)setMuteVideoWhenJoinMeeting:(BOOL)muted
{
    [[[MobileRTC sharedRTC] getMeetingSettings] setMuteVideoWhenJoinMeeting:muted];
}

- (void)disableDriveMode:(BOOL)disabled
{
    [[[MobileRTC sharedRTC] getMeetingSettings] disableDriveMode:disabled];
}

- (void)disableGalleryView:(BOOL)disabled
{
    [[[MobileRTC sharedRTC] getMeetingSettings] disableGalleryView:disabled];
}

- (void)disableCallIn:(BOOL)disabled
{
    [[[MobileRTC sharedRTC] getMeetingSettings] disableCallIn:disabled];
}

- (void)disableCallOut:(BOOL)disabled
{
    [[[MobileRTC sharedRTC] getMeetingSettings] disableCallOut:disabled];
}

- (void)disableMinimizeMeeting:(BOOL)disabled
{
    [[[MobileRTC sharedRTC] getMeetingSettings] disableMinimizeMeeting:disabled];
}

- (void)faceBeautyEnable:(BOOL)enable
{
    [[[MobileRTC sharedRTC] getMeetingSettings] setFaceBeautyEnabled:enable];
}

- (void)setMeetingTitleHidden:(BOOL)hidden
{
    [[MobileRTC sharedRTC] getMeetingSettings].meetingTitleHidden = hidden;
}

- (void)setMeetingPasswordHidden:(BOOL)hidden
{
    [[MobileRTC sharedRTC] getMeetingSettings].meetingPasswordHidden = hidden;
}

- (void)setMeetingLeaveHidden:(BOOL)hidden
{
    [[MobileRTC sharedRTC] getMeetingSettings].meetingLeaveHidden = hidden;
}

- (void)setMeetingAudioHidden:(BOOL)hidden
{
    [[MobileRTC sharedRTC] getMeetingSettings].meetingAudioHidden = hidden;
}

- (void)setMeetingVideoHidden:(BOOL)hidden
{
    [[MobileRTC sharedRTC] getMeetingSettings].meetingVideoHidden = hidden;
}

- (void)setMeetingInviteHidden:(BOOL)hidden
{
    [[MobileRTC sharedRTC] getMeetingSettings].meetingInviteHidden = hidden;
}

- (void)setMeetingChatHidden:(BOOL)hidden
{
    [[MobileRTC sharedRTC] getMeetingSettings].meetingChatHidden = hidden;
}

- (void)setMeetingParticipantHidden:(BOOL)hidden
{
    [[MobileRTC sharedRTC] getMeetingSettings].meetingParticipantHidden = hidden;
}

- (void)setMeetingShareHidden:(BOOL)hidden
{
    [[MobileRTC sharedRTC] getMeetingSettings].meetingShareHidden = hidden;
}

- (void)setMeetingMoreHidden:(BOOL)hidden
{
    [[MobileRTC sharedRTC] getMeetingSettings].meetingMoreHidden = hidden;
}

- (void)setTopBarHidden:(BOOL)hidden
{
    [[MobileRTC sharedRTC] getMeetingSettings].topBarHidden = hidden;
}

- (void)setBottomBarHidden:(BOOL)hidden
{
    [[MobileRTC sharedRTC] getMeetingSettings].bottomBarHidden = hidden;
}

- (void)setEnableKubi:(BOOL)enabled
{
    [[MobileRTC sharedRTC] getMeetingSettings].enableKubi = enabled;
}

- (void)setThumbnailInShare:(BOOL)changed
{
    [[MobileRTC sharedRTC] getMeetingSettings].thumbnailInShare = changed;
}

- (void)setHostLeaveHidden:(BOOL)hidden
{
    [[MobileRTC sharedRTC] getMeetingSettings].hostLeaveHidden = hidden;
}

- (void)setHintHidden:(BOOL)hidden
{
    [[MobileRTC sharedRTC] getMeetingSettings].hintHidden = hidden;
}

- (void)setWaitingHUDHidden:(BOOL)hidden
{
    [[MobileRTC sharedRTC] getMeetingSettings].waitingHUDHidden = hidden;
}

- (void)setEnableCustomMeeting:(BOOL)enableCustomMeeting
{
    [[MobileRTC sharedRTC] getMeetingSettings].enableCustomMeeting = enableCustomMeeting;
}

- (void)enableShowMyMeetingElapseTime:(BOOL)enable;
{
    [[[MobileRTC sharedRTC] getMeetingSettings] enableShowMyMeetingElapseTime:enable];
}


@end
