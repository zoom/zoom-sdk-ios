//
//  BottomPanelView.m
//  MobileRTCSample
//
//  Created by Murray Li on 2018/10/12.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import "BottomPanelView.h"
#import "SDKAudioPresenter.h"
#import "SDKVideoPresenter.h"
#import "SDKSharePresenter.h"
#import "SDKActionPresenter.h"
#import "QAListViewController.h"
#import "BOMeetingViewController.h"
#import "VBViewController.h"

@interface BottomPanelView ()
@property (strong, nonatomic)  CAGradientLayer      *gradientLayer;
@property (strong, nonatomic)  UIButton             *audioButton;
@property (strong, nonatomic)  UIButton             *videoButton;
@property (strong, nonatomic)  UIButton             *shareButton;
@property (strong, nonatomic)  UIButton             *chatButton;
@property (strong, nonatomic)  UIButton             *moreButton;

// Presenter
@property (strong, nonatomic) SDKAudioPresenter           *audioPresenter;
@property (strong, nonatomic) SDKVideoPresenter           *videoPresenter;
@property (strong, nonatomic) SDKSharePresenter           *sharePresenter;
@property (strong, nonatomic) SDKActionPresenter          *actionPresenter;
@end

@implementation BottomPanelView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.gradientLayer = [CAGradientLayer layer];
        self.gradientLayer.frame = self.bounds;
        [self.layer addSublayer:self.gradientLayer];
        self.gradientLayer.startPoint = CGPointMake(0.5, 1);
        self.gradientLayer.endPoint = CGPointMake(0.5, 0);
        self.gradientLayer.colors = @[(__bridge id)[UIColor colorWithWhite:0.f alpha:0.8].CGColor,
                                      (__bridge id)[UIColor colorWithWhite:0.f alpha:0.2].CGColor];
        
        [self addSubview:self.audioButton];
        [self addSubview:self.videoButton];
        [self addSubview:self.shareButton];
        [self addSubview:self.chatButton];
        [self addSubview:self.moreButton];
    }
    return self;
}

- (void)showBottomPanelView
{
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-Bottom_Height, [UIScreen mainScreen].bounds.size.width, Bottom_Height);
    } completion:^(BOOL finished) {
    }];
}

- (void)hiddenBottomPanelView
{
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, Bottom_Height);
    } completion:^(BOOL finished) {
    }];
}

- (void)updateFrame
{
    CGFloat panelWidth = [UIScreen mainScreen].bounds.size.width;
    
    self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-Bottom_Height, panelWidth, Bottom_Height);
    self.gradientLayer.frame = self.bounds;
    
    float bottomButtonHeight = IPHONE_X ? 60 : Bottom_Height;
    
    self.audioButton.frame = CGRectMake(0, 0, panelWidth/5, bottomButtonHeight);
    [self.audioButton setTitleEdgeInsets:UIEdgeInsetsMake(_audioButton.imageView.frame.size.height ,-self.audioButton.imageView.frame.size.width, 0.0,0.0)];
    [self.audioButton setImageEdgeInsets:UIEdgeInsetsMake(-self.audioButton.imageView.frame.size.height/2, 0.0,0.0, -self.audioButton.titleLabel.bounds.size.width)];
    
    self.videoButton.frame = CGRectMake(panelWidth/5, 0, panelWidth/5, bottomButtonHeight);
    [self.videoButton setTitleEdgeInsets:UIEdgeInsetsMake(self.videoButton.imageView.frame.size.height ,-self.videoButton.imageView.frame.size.width, 0.0,0.0)];
    [self.videoButton setImageEdgeInsets:UIEdgeInsetsMake(-self.videoButton.imageView.frame.size.height/2, 0.0,0.0, -self.videoButton.titleLabel.bounds.size.width)];
    
    self.shareButton.frame = CGRectMake(panelWidth*2/5, 0, panelWidth/5, bottomButtonHeight);
    [self.shareButton setTitleEdgeInsets:UIEdgeInsetsMake(self.shareButton.imageView.frame.size.height ,-self.shareButton.imageView.frame.size.width, 0.0,0.0)];
    [self.shareButton setImageEdgeInsets:UIEdgeInsetsMake(-self.shareButton.imageView.frame.size.height/2, 0.0,0.0, -self.shareButton.titleLabel.bounds.size.width)];
    
    self.chatButton.frame = CGRectMake(panelWidth*3/5, 0, panelWidth/5, bottomButtonHeight);
    [self.chatButton setTitleEdgeInsets:UIEdgeInsetsMake(self.chatButton.imageView.frame.size.height ,-self.chatButton.imageView.frame.size.width, 0.0,0.0)];
    [self.chatButton setImageEdgeInsets:UIEdgeInsetsMake(-self.chatButton.imageView.frame.size.height/2, 0.0,0.0, -self.chatButton.titleLabel.bounds.size.width)];
    
    self.moreButton.frame = CGRectMake(panelWidth*4/5, 0, panelWidth/5, bottomButtonHeight);
    [self.moreButton setTitleEdgeInsets:UIEdgeInsetsMake(self.moreButton.imageView.frame.size.height ,-self.moreButton.imageView.frame.size.width, 0.0,0.0)];
    [self.moreButton setImageEdgeInsets:UIEdgeInsetsMake(-self.moreButton.imageView.frame.size.height/2, 0.0,0.0, -self.moreButton.titleLabel.bounds.size.width)];
}


