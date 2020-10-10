//
//  VideoViewController.h
//  MobileRTCSample
//
//  Created by Zoom Video Communications on 2018/10/17.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoViewController : UIViewController
@property (strong, nonatomic) MobileRTCPreviewVideoView  * preVideoView;
@property (strong, nonatomic) MobileRTCVideoView        * videoView;
@end

