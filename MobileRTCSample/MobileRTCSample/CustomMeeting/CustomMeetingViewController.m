//
//  CustomMeetingViewController.m
//  MobileRTCSample
//
//  Created by Murray Li on 2018/10/12.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import "CustomMeetingViewController.h"

@interface CustomMeetingViewController ()<UIGestureRecognizerDelegate, AnnoFloatBarViewDelegate, MobileRTCAnnotationServiceDelegate, MobileRTCWaitingRoomServiceDelegate>

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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.isShowTopBottonPanel = YES;
    
    [self initSubView];
    
    [self initGuestureRecognizer];
    
    [self disableGuestureRecognizer];
    
    MobileRTCAnnotationService *as = [[MobileRTC sharedRTC] getAnnotationService];
    MobileRTCWaitingRoomService *ws = [[MobileRTC sharedRTC] getWaitingRoomService];
    as.delegate = self;
    ws.delegate = self;
}

- (void)initSubView
{
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:self.baseView];
    
    self.vcArray = [NSMutableArray array];
    [self.vcArray addObject:self.videoVC];
    [self.vcArray addObject:self.remoteShareVC];
    [self.vcArray addObject:self.localShareVC];
    [self showVideoView];
    
    [self.view addSubview:self.thumbView];
    [self.view addSubview:self.topPanelView];
    [self.view addSubview:self.bottomPanelView];
    
    [self.view addSubview:self.annoFloatBarView];
    self.annoFloatBarView.hidden = YES;
}

- (void)uninitSubView
{
    self.baseView = nil;
    self.topPanelView = nil;
    self.bottomPanelView = nil;
    self.thumbView = nil;
    
    self.annoFloatBarView = nil;
    [self removeAllSubView];
    self.videoVC = nil;
    self.remoteShareVC = nil;
    self.localShareVC = nil;
    
    [self.vcArray removeAllObjects];
    self.vcArray = nil;
}

- (void)dealloc {
    MobileRTCAnnotationService *as = [[MobileRTC sharedRTC] getAnnotationService];
    MobileRTCWaitingRoomService *ws = [[MobileRTC sharedRTC] getWaitingRoomService];
    as.delegate = nil;
    ws.delegate = nil;
    
    [self uninitSubView];
    
    self.panGesture = nil;
    
    self.actionPresenter = nil;
    self.sharePresenter = nil;
    
    [super dealloc];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.isShowTopBottonPanel = YES;
    [self.thumbView updateFrame];
    [self.topPanelView updateFrame];
    [self.bottomPanelView updateFrame];
    [self layoutShrinkViewFrame];
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    BOOL landscape = UIInterfaceOrientationIsLandscape(orientation);
    if (landscape)
    {
        self.annoFloatBarView.frame = CGRectMake(0, self.view.frame.size.height-Bottom_Height-100, 320, 100);
    }
    else
    {
        self.annoFloatBarView.frame = CGRectMake(0, self.view.frame.size.height-Bottom_Height-self.view.frame.size.width/4-BTN_HEIGHT-100, 320, 100);
    }
}

- (void)onViewOnClick
{
    if (!self.isFullScreenMode) {
        [self onShrikTaped];
        return;
    }
    
    if (self.isShowTopBottonPanel) {
        [self.topPanelView hiddenTopPanelView];
        [self.bottomPanelView hiddenBottomPanelView];
        [self.thumbView hiddenThumbView];
    } else {
        [self.topPanelView showTopPanelView];
        [self.bottomPanelView showBottomPanelView];
        [self.thumbView showThumbView];
    }
    self.isShowTopBottonPanel = !self.isShowTopBottonPanel;
}

//- (void)showAttendeeVideo:(MobileRTCVideoView*)videoView withUserID:(NSUInteger)userID
//{
//    [videoView showAttendeeVideoWithUserID:userID];
//    CGSize size = [[[MobileRTC sharedRTC] getMeetingService] getUserVideoSize:userID];
//    if (CGSizeEqualToSize(size, CGSizeZero))
//        return;
//    [videoView setVideoAspect:MobileRTCVideoAspect_PanAndScan];
//}

- (void)updateVideoOrShare
{
    if (self.remoteShareVC.parentViewController)
    {
        [self.remoteShareVC updateShareView];
    }
    
    [self.thumbView updateThumbViewVideo];
}