- (void)dealloc {
    self.gradientLayer = nil;
    self.audioButton = nil;
    self.videoButton = nil;
    self.shareButton = nil;
    self.chatButton = nil;
    self.moreButton = nil;
    
    self.audioPresenter = nil;
    self.videoPresenter = nil;
    self.sharePresenter = nil;
    self.actionPresenter = nil;
    [super dealloc];
}


- (UIButton*)audioButton
{
    if (!_audioButton)
    {
        _audioButton = [[UIButton alloc] init];
        [_audioButton setImage:[UIImage imageNamed:@"icon_meeting_audio"] forState:UIControlStateNormal];
        [_audioButton setTitle:@"Mute" forState:UIControlStateNormal];
        _audioButton.titleLabel.font = [UIFont systemFontOfSize:11.0];
        _audioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _audioButton.tag = kTagButtonAudio;
        [_audioButton addTarget: self action: @selector(onBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _audioButton;
}

- (UIButton*)videoButton
{
    if (!_videoButton)
    {
        _videoButton = [[UIButton alloc] init];
        [_videoButton setImage:[UIImage imageNamed:@"icon_meeting_video"] forState:UIControlStateNormal];
        [_videoButton setTitle:@"Stop Video" forState:UIControlStateNormal];
        _videoButton.titleLabel.font = [UIFont systemFontOfSize:11.0];
        _videoButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _videoButton.tag = kTagButtonVideo;
        [_videoButton addTarget: self action: @selector(onBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _videoButton;
}


- (UIButton*)shareButton
{
    if (!_shareButton)
    {
        _shareButton = [[UIButton alloc] init];
        [_shareButton setImage:[UIImage imageNamed:@"icon_meeting_share"] forState:UIControlStateNormal];
        [_shareButton setTitle:@"Start Share" forState:UIControlStateNormal];
        _shareButton.titleLabel.font = [UIFont systemFontOfSize:11.0];
        _shareButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _shareButton.tag = kTagButtonShare;
        [_shareButton addTarget: self action: @selector(onBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _shareButton;
}


- (UIButton*)chatButton
{
    if (!_chatButton)
    {
        _chatButton = [[UIButton alloc] init];
        [_chatButton setImage:[UIImage imageNamed:@"icon_meeting_attendee"] forState:UIControlStateNormal];
        [_chatButton setTitle:@"Participants" forState:UIControlStateNormal];
        _chatButton.titleLabel.font = [UIFont systemFontOfSize:11.0];
        _chatButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _chatButton.tag = kTagButtonChat;
        [_chatButton addTarget: self action: @selector(onBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _chatButton;
}

- (UIButton*)moreButton
{
    if (!_moreButton)
    {
        _moreButton = [[UIButton alloc] init];
        [_moreButton setImage:[UIImage imageNamed:@"icon_meeting_more"] forState:UIControlStateNormal];
        [_moreButton setTitle:@"More" forState:UIControlStateNormal];
        _moreButton.titleLabel.font = [UIFont systemFontOfSize:11.0];
        _moreButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _moreButton.tag = kTagButtonMore;
        [_moreButton addTarget: self action: @selector(onBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _moreButton;
}

- (SDKAudioPresenter *)audioPresenter
{
    if (!_audioPresenter)
    {
        _audioPresenter = [[SDKAudioPresenter alloc] init];
    }
    
    return _audioPresenter;
}

- (SDKVideoPresenter *)videoPresenter
{
    if (!_videoPresenter)
    {
        _videoPresenter = [[SDKVideoPresenter alloc] init];
    }
    
    return _videoPresenter;
}

- (SDKSharePresenter *)sharePresenter
{
    if (!_sharePresenter)
    {
        _sharePresenter = [[SDKSharePresenter alloc] init];
    }
    
    return _sharePresenter;
}

- (SDKActionPresenter *)actionPresenter
{
    if (!_actionPresenter)
    {
        _actionPresenter = [[SDKActionPresenter alloc] init];
    }
    
    return _actionPresenter;
}

- (void)onBarButtonClicked:(UIButton *)sender
{
    switch (sender.tag) {
        case kTagButtonAudio:
        {
            [self.audioPresenter muteMyAudio];
            break;
        }
        case kTagButtonVideo:
        {
            [self.videoPresenter muteMyVideo];
            break;
        }
        case kTagButtonShare:
        {
            [self.sharePresenter startOrStopAppShare];
            break;
        }
        case kTagButtonChat:
        {
            [self.actionPresenter presentParticipantsViewController];
            break;
        }
        case kTagButtonMore:
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                     message:nil
                                                                              preferredStyle:UIAlertControllerStyleActionSheet];
            if ([[[MobileRTC sharedRTC] getMeetingService] isQAEnabled]) {
                [alertController addAction:[UIAlertAction actionWithTitle:@"QA"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction *action) {
                                                                      AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

                                                                      QAListViewController *VC = [[QAListViewController alloc] init];
                                                                      UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:VC];
                                                                      nav.modalPresentationStyle = UIModalPresentationFullScreen;
                                                                      [[appDelegate topViewController] presentViewController:nav animated:YES completion:NULL];
                                                                  }]];
            }
            
            if ([[[MobileRTC sharedRTC] getMeetingService] isBOMeetingEnabled]) {
                [alertController addAction:[UIAlertAction actionWithTitle:@"BO Meeting"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction *action) {
                                                                      AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

                                                                      BOMeetingViewController *VC = [[BOMeetingViewController alloc] init];
                                                                      UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:VC];
                                                                      nav.modalPresentationStyle = UIModalPresentationFullScreen;
                                                                      [[appDelegate topViewController] presentViewController:nav animated:YES completion:NULL];
                                                                  }]];
            }
            
            if ([[[MobileRTC sharedRTC] getMeetingService] isSupportVirtualBG]) {
                [alertController addAction:[UIAlertAction actionWithTitle:@"Virtual Background"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction *action) {
                                                                      AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                                                                      
                                                                      VBViewController *VC = [[VBViewController alloc] init];
                                                                      UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:VC];
                                                                      nav.modalPresentationStyle = UIModalPresentationFullScreen;
                                                                      [[appDelegate topViewController] presentViewController:nav animated:YES completion:NULL];
                                                                  }]];
            }
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"Switch My Audio"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action) {
                                                                  [self.audioPresenter switchMyAudioSource];
                                                              }]];
            
            
            MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
            
            if (ms)
            {
                MobileRTCAudioType audioType = [self.audioPresenter myAudioType];
                if (audioType != MobileRTCAudioType_None)
                {
                    [alertController addAction:[UIAlertAction actionWithTitle:@"Disconnect Audio"
                                                                        style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction *action) {
                                                                        [self.audioPresenter connectMyAudio:NO];
                                                                      }]];
                }
                
                if (ms.isMeetingHost || ms.isMeetingCoHost) {
                    NSString *meetingLockTitle = ms.isMeetingLocked ? @"Unlock Meeting":@"Lock Meeting";
                    [alertController addAction:[UIAlertAction actionWithTitle:meetingLockTitle
                                                                        style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction *action) {
                                                                          [self.actionPresenter lockMeeting];
                                                                      }]];
                    NSString *meetingShareLocktitle = ms.isShareLocked ? @"Unlock Share":@"Lock Share";
                    [alertController addAction:[UIAlertAction actionWithTitle:meetingShareLocktitle
                                                                        style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction *action) {
                                                                          [self.actionPresenter lockShare];
                                                                      }]];
                }
                
                MobileRTCAnnotationService *as = [[MobileRTC sharedRTC] getAnnotationService];
                if ([as canDisableViewerAnnoataion]) {
                    if ([as isViewerAnnoataionDisabled]) {
                        [alertController addAction:[UIAlertAction actionWithTitle:@"Allow Viewer Annotation"
                                                                            style:UIAlertActionStyleDefault
                                                                          handler:^(UIAlertAction *action) {
                                                                              [as disableViewerAnnoataion:NO];
                                                                          }]];
                    } else {
                        [alertController addAction:[UIAlertAction actionWithTitle:@"Disable Viewer Annotation"
                                                                            style:UIAlertActionStyleDefault
                                                                          handler:^(UIAlertAction *action) {
                                                                              [as disableViewerAnnoataion:YES];
                                                                          }]];
                    }
                }
                MobileRTCWaitingRoomService *ws = [[MobileRTC sharedRTC] getWaitingRoomService];
                if ([ws isSupportWaitingRoom]) {
                    if ([ws isWaitingRoomOnEntryFlagOn]) {
                        [alertController addAction:[UIAlertAction actionWithTitle:@"Disable Waiting Room On Entry"
                                                                            style:UIAlertActionStyleDefault
                                                                          handler:^(UIAlertAction *action) {
                                                                              [ws enableWaitingRoomOnEntry:NO];
                                                                          }]];
                    } else {
                        [alertController addAction:[UIAlertAction actionWithTitle:@"Enable Waiting Room On Entry"
                                                                            style:UIAlertActionStyleDefault
                                                                          handler:^(UIAlertAction *action) {
                                                                              [ws enableWaitingRoomOnEntry:YES];
                                                                          }]];
                    }
                }
                
                if ([ms isMeetingHost] || [ms isMeetingCoHost]) {
                    [alertController addAction:[UIAlertAction actionWithTitle:@"Change Chat Priviledge"
                                                                        style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction *action) {
                                                                          [self changeChatPriviledge:sender];
                                                                      }]];
                }
                
            }
            
            [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            }]];
            
            UIPopoverPresentationController *popover = alertController.popoverPresentationController;
            if (popover)
            {
                UIButton *btn = (UIButton*)sender;
                popover.sourceView = btn;
                popover.sourceRect = btn.bounds;
                popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
            }
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [[appDelegate topViewController] presentViewController:alertController animated:YES completion:nil];
            break;
        }
        default:
            break;
    }
}

