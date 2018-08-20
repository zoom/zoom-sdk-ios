//
//  CustomMeetingViewController.m
//  MobileRTCSample
//
//  Created by chaobai on 14/11/2017.
//  Copyright © 2017 Zoom Video Communications, Inc. All rights reserved.
//

#import "CustomMeetingViewController.h"
#import "CustomMeetingViewController+MeetingDelegate.h"

const CGFloat BOT_BTN_LEN = 60;
const CGFloat TOP_BTN_LEN = 40;

@interface CustomMeetingViewController () <AnnoFloatBarViewDelegate>

@end

@implementation CustomMeetingViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isFullScreenMode = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];

    [self initSubView];
    
    [self initGuestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.panGesture = nil;
    self.tapGesture = nil;
    [self uninitSubView];
    
    [super dealloc];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self updatePanelFrame];
    
    [self layoutShrinkViewFrame];
    
    self.annoFloatBarView.frame = CGRectMake(0, self.view.frame.size.height-150,self.view.frame.size.width, 50);
}

- (void)initSubView
{
    [self.view addSubview:self.baseView];
    
    [self addChildViewController:self.galleryVC];
    [self.baseView addSubview:self.galleryVC.view];
    [self.galleryVC didMoveToParentViewController:self];
    
    self.galleryVC.view.frame = self.view.bounds;
    
    [self initPanel];
    
    self.vcArray = [NSMutableArray array];
    [self.vcArray addObject:self.galleryVC];
    [self.vcArray addObject:self.wallVC];
    [self.vcArray addObject:self.remoteShareVC];
    [self.vcArray addObject:self.localShareVC];
    [self.vcArray addObject:self.shrinkVC];
    
    [self.view addSubview:self.annoFloatBarView];
    self.annoFloatBarView.hidden = YES;
}

- (void)uninitSubView
{
    self.topPanel = nil;
    self.shrinkBtn = nil;
    self.titleLbl = nil;
    self.moreBtn = nil;
    
    self.bottomPanel = nil;
    self.audioBtn = nil;
    self.videoBtn = nil;
    self.endBtn = nil;
    
    self.annoFloatBarView = nil;
    
    [self removeAllSubView];
    self.galleryVC = nil;
    self.wallVC = nil;
    self.remoteShareVC = nil;
    self.localShareVC = nil;
    self.shrinkVC = nil;
    
    [self.vcArray removeAllObjects];
    self.vcArray = nil;
}

#pragma mark - Top & Bottom Panel

- (void)initPanel
{
    [self.view addSubview:self.topPanel];
    
    [self.topPanel addSubview:self.shrinkBtn];
    [self.topPanel addSubview:self.titleLbl];
    [self.topPanel addSubview:self.moreBtn];
    
    [self.view addSubview:self.bottomPanel];
    
    [self.bottomPanel addSubview:self.audioBtn];
    [self.bottomPanel addSubview:self.endBtn];
    [self.bottomPanel addSubview:self.videoBtn];
    
    [self.view setNeedsLayout];
}

- (void)updatePanelFrame
{
    CGRect frame = self.view.bounds;
    
    CGFloat paneWidth = frame.size.width;
    CGFloat paneHeight = 60;
    self.topPanel.frame = CGRectMake(0, 0, paneWidth, paneHeight);
    
    CGFloat topGap = 20;
    self.shrinkBtn.frame = CGRectMake(0, topGap, TOP_BTN_LEN, TOP_BTN_LEN);
    self.titleLbl.frame = CGRectMake(TOP_BTN_LEN, topGap, frame.size.width-2*TOP_BTN_LEN, TOP_BTN_LEN);
    self.moreBtn.frame = CGRectMake(frame.size.width-TOP_BTN_LEN, topGap, TOP_BTN_LEN, TOP_BTN_LEN);
    
    paneWidth = 300;
    CGFloat offsetX = (frame.size.width - paneWidth) / 2.;
    CGFloat offsetY = frame.size.height - paneHeight - 10;
    self.bottomPanel.frame = CGRectMake(offsetX, offsetY, paneWidth, paneHeight);
    
    CGFloat btnCount = 3;
    CGFloat width = self.bottomPanel.frame.size.width / btnCount;
    CGRect regionFrame = CGRectMake(0, 0, width, paneHeight);
    
    //Audio
    self.audioBtn.center = CGPointMake(CGRectGetMidX(regionFrame), CGRectGetMidY(regionFrame));
    regionFrame = CGRectOffset(regionFrame, regionFrame.size.width, 0);
    
    //Leave
    self.endBtn.center = CGPointMake(CGRectGetMidX(regionFrame), CGRectGetMidY(regionFrame));
    regionFrame = CGRectOffset(regionFrame, regionFrame.size.width, 0);

    //Video
    self.videoBtn.center = CGPointMake(CGRectGetMidX(regionFrame), CGRectGetMidY(regionFrame));
    regionFrame = CGRectOffset(regionFrame, regionFrame.size.width, 0);
}