- (void)updateMyAudioStatus
{
    [self.bottomPanelView updateMyAudioStatus];
}

- (void)updateMyVideoStatus
{
    [self.bottomPanelView updateMyVideoStatus];
}

- (void)updateMyShareStatus
{
    [self.bottomPanelView updateMyShareStatus];
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

- (void)showVideoView
{
    [self removeAllSubView];
    [self showSubView:self.videoVC];
}

- (void)showLocalShareView
{
    [self removeAllSubView];
    [self showSubView:self.localShareVC];
//    [[[MobileRTC sharedRTC] getMeetingService] appShareWithView:self.localShareVC.view];
    [self.sharePresenter appShareWithView:self.localShareVC.view];
    
    [self showAnnotationView];
}

- (void)showRemoteShareView
{
    [self removeAllSubView];
    [self showSubView:self.remoteShareVC];
    
    [self showAnnotationView];
}

- (void)showAnnotationView {
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    MobileRTCAnnotationService *as = [[MobileRTC sharedRTC] getAnnotationService];
    if (ms && ![ms isAnnotationOff] && [as canDoAnnotation])
    {
        self.annoFloatBarView.hidden = NO;
    }
}

- (void)hideAnnotationView {
    self.annoFloatBarView.hidden = YES;
    [self.annoFloatBarView stopAnnotate];
}

- (UIView*)baseView
{
    if (!_baseView)
    {
        _baseView = [[UIView alloc] initWithFrame:self.view.bounds];
        _baseView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _baseView;
}

- (TopPanelView *)topPanelView
{
    if (!_topPanelView)
    {
        _topPanelView = [[TopPanelView alloc] init];
        _topPanelView.shrinkButtonClickBlock = ^(void) {
            [self enableGuestureRecognizer];
            self.isFullScreenMode = NO;
            self.oriTransform = self.view.transform;
            [self changeToPIPModeNeedAnimate:self.view];
            [self initGuestureRecognizer];
        };
    }
    
    return _topPanelView;
}

- (BottomPanelView *)bottomPanelView
{
    if (!_bottomPanelView)
    {
        _bottomPanelView = [[BottomPanelView alloc] init];
    }
    
    return _bottomPanelView;
}

- (ThumbView *)thumbView
{
    if (!_thumbView)
    {
        _thumbView = [[ThumbView alloc] init];
    }
    
    return _thumbView;
}

- (VideoViewController*)videoVC
{
    if (!_videoVC)
    {
        _videoVC = [[VideoViewController alloc]init];
        _videoVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onViewOnClick)];
        [_videoVC.videoView addGestureRecognizer:tapGesture];
    }
    return _videoVC;
}

- (LocalShareViewController*)localShareVC
{
    if (!_localShareVC)
    {
        _localShareVC = [[LocalShareViewController alloc]init];
        _localShareVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onViewOnClick)];
        tapGesture.delegate = self;
        [_localShareVC.webView addGestureRecognizer:tapGesture];
    }
    return _localShareVC;
}

- (RemoteShareViewController*)remoteShareVC
{
    if (!_remoteShareVC)
    {
        _remoteShareVC = [[RemoteShareViewController alloc] init];
        _remoteShareVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onViewOnClick)];
        [_remoteShareVC.shareView addGestureRecognizer:tapGesture];
    }
    return _remoteShareVC;
}

- (SDKActionPresenter *)actionPresenter
{
    if (!_actionPresenter)
    {
        _actionPresenter = [[SDKActionPresenter alloc] init];
     
    }
    return _actionPresenter;
}

- (SDKSharePresenter *)sharePresenter
{
    if (!_sharePresenter)
    {
        _sharePresenter = [[SDKSharePresenter alloc] init];
        
    }
    return _sharePresenter;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}


#pragma mark - Shrink & Delegate

#define SHRINKMODEWIDTH (IS_IPAD ? 200 : 90)
#define SHRINKMODEHEIGHT (SHRINKMODEWIDTH*4/3)

- (void)layoutShrinkViewFrame
{
    if ( (![self isFullScreenMode] && self.panGesture.state == UIGestureRecognizerStatePossible) )
    {
        self.view.frame = CGRectMake(SCREEN_WIDTH - SHRINKMODEWIDTH-10, 30, SHRINKMODEWIDTH, SHRINKMODEHEIGHT);
    }
}

