//
//  VideoViewController.m
//  MobileRTCSample
//
//  Created by Zoom Video Communications on 2018/10/17.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import "VideoViewController.h"

@interface VideoViewController ()

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.videoView];
    
    [self.view addSubview:self.preVideoView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)dealloc
{
    self.videoView = nil;
    self.preVideoView = nil;
    [super dealloc];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGRect frame = self.view.bounds;
    self.videoView.frame = frame;
}

- (MobileRTCVideoView*)videoView
{
    if (!_videoView)
    {
        _videoView = [[MobileRTCVideoView alloc] initWithFrame:self.view.bounds];
        [_videoView setVideoAspect:MobileRTCVideoAspect_PanAndScan];
    }
    return _videoView;
}

- (MobileRTCPreviewVideoView*)preVideoView
{
    if (!_preVideoView)
    {
        _preVideoView = [[MobileRTCPreviewVideoView alloc] initWithFrame:self.view.bounds];
    }
    return _preVideoView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