- (UIView*)topPanel
{
    if (!_topPanel)
    {
        _topPanel = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _topPanel;
}

- (UIButton*)shrinkBtn
{
    if (!_shrinkBtn)
    {
        _shrinkBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, TOP_BTN_LEN, TOP_BTN_LEN)];
        [_shrinkBtn setImage:[UIImage imageNamed:@"icon_avp_reduce_black"] forState:UIControlStateNormal];
        [_shrinkBtn addTarget:self action:@selector(onShrinkButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _shrinkBtn;
}

- (UILabel*)titleLbl
{
    if (!_titleLbl)
    {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        _titleLbl.textColor = [UIColor whiteColor];
        _titleLbl.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:20];
    }
    return _titleLbl;
}

- (UIButton*)moreBtn
{
    if (!_moreBtn)
    {
        _moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, TOP_BTN_LEN, TOP_BTN_LEN)];
        [_moreBtn setImage:[UIImage imageNamed:@"icon_meeting_more"] forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(onMoreButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}

- (UIView*)bottomPanel
{
    if (!_bottomPanel)
    {
        _bottomPanel = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _bottomPanel;
}

- (UIButton*)audioBtn
{
    if (!_audioBtn)
    {
        _audioBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BOT_BTN_LEN, BOT_BTN_LEN)];
        _audioBtn.layer.cornerRadius = BOT_BTN_LEN / 2;
        _audioBtn.layer.borderWidth = 1.;
        _audioBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
        [_audioBtn setImage:[UIImage imageNamed:@"icon_meeting_audio"] forState:UIControlStateNormal];
        [_audioBtn addTarget:self action:@selector(onAudioButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _audioBtn;
}

- (UIButton*)videoBtn
{
    if (!_videoBtn)
    {
        _videoBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BOT_BTN_LEN, BOT_BTN_LEN)];
        _videoBtn.layer.cornerRadius = BOT_BTN_LEN / 2;
        _videoBtn.layer.borderWidth = 1.;
        _videoBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
        [_videoBtn setImage:[UIImage imageNamed:@"icon_meeting_video"] forState:UIControlStateNormal];
        [_videoBtn addTarget:self action:@selector(onVideoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _videoBtn;
}

- (UIButton*)endBtn
{
    if (!_endBtn)
    {
        _endBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BOT_BTN_LEN, BOT_BTN_LEN)];
        _endBtn.layer.backgroundColor = [[UIColor redColor] CGColor];
        _endBtn.layer.cornerRadius = BOT_BTN_LEN / 2;
        [_endBtn setImage:[UIImage imageNamed:@"icon_end_meeting"] forState:UIControlStateNormal];
        [_endBtn addTarget:self action:@selector(onEndButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _endBtn;
}

#pragma mark - Video & Share VC

- (UIView*)baseView
{
    if (!_baseView)
    {
        _baseView = [[UIView alloc] initWithFrame:self.view.bounds];
        _baseView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _baseView;
}

- (GalleryViewController*)galleryVC
{
    if (!_galleryVC)
    {
        _galleryVC = [[GalleryViewController alloc] init];
        _galleryVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _galleryVC;
}

- (WallViewController*)wallVC
{
    if (!_wallVC)
    {
        _wallVC = [[WallViewController alloc] init];
        _wallVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _wallVC;
}

- (RemoteShareViewController*)remoteShareVC
{
    if (!_remoteShareVC)
    {
        _remoteShareVC = [[RemoteShareViewController alloc] init];
        _remoteShareVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _remoteShareVC;
}

- (LocalShareViewController*)localShareVC
{
    if (!_localShareVC)
    {
        _localShareVC = [[LocalShareViewController alloc]init];
        _localShareVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _localShareVC;
}

- (ShrinkViewController*)shrinkVC
{
    if (!_shrinkVC)
    {
        _shrinkVC = [[ShrinkViewController alloc]init];
        _shrinkVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _shrinkVC;
}

- (void)removeAllSubView
{
    for (UIViewController * vc in self.vcArray)
    {
        [vc willMoveToParentViewController:nil];
        [vc.view removeFromSuperview];
        [vc removeFromParentViewController];
    }
}

- (void)showSubView:(UIViewController*)viewCtrl
{
    [self addChildViewController:viewCtrl];
    [self.baseView addSubview:viewCtrl.view];
    [viewCtrl didMoveToParentViewController:self];
    
    viewCtrl.view.frame = self.view.bounds;
}

- (void)showGalleryView
{
    [self removeAllSubView];
    [self showSubView:self.galleryVC];
}

- (void)showWallView
{
    [self removeAllSubView];
    [self showSubView:self.wallVC];
}

- (void)showRemoteShareView
{
    [self removeAllSubView];
    [self showSubView:self.remoteShareVC];
    [self disableGuestureRecognizer];
    
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if (ms && ![ms isAnnotationOff])
    {
        self.annoFloatBarView.hidden = NO;
    }
}

- (void)showLocalShareView
{
    [self removeAllSubView];
    [self showSubView:self.localShareVC];
    [[[MobileRTC sharedRTC] getMeetingService] appShareWithView:self.localShareVC.view];
    [self disableGuestureRecognizer];
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if (ms && ![ms isAnnotationOff])
    {
        self.annoFloatBarView.hidden = NO;
    }
}

- (void)showShrinkView
{
    [self removeAllSubView];
    [self showSubView:self.shrinkVC];
}

- (void)updateVideoOrShare
{
    if (self.galleryVC.parentViewController)
    {
        [self.galleryVC updateGalleryVideo];
    }
    
    if (self.wallVC.parentViewController)
    {
        [self.wallVC updateWallVideo];
    }
    
    if (self.remoteShareVC.parentViewController)
    {
        [self.remoteShareVC updateShareView];
    }
    
    if (self.shrinkVC.parentViewController)
    {
        [self.shrinkVC updateShrinkVideo];
    }
}

#pragma mark - Actions

- (void)onAudioButtonClick:(id)sender
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if (ms)
    {
        MobileRTCAudioType audioType = [ms myAudioType];
        switch (audioType)
        {
            case MobileRTCAudioType_VoIP: //voip
            case MobileRTCAudioType_Telephony: //phone
            {
                if (![ms canUnmuteMyAudio])
                {
                    break;
                }
                BOOL isMuted = [ms isMyAudioMuted];
                [ms muteMyAudio:!isMuted];
                break;
            }
            case MobileRTCAudioType_None:
            {
                //Supported VOIP
                if ([ms isSupportedVOIP])
                {
                    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8"))
                    {
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"To hear others\n please join audio", @"")
                                                                                                 message:nil
                                                                                          preferredStyle:UIAlertControllerStyleAlert];
                        
                        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Call via Internet", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                            //Join VOIP
                            MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
                            if (ms)
                            {
                                [ms connectMyAudio:YES];
                            }
                        }]];
                        
                        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                        }]];
                        
                        [self presentViewController:alertController animated:YES completion:nil];
                    }
                }
                break;
            }
        }
    }
}

- (void)onVideoButtonClick:(id)sender
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if (ms)
    {
        if (![ms canUnmuteMyVideo])
        {
            return;
        }
        BOOL mute = [ms isSendingMyVideo];
        MobileRTCVideoError error = [ms muteMyVideo:mute];
    }
}

- (void)onMoreButtonClick:(id)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    
    if (nil == self.localShareVC.parentViewController)
    {
        [alertController addAction:[UIAlertAction actionWithTitle:@"Switch View"
                                                            style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                                                                //if (nil != self.localShareVC.parentViewController) return;
                                                                BOOL isViewSharing = [[[MobileRTC sharedRTC] getMeetingService] isViewingShare];
                                                                BOOL inWallView = (nil != self.wallVC.parentViewController);
                                                                BOOL inShareView = (nil != self.remoteShareVC.parentViewController);
                                                                if (isViewSharing)
                                                                {
                                                                    if (inShareView) [self showWallView];
                                                                    else [self showRemoteShareView];
                                                                }
                                                                else
                                                                {
                                                                    if (inWallView) [self showGalleryView];
                                                                    else [self showWallView];
                                                                }
                                                            }]];
    }
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Participants List"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          [[[MobileRTC sharedRTC] getMeetingService] presentParticipantsViewController:self];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Pin My Video"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          NSInteger myUid = [[[MobileRTC sharedRTC] getMeetingService] myselfUserID];
                                                          BOOL pinned = [[[MobileRTC sharedRTC] getMeetingService] isUserPinned:myUid];
                                                          [[[MobileRTC sharedRTC] getMeetingService] pinVideo:!pinned withUser:myUid];
                                                      }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Switch My Audio"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          MobileRTCAudioError error = [[[MobileRTC sharedRTC] getMeetingService] switchMyAudioSource];
                                                          NSLog(@"Switch My Audio error:%d...", error);
                                                      }]];

    
    
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    
    if (ms)
    {
        if ( !([ms isStartingShare] && ![ms isViewingShare] ))
        {
            [alertController addAction:[UIAlertAction actionWithTitle:@"Start Share"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action) {
                                                                  [[[MobileRTC sharedRTC] getMeetingService] startAppShare];
                                                              }]];
        }
        else
        {
            [alertController addAction:[UIAlertAction actionWithTitle:@"Stop Share"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action) {
                                                                  [[[MobileRTC sharedRTC] getMeetingService] stopAppShare];
                                                              }]];
        }
    }
    
    if (ms)
    {
        MobileRTCAudioType audioType = [ms myAudioType];
        if (audioType != MobileRTCAudioType_None)
        {
            [alertController addAction:[UIAlertAction actionWithTitle:@"Disconnect Audio"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action) {
                                                                  [[[MobileRTC sharedRTC] getMeetingService] connectMyAudio:NO];
                                                              }]];
        }
        
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }]];
    }
    
    UIPopoverPresentationController *popover = alertController.popoverPresentationController;
    if (popover)
    {
        UIButton *btn = (UIButton*)sender;
        popover.sourceView = btn;
        popover.sourceRect = btn.bounds;
        popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
    }
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)onEndButtonClick:(id)sender
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if (!ms) return;
    
    BOOL isHost = [ms isMeetingHost];
    LeaveMeetingCmd leaveCmd = isHost ? LeaveMeetingCmd_End : LeaveMeetingCmd_Leave;
    [ms leaveMeetingWithCmd:leaveCmd];
}