- (void)changeChatPriviledge:(UIButton *)sender
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    MobileRTCMeetingChatPriviledgeType priviledgeType  = [ms getAttendeeChatPriviledge];
    NSString *title = @"";
    switch (priviledgeType) {
        case MobileRTCMeetingChatPriviledge_No_One:
            title = [NSString stringWithFormat:@"Allow Participants to Chat with: %@", @"No one"];
            break;
        case MobileRTCMeetingChatPriviledge_Host_Only:
            title = [NSString stringWithFormat:@"Allow Participants to Chat with: %@", @"Host Only"];
            break;
        case MobileRTCMeetingChatPriviledge_Everyone_Publicly:
            title = [NSString stringWithFormat:@"Allow Participants to Chat with: %@", @"Everyone Publicly"];
            break;
        case MobileRTCMeetingChatPriviledge_Everyone_Publicly_And_Privately:
            title = [NSString stringWithFormat:@"Allow Participants to Chat with: %@", @"Everyone Publicly And Privately"];
            break;
        default:
            break;
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"No one"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          [ms changeAttendeeChatPriviledge:MobileRTCMeetingChatPriviledge_No_One];
                                                      }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Host Only"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          [ms changeAttendeeChatPriviledge:MobileRTCMeetingChatPriviledge_Host_Only];
                                                      }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Everyone Publicly"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          [ms changeAttendeeChatPriviledge:MobileRTCMeetingChatPriviledge_Everyone_Publicly];
                                                      }]];
    if (![ms isPrivateChatDisabled]) {
        [alertController addAction:[UIAlertAction actionWithTitle:@"Everyone Publicly And Privately"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              [ms changeAttendeeChatPriviledge:MobileRTCMeetingChatPriviledge_Everyone_Publicly_And_Privately];
                                                          }]];
    }
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }]];
    
    UIPopoverPresentationController *popover = alertController.popoverPresentationController;
    if (popover)
    {
        popover.sourceView = sender;
        popover.sourceRect = sender.bounds;
        popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
    }
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [[appDelegate topViewController] presentViewController:alertController animated:YES completion:nil];

}

