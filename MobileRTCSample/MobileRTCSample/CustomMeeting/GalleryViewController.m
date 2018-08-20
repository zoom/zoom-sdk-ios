//
//  GalleryViewController.m
//  MobileRTCSample
//
//  Created by Robust on 2017/12/22.
//  Copyright © 2017年 Zoom Video Communications, Inc. All rights reserved.
//

#import "GalleryViewController.h"

#define THUMB_WIDTH 128
#define THUMB_HEIGHT (THUMB_WIDTH*3/4)
#define THUMB_WIDTH_IPAD 240
#define THUMB_HEIGHT_IPAD (THUMB_WIDTH_IPAD*9/16)

@interface GalleryViewController ()

@end

@implementation GalleryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.videoView];
    [self.view addSubview:self.thumbView];
    [self.view insertSubview:self.previewVideoView aboveSubview:self.videoView];
    [self.thumbView addSubview:self.cameraButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.previewVideoView = nil;
    self.videoView = nil;
    self.thumbView = nil;
    self.cameraButton = nil;
    
    [super dealloc];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGRect frame = self.view.bounds;
    self.videoView.frame = frame;
    self.previewVideoView.frame = frame;
    
    CGFloat gap = 10;
    CGFloat width = IS_IPAD ? THUMB_WIDTH_IPAD : THUMB_WIDTH;
    CGFloat height = IS_IPAD ? THUMB_HEIGHT_IPAD : THUMB_HEIGHT;
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    BOOL landscape = UIInterfaceOrientationIsLandscape(orientation);
    if (landscape)
    {
        self.thumbView.frame = CGRectMake(frame.size.width-width-gap, frame.size.height-height-8*gap, width, height);
    }
    else
    {
        self.thumbView.frame = CGRectMake(frame.size.width-height-gap, frame.size.height-width-8*gap, height, width);
    }
    
    [self updateGalleryVideo];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self updateGalleryVideo];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.thumbView stopAttendeeVideo];
}


- (MobileRTCPreviewVideoView*)previewVideoView
{
    if (!_previewVideoView)
    {
        _previewVideoView = [[MobileRTCPreviewVideoView alloc]initWithFrame:self.view.bounds];
        [_previewVideoView setVideoAspect:MobileRTCVideoAspect_PanAndScan];
        self.inPreview = YES;
    }
    return _previewVideoView;
}

- (MobileRTCActiveVideoView*)videoView
{
    if (!_videoView)
    {
        _videoView = [[MobileRTCActiveVideoView alloc] initWithFrame:self.view.bounds];
    }
    return _videoView;
}

- (MobileRTCVideoView *)thumbView
{
    if (!_thumbView)
    {
        _thumbView = [[MobileRTCVideoView alloc] initWithFrame:CGRectZero];
        _thumbView.layer.borderColor = [[UIColor whiteColor] CGColor];
        _thumbView.layer.borderWidth = 1.f;
        _thumbView.hidden = YES;
    }
    return _thumbView;
}

- (UIButton*)cameraButton
{
    if (!_cameraButton)
    {
        _cameraButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
        [_cameraButton setImage:[UIImage imageNamed:@"icon_switchcam"] forState:UIControlStateNormal];
        [_cameraButton addTarget:self action:@selector(onSwitchCamera:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cameraButton;
}

- (void)onSwitchCamera:(id)sender
{
    [[[MobileRTC sharedRTC] getMeetingService] switchMyCamera];
}

- (void)setActiveVideoID:(NSUInteger)uid
{
    _activeVideoID = uid;
}

- (void)updateActiveVideo
{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    BOOL landscape = UIInterfaceOrientationIsLandscape(orientation);
    BOOL myself = [[[MobileRTC sharedRTC] getMeetingService] isMyself:self.activeVideoID];
    MobileRTCVideoAspect aspect = (landscape || myself) ? MobileRTCVideoAspect_PanAndScan : MobileRTCVideoAspect_LetterBox;
    [self.videoView setVideoAspect:aspect];
}

- (void)updateThumbnailVideo
{
    BOOL noAttendee = [[[[MobileRTC sharedRTC] getMeetingService] getInMeetingUserList] count] <= 1;
    if (noAttendee)
    {
        [self.thumbView stopAttendeeVideo];
    }
    else
    {
        NSUInteger myUid = [[[MobileRTC sharedRTC] getMeetingService] myselfUserID];
        [self.thumbView showAttendeeVideoWithUserID:myUid];
    }
    
    BOOL myVideoOn = [[[MobileRTC sharedRTC] getMeetingService] isSendingMyVideo];
    [self.cameraButton setHidden:!myVideoOn];
    
    [self.thumbView setHidden:noAttendee];
}

- (void)updateGalleryVideo
{
    [self updateActiveVideo];
    
    [self updateThumbnailVideo];
}

- (void)removePreviewVideoView
{
    if (self.inPreview)
    {
        [self.previewVideoView removeFromSuperview];
        self.previewVideoView = nil;
        self.inPreview = NO;
        [self updateGalleryVideo];
    }
}
@end
