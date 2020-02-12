//
//  TopPanelView.m
//  MobileRTCSample
//
//  Created by Murray Li on 2018/10/12.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import "TopPanelView.h"
#import "SDKActionPresenter.h"
#import "SDKVideoPresenter.h"

const CGFloat TOP_BTN_LEN = 40;

@interface TopPanelView ()
@property (strong, nonatomic) CAGradientLayer *gradientLayer;
@property (strong, nonatomic) UIButton        *cameraSwitchBtn;
@property (strong, nonatomic) UILabel         *titleLabel;
@property (strong, nonatomic) UIButton        *leaveBtn;

@property (strong, nonatomic) SDKActionPresenter     *actionPresenter;
@property (strong, nonatomic) SDKVideoPresenter      *videoPresenter;
@end

@implementation TopPanelView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.gradientLayer = [CAGradientLayer layer];
        self.gradientLayer.frame = self.bounds;
        [self.layer addSublayer:self.gradientLayer];
        self.gradientLayer.startPoint = CGPointMake(0.5, 0);
        self.gradientLayer.endPoint = CGPointMake(0.5, 1);
        self.gradientLayer.colors = @[(__bridge id)[UIColor colorWithWhite:0.f alpha:0.6].CGColor,
                                 (__bridge id)[UIColor colorWithWhite:0.f alpha:0.0].CGColor];

        [self addSubview:self.shrinkBtn];
        [self addSubview:self.cameraSwitchBtn];
        [self addSubview:self.titleLabel];
        [self addSubview:self.leaveBtn];
        
  
        self.titleLabel.text = [[MobileRTCInviteHelper sharedInstance] ongoingMeetingNumber];
    }
    return self;
}

- (void)showTopPanelView {
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, Top_Height);
    } completion:^(BOOL finished) {
    }];
}

- (void)hiddenTopPanelView {
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, -Top_Height, [UIScreen mainScreen].bounds.size.width, Top_Height);
    } completion:^(BOOL finished) {
    }];
}

- (void)updateFrame
{
    CGFloat panelWidth = [UIScreen mainScreen].bounds.size.width;
    self.frame = CGRectMake(0, 0, panelWidth, Top_Height);
    self.gradientLayer.frame = self.bounds;
    
    CGFloat topGap = 30;
    self.shrinkBtn.frame = CGRectMake(10, topGap, TOP_BTN_LEN, TOP_BTN_LEN);
    self.cameraSwitchBtn.frame = CGRectMake(CGRectGetMaxX(self.shrinkBtn.frame)+10, topGap, TOP_BTN_LEN, TOP_BTN_LEN);
    self.leaveBtn.frame = CGRectMake(self.frame.size.width-70, topGap, 60, TOP_BTN_LEN);
    self.titleLabel.frame = CGRectMake((self.frame.size.width-120)/2, topGap, 120, TOP_BTN_LEN);
}

- (void)dealloc {
    self.gradientLayer = nil;
    self.shrinkBtn = nil;
    self.cameraSwitchBtn = nil;
    self.titleLabel = nil;
    self.leaveBtn = nil;
    
    self.actionPresenter = nil;
    self.videoPresenter = nil;
    [super dealloc];
}


- (UIButton*)shrinkBtn
{
    if (!_shrinkBtn)
    {
        _shrinkBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 40, TOP_BTN_LEN, TOP_BTN_LEN)];
        [_shrinkBtn setImage:[UIImage imageNamed:@"icon_shrink"] forState:UIControlStateNormal];
        _shrinkBtn.tag = kTagButtonShrink;
        [_shrinkBtn addTarget:self action:@selector(onTopButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _shrinkBtn;
}

- (UIButton*)cameraSwitchBtn
{
    if (!_cameraSwitchBtn)
    {
        _cameraSwitchBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_shrinkBtn.frame), 40, TOP_BTN_LEN, TOP_BTN_LEN)];
        [_cameraSwitchBtn setImage:[UIImage imageNamed:@"icon_switchcam"] forState:UIControlStateNormal];
        _cameraSwitchBtn.tag = kTagButtonCameraSwitch;
        [_cameraSwitchBtn addTarget:self action:@selector(onTopButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _cameraSwitchBtn;
}


- (UILabel*)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
        _titleLabel.text = @"";
    }
    return _titleLabel;
}

- (UIButton*)leaveBtn
{
    if (!_leaveBtn)
    {
        _leaveBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 40, 60, TOP_BTN_LEN)];
        [_leaveBtn setTitle:@"Leave" forState:UIControlStateNormal];
        _leaveBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_leaveBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _leaveBtn.tag = kTagButtonEnd;
        [_leaveBtn addTarget:self action:@selector(onTopButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leaveBtn;
}

- (SDKActionPresenter *)actionPresenter
{
    if (!_actionPresenter)
    {
        _actionPresenter = [[SDKActionPresenter alloc] init];
    }
    
    return _actionPresenter;
}

- (SDKVideoPresenter *)videoPresenter
{
    if (!_videoPresenter)
    {
        _videoPresenter = [[SDKVideoPresenter alloc] init];
    }
    
    return _videoPresenter;
}

- (void)onTopButtonClicked:(UIButton *)sender
{
    switch (sender.tag) {
        case kTagButtonEnd:
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                     message:nil
                                                                              preferredStyle:UIAlertControllerStyleActionSheet];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Leave Meeting"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action) {
                                                                  
                                                                  [self.actionPresenter leaveMeeting];
                                                              }]];
            
            if ([self.actionPresenter isMeetingHost]) {
                [alertController addAction:[UIAlertAction actionWithTitle:@"End Meeting"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction *action) {
                                                                      
                                                                      [self.actionPresenter EndMeeting];
                                                                  }]];
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
        case kTagButtonCameraSwitch:
        {
            [self.videoPresenter switchMyCamera];
            break;
        }
        case kTagButtonShrink:
        {
            if (self.shrinkButtonClickBlock) {
                self.shrinkButtonClickBlock();
            }
            break;
        }
        default:
            break;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