- (void)updateMyAudioStatus
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if (!ms) return;
    
    MobileRTCAudioType audioType = [ms myAudioType];
    if (audioType == MobileRTCAudioType_None)
    {
        [self.audioButton setImage:[UIImage imageNamed:@"icon_meeting_noaudio"] forState:UIControlStateNormal];
        [self.audioButton setTitle:@"Join Audio" forState:UIControlStateNormal];
    }
    else
    {
        if([ms isMyAudioMuted])
        {
            [self.audioButton setImage:[UIImage imageNamed:@"icon_meeting_audio_mute"] forState:UIControlStateNormal];
            [self.audioButton setTitle:@"Unmute" forState:UIControlStateNormal];

        }
        else
        {
            if (audioType == MobileRTCAudioType_Telephony) {
                [self.audioButton setImage:[UIImage imageNamed:@"icon_meeting_audio_phone"] forState:UIControlStateNormal];
                [self.audioButton setTitle:@"Mute" forState:UIControlStateNormal];
            } else {
                [self.audioButton setImage:[UIImage imageNamed:@"icon_meeting_audio"] forState:UIControlStateNormal];
                [self.audioButton setTitle:@"Mute" forState:UIControlStateNormal];
            }

        }
    }
    [self.audioButton setTitleEdgeInsets:UIEdgeInsetsMake(self.audioButton.imageView.frame.size.height ,-self.audioButton.imageView.frame.size.width, 0.0,0.0)];
    [self.audioButton setImageEdgeInsets:UIEdgeInsetsMake(-self.audioButton.imageView.frame.size.height/2, 0.0,0.0, -self.audioButton.titleLabel.bounds.size.width)];
}

