//
//  OpenGLViewController.m
//  MobileRTCSample
//
//  Created by Murray Li on 2019/8/6.
//  Copyright © 2019 Zoom Video Communications, Inc. All rights reserved.
//

#import "OpenGLViewController.h"
#import "TopBar.h"
#import "OpenglView.h"
#import "AudioRawDataSaveSandboxHelper.h"
#import "ControlBar.h"
#import "BottomBarView.h"

#define THUMB_WIDTH 128
#define THUMB_HEIGHT (THUMB_WIDTH*4/3)
#define kBackgroudTag       10000

@interface OpenGLViewController ()<MobileRTCVideoRawDataDelegate, MobileRTCMeetingServiceDelegate, MobileRTCAudioRawDataDelegate, BottomBarViewDelegate>
@property (strong, nonatomic) TopBar                  *topBar;
@property (strong, nonatomic) ControlBar              *controlBarView;
@property (strong, nonatomic) BottomBarView           *bottomView;

@property (nonatomic, strong) MobileRTCRenderer       *fullRender;
@property (nonatomic, strong) OpenglView              *fullView;

@property (nonatomic, strong) NSMutableArray          *renderArr;

@property (strong, nonatomic) UIButton                *switchShareBtn;

@property (nonatomic, strong) MobileRTCAudioRawDataHelper *audioRawdataHelper;
@property (nonatomic, strong) AudioRawDataSaveSandboxHelper *audioRawDataSaveSandboxHelper;
@end

@implementation OpenGLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBCOLOR(0x23, 0x23, 0x23);
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    
    [[MobileRTC sharedRTC] getMeetingService].delegate = self;
    
    self.renderArr = [NSMutableArray array];
    
    self.fullRender = [[MobileRTCRenderer alloc] initWithDelegate:self];
    self.fullView = [[OpenglView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.fullView];
    [self.fullRender subscribe:0 videoType:MobileRTCVideoType_VideoData];
    [self.renderArr addObject:self.fullRender];
    
    _topBar = [[TopBar alloc] init];
    _topBar.endOnClickBlock = ^(void) {
        [self leave];
    };
    [self.view addSubview:_topBar];
    
    [self.view addSubview:self.switchShareBtn];

    [self.view addSubview:self.bottomView];
    
    self.audioRawdataHelper = [[MobileRTCAudioRawDataHelper alloc] initWithDelegate:self];
    
    self.audioRawDataSaveSandboxHelper = [[AudioRawDataSaveSandboxHelper alloc] init];
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    self.audioRawDataSaveSandboxHelper.filePath = [NSString stringWithFormat:@"%@/audio/%@.pcm", docPath, @([[NSDate date] timeIntervalSince1970] * 1000)];
}

- (void)dealloc {
    self.fullView = nil;
    
    [self.audioRawdataHelper unSubscribe];
    self.audioRawdataHelper = nil;
    
    self.audioRawDataSaveSandboxHelper = nil;
    [super dealloc];
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.fullView.frame = self.view.bounds;
    
    [self.topBar setNeedsLayout];
    [self.controlBarView setNeedsLayout];
    [self.bottomView setNeedsLayout];
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    BOOL landscape = UIInterfaceOrientationIsLandscape(orientation);
    if (landscape) {
        if (orientation == UIInterfaceOrientationLandscapeRight && IPHONE_X) {
            self.switchShareBtn.frame = CGRectMake(SAFE_ZOOM_INSETS+10, Top_Height + 5, 180, 35);
        } else {
            self.switchShareBtn.frame = CGRectMake(8, Top_Height + 5, 180, 35);
        }
    } else {
        self.switchShareBtn.frame = CGRectMake(8, (IPHONE_X ? Top_Height + SAFE_ZOOM_INSETS : Top_Height) + 5, 180, 35);
    }
}

- (UIButton *)switchShareBtn {
    if (!_switchShareBtn) {
        _switchShareBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_switchShareBtn setTitle:@"Switch to Share" forState:UIControlStateNormal];
        _switchShareBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [_switchShareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _switchShareBtn.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        _switchShareBtn.clipsToBounds = YES;
        _switchShareBtn.layer.cornerRadius = 6;
        [_switchShareBtn addTarget:self action:@selector(switchToShare:) forControlEvents:UIControlEventTouchUpInside];
        _switchShareBtn.hidden = YES;
    }
    
    return _switchShareBtn;
}


- (ControlBar *)controlBarView {
    if (!_controlBarView) {
        _controlBarView = [[ControlBar alloc] init];
    }
    return _controlBarView;
}

- (BottomBarView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[BottomBarView alloc] initWithDelegate:self];
        _bottomView.frame = CGRectMake(0, SCREEN_HEIGHT - kTableHeight, SCREEN_WIDTH, kTableHeight);
        [self.view addSubview:_bottomView];
    }
    
    return _bottomView;
}

