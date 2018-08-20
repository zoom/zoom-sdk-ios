//
//  GalleryViewController.h
//  MobileRTCSample
//
//  Created by Robust on 2017/12/22.
//  Copyright © 2017年 Zoom Video Communications, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryViewController : UIViewController

@property (assign, nonatomic) NSUInteger activeVideoID;

@property (retain, nonatomic) MobileRTCPreviewVideoView * previewVideoView;

@property (retain, nonatomic) MobileRTCActiveVideoView*   videoView;

@property (retain, nonatomic) MobileRTCVideoView*   thumbView;

@property (retain, nonatomic) UIButton *cameraButton;

@property (assign, nonatomic) BOOL inPreview;

- (void)updateGalleryVideo;

- (void)removePreviewVideoView;

@end