- (void)updateMyVideoStatus
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if (!ms) return;
    
    BOOL mute = [ms isSendingMyVideo];
    if(!mute)
    {
        [self.videoButton setImage:[UIImage imageNamed:@"icon_meeting_video_mute"] forState:UIControlStateNormal];
        [self.videoButton setTitle:@"Start Video" forState:UIControlStateNormal];
    }
    else
    {
        [self.videoButton setImage:[UIImage imageNamed:@"icon_meeting_video"] forState:UIControlStateNormal];
        [self.videoButton setTitle:@"Stop Video" forState:UIControlStateNormal];
    }
    [self.videoButton setTitleEdgeInsets:UIEdgeInsetsMake(self.videoButton.imageView.frame.size.height ,-self.videoButton.imageView.frame.size.width, 0.0,0.0)];
    [self.videoButton setImageEdgeInsets:UIEdgeInsetsMake(-self.videoButton.imageView.frame.size.height/2, 0.0,0.0, -self.videoButton.titleLabel.bounds.size.width)];
}

- (void)updateMyShareStatus
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if (!ms) return;
    if (ms.isStartingShare)
    {
        [self.shareButton setImage:[UIImage imageNamed:@"icon_meeting_stopshare"] forState:UIControlStateNormal];
        [self.shareButton setTitle:@"Stop Share" forState:UIControlStateNormal];
    } else {
        [self.shareButton setImage:[UIImage imageNamed:@"icon_meeting_share"] forState:UIControlStateNormal];
        [self.shareButton setTitle:@"Start Share" forState:UIControlStateNormal];
    }
    [self.shareButton setTitleEdgeInsets:UIEdgeInsetsMake(self.shareButton.imageView.frame.size.height ,-self.shareButton.imageView.frame.size.width, 0.0,0.0)];
    [self.shareButton setImageEdgeInsets:UIEdgeInsetsMake(-self.shareButton.imageView.frame.size.height/2, 0.0,0.0, -self.shareButton.titleLabel.bounds.size.width)];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
