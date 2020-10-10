//
//  VBViewController.m
//  MobileRTCSample
//
//  Created by Zoom Video Communications on 2020/4/7.
//  Copyright © 2020 Zoom Video Communications, Inc. All rights reserved.
//

#import "VBViewController.h"

@interface VBViewController ()
@property(nonatomic, strong) UIButton *addButton;
@property(nonatomic, strong) UIButton *removeButton;
@property(nonatomic, strong) UIButton *closeButton;
@property(nonatomic, strong) UIButton *useButton;
@end

@implementation VBViewController
@synthesize addButton, removeButton, closeButton, useButton;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.title = @"Virtual Background";
    
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(onDone:)];
    [self.navigationItem setLeftBarButtonItem:closeItem];
    [self.navigationItem.leftBarButtonItem setTintColor:RGBCOLOR(0x2D, 0x8C, 0xFF)];
    
    
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    BOOL supportVB = [ms isSupportVirtualBG];
    NSLog(@"[VB Test] isSupportVirtualBG : %@.", @(supportVB));
    if (!supportVB) {
        return;
    }
    
    BOOL ret = [ms startPreviewWithFrame:self.view.frame];
    if (!ret) {
        NSLog(@"[VB Test] startPreviewWithFrame, please check camera status.");
        return;
    }
    
    NSLog(@"[VB Test] startPreviewWithFrame success.");
    
    NSLog(@"[VB Test] ms.previewView : %@.", ms.previewView);
    if (ms.previewView) {
        [self.view addSubview:ms.previewView];
    }
    
    [self initSubViews];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    NSInteger btnNum = 4;
    CGFloat marginLeft = 25.0;
    CGFloat marginRight = 25.0;
    CGFloat buttonW = 80.0;
    CGFloat buttonH = 50.0;
    CGFloat startY = self.view.frame.size.height - 150;
    CGFloat intervalX = (SCREEN_WIDTH - marginLeft - marginRight - btnNum*buttonW) / (btnNum - 1);
    
    addButton.frame = CGRectMake(marginLeft, startY, buttonW, buttonH);
    removeButton.frame = CGRectMake(marginLeft + buttonW + intervalX, startY, buttonW, buttonH);
    closeButton.frame = CGRectMake(marginLeft + 2*buttonW + 2*intervalX, startY, buttonW, buttonH);
    useButton.frame = CGRectMake(marginLeft + 3*buttonW + 3*intervalX, startY, buttonW, buttonH);
}

- (void)initSubViews {
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    BOOL ret = [ms isUsingGreenVB];
    BOOL smartVB = [ms isSupportSmartVirtualBG];
    NSLog(@"[VB Test] isUsingGreenVB : %@, isSupportSmartVirtualBG : %@", @(ret), @(smartVB));
//    smartVB = 0;
    if (smartVB) {
        addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [addButton setTitle:NSLocalizedString(@"Add", @"") forState:UIControlStateNormal];
        [addButton setBackgroundColor:RGBCOLOR(0x66, 0x66, 0x66)];
        [addButton setTitleColor:RGBCOLOR(45, 140, 255) forState:UIControlStateNormal];
        addButton.titleLabel.font = BUTTON_FONT;
        [addButton addTarget:self action:@selector(onAddButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        removeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [removeButton setTitle:NSLocalizedString(@"Remove", @"") forState:UIControlStateNormal];
        [removeButton setBackgroundColor:RGBCOLOR(0x66, 0x66, 0x66)];
        [removeButton setTitleColor:RGBCOLOR(45, 140, 255) forState:UIControlStateNormal];
        removeButton.titleLabel.font = BUTTON_FONT;
        [removeButton addTarget:self action:@selector(onRemoveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

        closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeButton setTitle:NSLocalizedString(@"Close", @"") forState:UIControlStateNormal];
        [closeButton setBackgroundColor:RGBCOLOR(0x66, 0x66, 0x66)];
        [closeButton setTitleColor:RGBCOLOR(45, 140, 255) forState:UIControlStateNormal];
        closeButton.titleLabel.font = BUTTON_FONT;
        [closeButton addTarget:self action:@selector(onCloseVBButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        useButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [useButton setTitle:NSLocalizedString(@"Use", @"") forState:UIControlStateNormal];
        [useButton setBackgroundColor:RGBCOLOR(0x66, 0x66, 0x66)];
        [useButton setTitleColor:RGBCOLOR(45, 140, 255) forState:UIControlStateNormal];
        useButton.titleLabel.font = BUTTON_FONT;
        [useButton addTarget:self action:@selector(onUseVBButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

        [self.view addSubview:addButton];
        [self.view addSubview:removeButton];
        [self.view addSubview:closeButton];
        [self.view addSubview:useButton];
    } else {
        MobileRTCMeetError error = [ms enableGreenVB:YES];
        NSLog(@"[VB Test] enableGreenVB : %@.", @(error));
        // please select one point and use the "- (MobileRTCMeetError)selectGreenVBPoint:(CGPoint)point;" pass to sdk.
    }
}

- (void)onDone:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)onAddButtonClicked:(id)sender
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if ([ms isSupportSmartVirtualBG]) {
        MobileRTCMeetError ret = [ms addBGImage:[UIImage imageNamed:@"zoom_intro3"]];
        NSLog(@"[VB Test] addBGImage : %@.", @(ret));
    }
}

- (void)onRemoveButtonClicked:(id)sender
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    NSArray *imgList = [ms getBGImageList];
    if ([ms isSupportSmartVirtualBG]) {
        MobileRTCMeetError ret = [ms removeBGImage:[imgList lastObject]];
        NSLog(@"[VB Test] removeBGImage : %@.", @(ret));
    }
}

- (void)onCloseVBButtonClicked:(id)sender
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if ([ms isSupportSmartVirtualBG]) {
        MobileRTCMeetError ret = [ms useNoneImage];
        NSLog(@"[VB Test] useNoneImage : %@.", @(ret));
    }
}

- (void)onUseVBButtonClicked:(id)sender
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if ([ms isSupportSmartVirtualBG]) {
        NSArray *imgList = [ms getBGImageList];
        for (MobileRTCVirtualBGImageInfo *obj in imgList) {
            if (!obj.isNone && !obj.isSelect) {
                MobileRTCMeetError ret = [ms useBGImage:obj];
                NSLog(@"[VB Test] useBGImage : %@.", @(ret));
                return;
            }
        }
    }
    
    NSLog(@"[VB Test] onUseVBButtonClicked : not found any background image");
}
@end
