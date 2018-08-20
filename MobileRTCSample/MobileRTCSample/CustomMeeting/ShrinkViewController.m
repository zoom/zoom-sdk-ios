//
//  ShrinkViewController.m
//  MobileRTCSample
//
//  Created by chaobai on 10/01/2018.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import "ShrinkViewController.h"

@interface ShrinkViewController ()

@end

@implementation ShrinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.videoView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.videoView = nil;
    [super dealloc];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGRect frame = self.view.bounds;
    self.videoView.frame = frame;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self updateShrinkVideo];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.videoView stopAttendeeVideo];
}

- (MobileRTCVideoView *)videoView
{
    if (!_videoView)
    {
        _videoView = [[MobileRTCVideoView alloc] initWithFrame:CGRectZero];
    }
    return _videoView;
}


- (void)updateShrinkVideo
{
    [self.videoView showAttendeeVideoWithUserID:self.activeVideoID];
}

@end
