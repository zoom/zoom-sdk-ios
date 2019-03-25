//
//  CustomMeetingViewController.h
//  MobileRTCSample
//
//  Created by Murray Li on 2018/10/12.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopPanelView.h"
#import "BottomPanelView.h"
#import "ThumbTableViewCell.h"
#import "ThumbView.h"
#import "RemoteShareViewController.h"
#import "LocalShareViewController.h"
#import "VideoViewController.h"
#import "AnnoFloatBarView.h"
#import "SDKActionPresenter.h"
#import "SDKSharePresenter.h"

@interface CustomMeetingViewController : UIViewController

@property (strong, nonatomic) UIView                    * baseView;
@property (strong, nonatomic) TopPanelView              * topPanelView;
@property (strong, nonatomic) BottomPanelView           * bottomPanelView;
@property (strong, nonatomic) ThumbView                 * thumbView;
@property (nonatomic)         BOOL                      isShowTopBottonPanel;

@property (assign, nonatomic) BOOL                      isFullScreenMode;
@property (assign, nonatomic) CGAffineTransform         oriTransform;
@property (retain, nonatomic) UIPanGestureRecognizer    * panGesture;

@property (strong, nonatomic) NSMutableArray                * vcArray;
@property (strong, nonatomic) VideoViewController           * videoVC;
@property (strong, nonatomic) RemoteShareViewController     * remoteShareVC;
@property (strong, nonatomic) LocalShareViewController      * localShareVC;

@property (strong, nonatomic) AnnoFloatBarView * annoFloatBarView;

@property (strong, nonatomic) SDKActionPresenter     *actionPresenter;
@property (strong, nonatomic) SDKSharePresenter      *sharePresenter;

- (void)updateVideoOrShare;
- (void)updateMyAudioStatus;
- (void)updateMyVideoStatus;
- (void)updateMyShareStatus;

- (void)showVideoView;
- (void)showRemoteShareView;
- (void)showLocalShareView;
- (void)hideAnnotationView;
@end