- (void)leave {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.fullRender unSubscribe];
    self.fullRender = nil;
    
    for (MobileRTCRenderer *render in self.renderArr) {
        [render unSubscribe];
    }
    [self.renderArr removeAllObjects];
    
    LeaveMeetingCmd cmd = [[[MobileRTC sharedRTC] getMeetingService] isMeetingHost] ? LeaveMeetingCmd_End : LeaveMeetingCmd_Leave;
    [[[MobileRTC sharedRTC] getMeetingService] leaveMeetingWithCmd:cmd];
}

// Update video to prevent stopping video in the last frame
- (void)updateVideo:(OpenglView *)openGLView userId:(NSUInteger)userId {

    if (!openGLView) {
        return;
    }
    
    if (![[[MobileRTC sharedRTC] getMeetingService] isUserVideoSending:userId]) {
        [openGLView clearFrame];
    }
}

- (OpenglView *)getBottomRenderViewByUserId:(NSUInteger)userId {
    NSArray *viewItems = [self.bottomView getThumberViewItems:userId];
    ViewItem *item = [viewItems firstObject];
    OpenglView *view = (OpenglView *)item.view;
    return view;
}

- (void)noVideofailBack {
    NSUInteger myId = [[[MobileRTC sharedRTC] getMeetingService] myselfUserID];
    [self.fullRender subscribe:myId videoType:MobileRTCVideoType_VideoData];
}

- (void)addThumberViewWithArr {
    NSMutableArray *userArray = [[NSMutableArray alloc] init];
    for (ViewItem *item in self.bottomView.viewArray) {
        [userArray addObject:[NSNumber numberWithInteger:item.userId]];
    }
    
    NSArray *userArrayInMeeting = [[[MobileRTC sharedRTC] getMeetingService] getInMeetingUserList];
    
    for (NSNumber *userInMeeting in userArrayInMeeting) {
        if (![userArray containsObject:userInMeeting]) {
            MobileRTCMeetingUserInfo *userInfo = [[[MobileRTC sharedRTC] getMeetingService] userInfoByID:[userInMeeting unsignedIntegerValue]];
            
            MobileRTCRenderer *renderer = [[MobileRTCRenderer alloc] initWithDelegate:self];
            [renderer subscribe:[userInMeeting unsignedIntegerValue] videoType:MobileRTCVideoType_VideoData];
            
            [self.renderArr addObject:renderer];
            
            OpenglView *view = [[OpenglView alloc] initWithFrame:CGRectZero];
            
            ViewItem *item = [[ViewItem alloc] init];
            item.userId = [userInMeeting unsignedIntegerValue];
            item.view = view;
            item.isActive = NO;
            item.itemName = userInfo.userName;
            item.renderer = renderer;
            
            [self.bottomView addThumberViewItem:item];
        }
    }
    
    [self.view insertSubview:self.controlBarView aboveSubview:self.bottomView];
}

#pragma mark - MobileRTCMeetingServiceDelegate

- (void)onMeetingStateChange:(MobileRTCMeetingState)state
{
    if (MobileRTCMeetingState_InMeeting == state) {
        
        [self addThumberViewWithArr];
        
        [[[MobileRTC sharedRTC] getMeetingService] connectMyAudio:YES];
        
        [self.view addSubview:self.controlBarView];
        
        [self.audioRawdataHelper subscribe];
    }
}

- (void)onSinkMeetingUserJoin:(NSUInteger)userID {
    NSLog(@"onSinkMeetingUserJoin=======>%@",@(userID));
    [self addThumberViewWithArr];
}

- (void)onSinkMeetingUserLeft:(NSUInteger)userID
{
    if (self.fullRender.userId == userID) {
        [self noVideofailBack];
    }
    for (MobileRTCRenderer *render in self.renderArr) {
        if (render.userId == userID) {
            [render unSubscribe];
        }
    }
    [self.bottomView removeThumberViewItemWithUserId:userID];
}

- (void)onSinkMeetingVideoStatusChange:(NSUInteger)userID {
    NSLog(@"onSinkMeetingVideoStatusChange=====>");

    if (userID == self.fullRender.userId) {
        [self updateVideo:self.fullView userId:userID];
    }
    
    OpenglView *openGLView = [self getBottomRenderViewByUserId:userID];
    [self updateVideo:openGLView userId:userID];
}

- (void)onMyVideoStateChange {
    NSUInteger myUseriId = [[[MobileRTC sharedRTC] getMeetingService] myselfUserID];
    
    if (myUseriId == self.fullRender.userId) {
        [self updateVideo:self.fullView userId:myUseriId];
    }
    
    OpenglView *openGLView = [self getBottomRenderViewByUserId:myUseriId];
    [self updateVideo:openGLView userId:myUseriId];

    [self.controlBarView updateMyVideoStatus];
}

- (void)onMyAudioStateChange
{
    [self.controlBarView updateMyAudioStatus];
}

