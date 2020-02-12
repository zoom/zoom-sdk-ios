//
//  ControlBar.m
//
//  Created by Zoom Video Communications on 2019/5/27.
//  Copyright © 2019 Zoom. All rights reserved.
//

#import "ControlBar.h"
#import "TopBar.h"
#import "SDKAudioPresenter.h"
#import "SDKVideoPresenter.h"
#import "SDKActionPresenter.h"

#define kTagButtonSwitch        2000
#define kTagButtonAudio         (kTagButtonSwitch+1)
#define kTagButtonVideo         (kTagButtonSwitch+2)
#define kTagButtonShare         (kTagButtonSwitch+3)

@interface ControlBar ()
@property (strong, nonatomic) UIButton          *switchBtn;
@property (strong, nonatomic) UIButton          *audioBtn;
@property (strong, nonatomic) UIButton          *videoBtn;

@property (strong, nonatomic) SDKAudioPresenter           *audioPresenter;
@property (strong, nonatomic) SDKVideoPresenter           *videoPresenter;
@property (strong, nonatomic) SDKActionPresenter          *actionPresenter;
@end

@implementation ControlBar

- (id)init
{
    self = [super init];
    if (self) {
        [self initSubView];
    }
    return self;
}

- (void)dealloc {
    self.switchBtn = nil;
    self.audioBtn = nil;
    self.videoBtn = nil;
    
    self.audioPresenter = nil;
    self.videoPresenter = nil;
    self.actionPresenter = nil;
    [super dealloc];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    BOOL landscape = UIInterfaceOrientationIsLandscape(orientation);
    
    float button_width;
    if (landscape) {
        button_width = 45;
        if (IS_IPAD) {
            button_width = 60.0;
        }
    } else {
        button_width = 60;
    }
    
    _switchBtn.frame = CGRectMake(0, 0, button_width, button_width * ([UIImage imageNamed:@"icon_switch"].size.height/[UIImage imageNamed:@"icon_switch"].size.width));
    _audioBtn.frame = CGRectMake(0, CGRectGetMaxY(_switchBtn.frame), button_width, button_width * ([UIImage imageNamed:@"icon_mute"].size.height/[UIImage imageNamed:@"icon_mute"].size.width));
    _videoBtn.frame = CGRectMake(0, CGRectGetMaxY(_audioBtn.frame), button_width, button_width * ([UIImage imageNamed:@"icon_video_on"].size.height/[UIImage imageNamed:@"icon_video_on"].size.width));
    
    float controlBar_height = Height(_switchBtn)+Height(_audioBtn)+Height(_videoBtn);
    
    float controlBar_x = SCREEN_WIDTH-button_width - 5;
    float controlBar_y;
    if (landscape) {
        if (orientation == UIInterfaceOrientationLandscapeLeft && IPHONE_X) {
            controlBar_x = SCREEN_WIDTH-button_width-SAFE_ZOOM_INSETS;
        } else {
            controlBar_x = SCREEN_WIDTH-button_width - 12;
        }
        controlBar_y = Top_Height;
    } else {
        controlBar_y = (SCREEN_HEIGHT - controlBar_height)*2/5;
    }
    
    self.frame = CGRectMake(controlBar_x, controlBar_y, button_width, controlBar_height);
}

- (void)initSubView {
    _switchBtn = [[UIButton alloc] init];
    _switchBtn.tag = kTagButtonSwitch;
    [_switchBtn setImage:[UIImage imageNamed:@"icon_switch"] forState:UIControlStateNormal];
    [_switchBtn addTarget: self action: @selector(onBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_switchBtn];
    
    _audioBtn = [[UIButton alloc] init];
    _audioBtn.tag = kTagButtonAudio;
    [_audioBtn setImage:[UIImage imageNamed:@"icon_unmute"] forState:UIControlStateNormal];
    [_audioBtn setImage:[UIImage imageNamed:@"icon_mute"] forState:UIControlStateSelected];
    [_audioBtn addTarget: self action: @selector(onBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_audioBtn];
    
    _videoBtn = [[UIButton alloc] init];
    _videoBtn.tag = kTagButtonVideo;
    [_videoBtn setImage:[UIImage imageNamed:@"icon_video_off"] forState:UIControlStateNormal];
    [_videoBtn setImage:[UIImage imageNamed:@"icon_video_on"] forState:UIControlStateSelected];
    [_videoBtn addTarget: self action: @selector(onBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_videoBtn];
    
}


- (void)onBarButtonClicked:(UIButton *)sender
{
    switch (sender.tag) {
        case kTagButtonSwitch:
        {
            [self.videoPresenter switchMyCamera];
            break;
        }
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
       
        default:
            break;
    }
}

- (void)updateMyAudioStatus
{
    BOOL mute = [[[MobileRTC sharedRTC] getMeetingService] isMyAudioMuted];
    
    if ([[[MobileRTC sharedRTC] getMeetingService] myAudioType] != MobileRTCAudioType_None && !mute) {
        [_audioBtn setSelected:YES];
    } else {
        [_audioBtn setSelected:NO];
    }
}

- (void)updateMyVideoStatus
{
    BOOL mute = [[[MobileRTC sharedRTC] getMeetingService] isSendingMyVideo];
    
    if (!mute) {
        [_videoBtn setSelected:YES];
    } else {
        [_videoBtn setSelected:NO];
    }
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

- (SDKActionPresenter *)actionPresenter
{
    if (!_actionPresenter)
    {
        _actionPresenter = [[SDKActionPresenter alloc] init];
    }
    
    return _actionPresenter;
}


@end