- (void)updateMyAudioStatus
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if (!ms) return;

    MobileRTCAudioType audioType = [ms myAudioType];
    if (audioType == MobileRTCAudioType_None)
    {
        [self.audioBtn setImage:[UIImage imageNamed:@"icon_meeting_noaudio"] forState:UIControlStateNormal];
    }
    else
    {
        if([ms isMyAudioMuted])
        {
            [self.audioBtn setImage:[UIImage imageNamed:@"icon_meeting_audio_mute"] forState:UIControlStateNormal];
        }
        else
        {
            [self.audioBtn setImage:[UIImage imageNamed:@"icon_meeting_audio"] forState:UIControlStateNormal];
        }
    }
}

- (void)updateMyVideoStatus
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if (!ms) return;
    
    BOOL mute = [ms isSendingMyVideo];
    if(!mute)
    {
        [self.videoBtn setImage:[UIImage imageNamed:@"icon_meeting_video_mute"] forState:UIControlStateNormal];
    }
    else
    {
        [self.videoBtn setImage:[UIImage imageNamed:@"icon_meeting_video"] forState:UIControlStateNormal];
    }
}

#pragma mark - Shrink & Delegate

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SHRINKMODEWIDTH (IS_IPAD ? 240 : 140)
#define SHRINKMODEHEIGHT (SHRINKMODEWIDTH*3/4)

