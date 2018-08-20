//
//  ShrinkViewController.h
//  MobileRTCSample
//
//  Created by chaobai on 10/01/2018.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShrinkViewController : UIViewController

@property (assign, nonatomic) NSUInteger activeVideoID;

@property (retain, nonatomic) MobileRTCVideoView*   videoView;

- (void)updateShrinkVideo;

@end
