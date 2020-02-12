//
//  OpenGLVCTopBar.m
//  MobileRTCSample
//
//  Created by Murray Li on 2019/8/6.
//  Copyright © 2019 Zoom Video Communications, Inc. All rights reserved.
//

#import "TopBar.h"
#import "SDKActionPresenter.h"
#import "SDKVideoPresenter.h"

const CGFloat TOP_BTN_LEN = 40;

@interface TopBar ()
@property (strong, nonatomic) CAGradientLayer *gradientLayer;
@property (strong, nonatomic) UILabel         *titleLabel;
@property (strong, nonatomic) UIButton        *leaveBtn;

@property (strong, nonatomic) SDKActionPresenter     *actionPresenter;
@property (strong, nonatomic) SDKVideoPresenter      *videoPresenter;
@end

@implementation TopBar

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
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.leaveBtn];
        
        self.titleLabel.text = [[MobileRTCInviteHelper sharedInstance] ongoingMeetingNumber];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self updateFrame];
}

- (void)updateFrame
{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    BOOL landscape = UIInterfaceOrientationIsLandscape(orientation);
    
    if (landscape) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, Top_Height);
        self.leaveBtn.frame = CGRectMake(SCREEN_WIDTH - 16 - 90, 20.0, 90, 32);
        self.titleLabel.frame = CGRectMake((self.frame.size.width-120)/2, 20.0, 120, TOP_BTN_LEN);
    } else {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, IPHONE_X ? Top_Height + SAFE_ZOOM_INSETS : Top_Height);
        self.leaveBtn.frame = CGRectMake(SCREEN_WIDTH - 16 - 90, IPHONE_X ? SAFE_ZOOM_INSETS + 20.0 : 20.0, 90, 32);
        self.titleLabel.frame = CGRectMake((self.frame.size.width-120)/2, IPHONE_X ? SAFE_ZOOM_INSETS + 20.0 : 20.0, 120, TOP_BTN_LEN);
    }
    
    self.gradientLayer.frame = self.bounds;
}

- (void)dealloc {
    self.gradientLayer = nil;
    self.titleLabel = nil;
    self.leaveBtn = nil;
    
    self.actionPresenter = nil;
    self.videoPresenter = nil;
    [super dealloc];
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
        _leaveBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 16 - 48, IPHONE_X ? (44.0 + 15.0) : 20.0, 90, 32)];
        [_leaveBtn setTitle:@"LEAVE" forState:UIControlStateNormal];
        _leaveBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [_leaveBtn setTitleColor:RGBCOLOR(224,40,40) forState:UIControlStateNormal];
        _leaveBtn.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        _leaveBtn.layer.cornerRadius = _leaveBtn.frame.size.height/2;
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
                                                                  if (self.endOnClickBlock) {
                                                                      self.endOnClickBlock();
                                                                  }
                                                              }]];
            
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


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end


