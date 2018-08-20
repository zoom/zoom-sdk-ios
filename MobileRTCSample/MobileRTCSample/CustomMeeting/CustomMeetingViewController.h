//
//  CustomMeetingViewController.h
//  MobileRTCSample
//
//  Created by chaobai on 14/11/2017.
//  Copyright © 2017 Zoom Video Communications, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GalleryViewController.h"
#import "WallViewController.h"
#import "RemoteShareViewController.h"
#import "LocalShareViewController.h"
#import "ShrinkViewController.h"
#import "AnnoFloatBarView.h"

@interface CustomMeetingViewController : UIViewController

@property (strong, nonatomic) UIView *topPanel;
@property (strong, nonatomic) UIButton *shrinkBtn;
@property (strong, nonatomic) UILabel *titleLbl;
@property (strong, nonatomic) UIButton *moreBtn;

@property (strong, nonatomic) UIView *bottomPanel;
@property (strong, nonatomic) UIButton *audioBtn;
@property (strong, nonatomic) UIButton *videoBtn;
@property (strong, nonatomic) UIButton *endBtn;


@property (strong, nonatomic) AnnoFloatBarView * annoFloatBarView;

@property (strong, nonatomic) UIView *baseView;

@property (strong, nonatomic) NSMutableArray * vcArray;

@property (strong, nonatomic) GalleryViewController *galleryVC;
@property (strong, nonatomic) WallViewController *wallVC;
@property (strong, nonatomic) RemoteShareViewController *remoteShareVC;
@property (strong, nonatomic) LocalShareViewController *localShareVC;
@property (strong, nonatomic) ShrinkViewController *shrinkVC;

@property (assign, nonatomic) BOOL isFullScreenMode;
@property (assign, nonatomic) CGAffineTransform oriTransform;
@property (retain, nonatomic) UIPanGestureRecognizer * panGesture;
@property (retain, nonatomic) UITapGestureRecognizer * tapGesture;

- (void)showGalleryView;
- (void)showWallView;
- (void)showRemoteShareView;
- (void)showLocalShareView;
- (void)showShrinkView;

- (void)updateVideoOrShare;

- (void)updateMyAudioStatus;
- (void)updateMyVideoStatus;

@end