- (void)layoutShrinkViewFrame
{
    if ( (![self isFullScreenMode] && self.panGesture.state == UIGestureRecognizerStatePossible) )
    {
        self.view.frame = CGRectMake(SCREEN_WIDTH - SHRINKMODEWIDTH, 0, SHRINKMODEWIDTH, SHRINKMODEHEIGHT);
    }
}

- (void)initGuestureRecognizer
{
    if (!_tapGesture)
    {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onViewTaped:)];
        [self.view addGestureRecognizer:tap];
        self.tapGesture = tap;
        [tap release];
    }

    if (!_panGesture)
    {
        UIPanGestureRecognizer *pan =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(onViewPan:)];
        self.panGesture = pan;
        [self.view addGestureRecognizer:pan];
        [pan release];
    }
    
    self.tapGesture.enabled = YES;
    self.panGesture.enabled = YES;

}

- (void)disableGuestureRecognizer
{
    self.tapGesture.enabled = NO;
    self.panGesture.enabled = NO;
}

- (void)onShrinkButtonClick:(id)sender
{
    self.isFullScreenMode = NO;
    self.oriTransform = self.view.transform;
    [self changeToPIPModeNeedAnimate:self.view];
}


- (void)changeToPIPModeNeedAnimate:(UIView*)view
{
    CGFloat animateTime = 1.0;
    [UIView animateWithDuration:animateTime
                     animations:^{
                         view.transform = CGAffineTransformScale(view.transform, 0.2, 0.2);
                         view.frame = CGRectMake(SCREEN_WIDTH - SHRINKMODEWIDTH, 10, SHRINKMODEWIDTH, SHRINKMODEHEIGHT);}
                     completion:^(BOOL finished){
                         [self showShrinkView];
                         self.bottomPanel.hidden = YES;
                         self.topPanel.hidden = YES;
                     }];
}


