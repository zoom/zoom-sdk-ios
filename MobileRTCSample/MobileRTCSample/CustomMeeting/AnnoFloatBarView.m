//
//  AnnoFloatBarView.m
//  MobileRTCSample
//
//  Created by Chao Bai on 2018/6/12.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import "AnnoFloatBarView.h"

@implementation AnnoFloatBarView


- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initSubView];
        self.isAnnotate = NO;
    }
    return self;
}

- (id)initWithCoder:(NSCoder*)coder
{
    if (self = [super initWithCoder:coder])
    {
        [self initSubView];
        self.isAnnotate = NO;
    }
    return self;
}

- (void)dealloc
{
    self.action= nil;
    self.pen = nil;
    self.spotlight = nil;
    self.erase = nil;
    self.delegate = nil;
    [super dealloc];
}

- (void)initSubView
{
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    UIButton *penButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [penButton setTitle:@"Pen" forState:UIControlStateNormal];
    [penButton setTintColor:[UIColor whiteColor] ];
    penButton.frame = CGRectMake(5, 5, 60, 40);
    [penButton addTarget:self action:@selector(onPenButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:penButton];
    self.pen = penButton;
    
    UIButton *spotlightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [spotlightButton setTitle:@"spotlight" forState:UIControlStateNormal];
    [spotlightButton setTintColor:[UIColor whiteColor] ];
    spotlightButton.frame = self.pen.frame;
    spotlightButton.frame = CGRectOffset(self.pen.frame, 80, 0);
    [spotlightButton addTarget:self action:@selector(onSpotlightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:spotlightButton];
    self.spotlight = spotlightButton;
    
    
    UIButton *eraseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [eraseButton setTitle:@"clear" forState:UIControlStateNormal];
    [eraseButton setTintColor:[UIColor whiteColor] ];
    eraseButton.frame = self.spotlight.frame;
    eraseButton.frame = CGRectOffset(self.spotlight.frame, 60+10, 0);
    [eraseButton addTarget:self action:@selector(onEraseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:eraseButton];
    self.erase = eraseButton;
    
    
    UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [actionButton setTitle:@"start" forState:UIControlStateNormal];
    [actionButton setTintColor:[UIColor whiteColor] ];
    actionButton.frame = self.erase.frame;
    actionButton.frame = CGRectOffset(self.erase.frame, 60+10, 0);
    [actionButton addTarget:self action:@selector(onActionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:actionButton];
    self.action = actionButton;
}

- (void)onPenButtonClicked:(id)sender
{
    MobileRTCAnnotationService *ms = [[MobileRTC sharedRTC] getAnnotationService];
    if (ms)
    {
        [ms setToolType:MobileRTCAnnoTool_Pen];
    }
}

- (void)onSpotlightButtonClicked:(id)sender
{
    MobileRTCAnnotationService *ms = [[MobileRTC sharedRTC] getAnnotationService];
    if (ms)
    {
        if ([ms isPresenter])
        {
            [ms setToolType:MobileRTCAnnoTool_Highligher];
        }
        else
        {
            [ms setToolType:MobileRTCAnnoTool_Arrow2];
        }
    }
}

- (void)onEraseButtonClicked:(id)sender
{
    MobileRTCAnnotationService *ms = [[MobileRTC sharedRTC] getAnnotationService];
    if (ms)
    {
        [ms setToolType:MobileRTCAnnoTool_Eraser];
    }
}

- (void)onActionButtonClicked:(id)sender
{
    if (self.delegate)
    {
        if (!self.isAnnotate)
        {
            if ([self.delegate respondsToSelector:@selector(onClickStartAnnotate)])
            {
                if ([self.delegate onClickStartAnnotate])
                {
                    [self.action setTitle:@"stop" forState:UIControlStateNormal];
                    self.isAnnotate = !self.isAnnotate;
                }
            }
        }
        
        else
        {
            if ([self.delegate respondsToSelector:@selector(onClickStopAnnotate)])
            {
                if ([self.delegate onClickStopAnnotate])
                {
                    [self.action setTitle:@"start" forState:UIControlStateNormal];
                    self.isAnnotate = !self.isAnnotate;
                }
            }
        }
    }
}


- (void)stopAnnotate
{
    self.hidden = YES;
    if (self.isAnnotate)
    {
        self.isAnnotate = !self.isAnnotate;
        [self onActionButtonClicked:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.action setTitle:@"start" forState:UIControlStateNormal];
        });
    }
}
@end