- (void)initGuestureRecognizer
{
    if (!_panGesture)
    {
        UIPanGestureRecognizer *pan =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(onViewPan:)];
        self.panGesture = pan;
        [self.view addGestureRecognizer:pan];
        [pan release];
    }
}

- (void)disableGuestureRecognizer
{
    self.panGesture.enabled = NO;
}

- (void)enableGuestureRecognizer
{
    self.panGesture.enabled = YES;
}


- (void)changeToPIPModeNeedAnimate:(UIView*)view
{
    self.thumbView.hidden = YES;
    self.bottomPanelView.hidden = YES;
    self.topPanelView.hidden = YES;
    
    CGFloat animateTime = 0.3;
    [UIView animateWithDuration:animateTime
                     animations:^{
                         view.transform = CGAffineTransformScale(view.transform, 0.2, 0.2);
                         view.frame = CGRectMake(SCREEN_WIDTH - SHRINKMODEWIDTH-10, 30, SHRINKMODEWIDTH, SHRINKMODEHEIGHT);
                     }
                     completion:^(BOOL finished){
                     }];
}


- (void) onShrikTaped
{
    if (self.isFullScreenMode)
    {
        return;
    }
    
    self.isFullScreenMode = YES;
    [self changeToFullModelNeedAnimate:self.view];
    [self disableGuestureRecognizer];
}

- (void)changeToFullModelNeedAnimate:(UIView*)view
{
    self.thumbView.hidden = NO;
    self.bottomPanelView.hidden = NO;
    self.topPanelView.hidden = NO;
    CGFloat animateTime = 0.3;
    [UIView animateWithDuration:animateTime
                     animations:^{
                         view.transform = self.oriTransform;
                         view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);}
                     completion:^(BOOL finished) {
                         [view setNeedsLayout];
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

#pragma mark - waiting room service delegate -
- (void)onWaitingRoomUserJoin:(NSUInteger)userId {
    MobileRTCWaitingRoomService *ws = [[MobileRTC sharedRTC] getWaitingRoomService];
    NSArray *arr = [ws waitingRoomList];
    MobileRTCMeetingUserInfo *userInfo = [ws waitingRoomUserInfoByID:userId];
    NSLog(@"Waiting Room: %@", arr);
    NSLog(@"userInfo: %@", userInfo);
    [ws admitToMeeting:userId];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [ws putInWaitingRoom:userId];
    });
}

- (void)onWaitingRoomUserLeft:(NSUInteger)userId {
    MobileRTCWaitingRoomService *ws = [[MobileRTC sharedRTC] getWaitingRoomService];
    MobileRTCMeetingUserInfo *userInfo = [ws waitingRoomUserInfoByID:userId];
    NSLog(@"userInfo: %@", userInfo);
}

#pragma mark - Annotation service delegate -
- (void)onAnnotationService:(MobileRTCAnnotationService *)service supportStatusChanged:(BOOL)support; {
    if (support) {
        [self showAnnotationView];
    } else {
        [self hideAnnotationView];
    }
}

#pragma mark - AnnoFloatBarView
- (AnnoFloatBarView*)annoFloatBarView
{
    if (!_annoFloatBarView)
    {
        _annoFloatBarView = [[AnnoFloatBarView alloc]initWithFrame:CGRectZero];
        _annoFloatBarView.delegate = self;
    }
    
    return _annoFloatBarView;
}

- (BOOL)onClickStartAnnotate
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    MobileRTCAnnotationService *as = [[MobileRTC sharedRTC] getAnnotationService];
    
    MobileRTCAnnotationError ret = MobileRTCAnnotationError_Failed;
    if (ms && as && ![ms isAnnotationOff] && [as canDoAnnotation])
    {
        if ([as isPresenter])
        {
            ret = [as startAnnotationWithSharedView:self.localShareVC.view];
        }
        else
        {
            ret = [as startAnnotationWithSharedView:self.remoteShareVC.shareView];
        }
    }
    
    return ret == MobileRTCAnnotationError_Successed ? YES : NO;
}

- (BOOL)onClickStopAnnotate
{
    MobileRTCAnnotationService *ms = [[MobileRTC sharedRTC] getAnnotationService];
    return [ms stopAnnotation];
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