- (void) onViewTaped:(UITapGestureRecognizer*)recognizer
{
    if (self.isFullScreenMode)
    {
        return;
    }
    
    self.isFullScreenMode = YES;
    [self changeToFullModelNeedAnimate:self.view];
}

- (void)changeToFullModelNeedAnimate:(UIView*)view
{
    CGFloat animateTime = 1.0;
    [UIView animateWithDuration:animateTime
                     animations:^{
                         view.transform = self.oriTransform;
                         view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);}
                     completion:^(BOOL finished) {
                         [view setNeedsLayout];
                         [self showGalleryView];
                         self.bottomPanel.hidden = NO;
                         self.topPanel.hidden = NO;
                     }];
}

- (void) onViewPan:(UIPanGestureRecognizer*)recognizer
{
    if (self.isFullScreenMode)
    {
        return;
    }
    
    [self onPanView:recognizer];
}

- (void)onPanView:(UIPanGestureRecognizer*)pan
{
    if (!self.parentViewController)
    {
        return;
    }
    
    UIView * parentView = self.parentViewController.view;
    CGPoint center = pan.view.center;
    
    CGPoint translation = [pan translationInView:parentView];
    
    pan.view.center = CGPointMake(center.x + translation.x, center.y + translation.y);
    [pan setTranslation:CGPointZero inView:parentView];
    
    if (pan.state != UIGestureRecognizerStateEnded) {
        return;
    }
    
    CGPoint velocity = [pan velocityInView:parentView];
    CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
    CGFloat slideMult = magnitude / 500;
    
    float slideFactor = 0.1 * slideMult;
    CGPoint finalPoint = CGPointMake(center.x + (velocity.x * slideFactor), center.y + (velocity.y * slideFactor));
    
    finalPoint.x = MIN(MAX(finalPoint.x, SHRINKMODEWIDTH / 2.0),parentView.bounds.size.width - SHRINKMODEWIDTH / 2.0);
    finalPoint.y = MIN(MAX(finalPoint.y, SHRINKMODEHEIGHT / 2.0),parentView.bounds.size.height - SHRINKMODEHEIGHT / 2.0);
    
    [UIView animateWithDuration:slideFactor*2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         pan.view.center = finalPoint;
                     }
                     completion:nil];
}

#pragma mark - AnnoFloatBarView
- (AnnoFloatBarView*)annoFloatBarView
{
    if (!_annoFloatBarView)
    {
        _annoFloatBarView = [[AnnoFloatBarView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-150,self.view.frame.size.width, 50)];
        _annoFloatBarView.delegate = self;
    }
    
    return _annoFloatBarView;
}

- (BOOL)onClickStartAnnotate
{
    MobileRTCAnnotationService *ms = [[MobileRTC sharedRTC] getAnnotationService];
    
    MobileRTCAnnotationError ret = MobileRTCAnnotationError_Failed;
    if (ms)
    {
        if ([ms isPresenter])
        {
           ret = [ms startAnnotationWithSharedView:self.localShareVC.view];
        }
        else
        {
            ret = [ms startAnnotationWithSharedView:self.remoteShareVC.shareView];
        }
    }
    
    return ret == MobileRTCAnnotationError_Successed ? YES : NO;
}

- (BOOL)onClickStopAnnotate
{
    MobileRTCAnnotationService *ms = [[MobileRTC sharedRTC] getAnnotationService];
    return [ms stopAnnotation];
}
@end