- (void)onSinkMeetingActiveShare:(NSUInteger)userID
{
    NSUInteger myId = [[[MobileRTC sharedRTC] getMeetingService] myselfUserID];
    if (userID == myId) {
        return;
    }
    
    NSLog(@"onSinkMeetingActiveShare====>");
    BOOL sharing = (0 != userID); // userID ==0 stop share
    if (sharing) {
        self.switchShareBtn.tag = userID;
        
        NSArray *viewItems = [self.bottomView getThumberViewItems:userID];
        [self viewItemSelected:[viewItems firstObject]];
        [self.fullRender subscribe:userID videoType:MobileRTCVideoType_ShareData];
    } else {
        self.switchShareBtn.tag = 0;
        
        NSArray *viewItems = [self.bottomView getThumberViewItems:userID];
        [self viewItemSelected:[viewItems firstObject]];
        [self.fullRender subscribe:myId videoType:MobileRTCVideoType_VideoData];
    }
    self.switchShareBtn.hidden = YES;
}

#pragma mark - MobileRTCVideoRawDataDelegate -
- (void)onMobileRTCRender:(MobileRTCRenderer *)renderer frameRawData:(MobileRTCVideoRawData *)rawData {
    if (!rawData || !renderer) {
        return;
    }
    
//    if ([rawData canAddRef]) {
//        [rawData addRef];
//    }
    
    if ([self.fullRender isEqual:renderer]) {
        DisplayMode mode = DisplayMode_PanAndScan;
        [self.fullView displayYUV:rawData mode:mode];
    }
    
    NSArray *items = [self.bottomView getThumberViewItems:renderer.userId];
    for (ViewItem *item in items) {
        OpenglView *glView = (OpenglView *)item.view;
        if ([item.renderer isEqual:renderer]) {
            [glView displayYUV:rawData mode:DisplayMode_PanAndScan];
        }
    }
    
//    if (self.thumbRender.userId == renderer.userId) {
//        DisplayMode mode = DisplayMode_PanAndScan;
//        [self.thumbView displayYUV:rawData mode:mode];
//    }
    
//    if ([rawData canAddRef]) {
//        [rawData releaseRef];
//    }
}

#pragma mark - MobileRTCAudioRawDataDelegate -
- (void)onMobileRTCMixedAudioRawData:(MobileRTCAudioRawData *)rawData {
//    if ([rawData canAddRef]) {
//        [rawData addRef];
//    }
    
//    [self.audioRawDataSaveSandboxHelper saveAudioRawdata:rawData];
    
//        if ([rawData canAddRef]) {
//            [rawData releaseRef];
//        }
}

#pragma mark - BottomBarViewDelegate -
- (void)stopThumbViewVideo {
    for (ViewItem *item in self.bottomView.viewArray) {
        [item.renderer unSubscribe];
    }
}

- (void)startThumbViewVideo {
    NSArray <UITableViewCell *> *cellArray = self.bottomView.thumbTableView.visibleCells;
    
    for (int i = 0; i < cellArray.count; i++) {
        UITableViewCell *cell = [cellArray objectAtIndex:i];
        NSIndexPath *indexPath = [self.bottomView.thumbTableView indexPathForCell:cell];
        ViewItem *item = [self.bottomView.viewArray objectAtIndex:indexPath.row];
        [item.renderer subscribe:item.userId videoType:MobileRTCVideoType_VideoData];
    }
}

- (void)pinThumberViewItem:(ViewItem *)item {
    
    if (!item) {
        return;
    }
    
    [self.fullRender subscribe:item.userId videoType:MobileRTCVideoType_VideoData];
    [self.fullRender setRawDataResolution:MobileRTCVideoResolution_180];
    
    [self viewItemSelected:item];
    
    [self onSinkMeetingVideoStatusChange:item.userId];
    
    NSInteger shareUserId = self.switchShareBtn.tag;
    if (shareUserId) {
        self.switchShareBtn.hidden = NO;
    }
}

- (void)viewItemSelected:(ViewItem *)item {
    for (ViewItem *item in self.bottomView.viewArray) {
        item.view.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:0.5].CGColor;
    }
    
    item.view.layer.borderColor = [UIColor greenColor].CGColor;
}

- (void)switchToShare:(UIButton *)switchShareBtn {
    switchShareBtn.hidden = YES;
    NSInteger shareUserId = switchShareBtn.tag;
    
    if (!shareUserId) {
        return;
    }
    
    if (shareUserId) {
        [self.fullRender setRawDataResolution:MobileRTCVideoResolution_720];
        [self.fullRender subscribe:shareUserId videoType:MobileRTCVideoType_ShareData];
        [self updateVideo:self.fullView userId:shareUserId];
    }
    
    for (ViewItem *item in self.bottomView.viewArray) {
        if (shareUserId == item.userId) {
            [self viewItemSelected:item];
        }
    }
}

@end
