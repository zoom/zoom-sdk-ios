//
//  ViewController.m
//  MobileRTCSample
//
//  Created by Robust Hu on 16/5/18.
//  Copyright © 2016年 Zoom Video Communications, Inc. All rights reserved.
//

#import "MainViewController.h"
#import "SettingsViewController.h"
#import <MobileRTC/MobileRTC.h>
#import "SDKStartJoinMeetingPresenter.h"
#import "MeetingSettingsViewController.h"

//#define kEnableSMSService

@interface MainViewController ()<UIAlertViewDelegate, UIActionSheetDelegate, MobileRTCMeetingServiceDelegate,MobileRTCMeetingShareActionItemDelegate
#if kEnableSMSService
, MobileRTCSMSServiceDelegate
#endif
>

@property (assign, nonatomic) NSTimer  *clockTimer;

@property (retain, nonatomic) SDKStartJoinMeetingPresenter *presenter;

#if kEnableSMSService
@property (retain, nonatomic) MobileRTCVerifySMSHandler *verifyHandler;
#endif
@end

@implementation MainViewController
{
    UIView *snapshotView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    self.meetButton = nil;
    self.joinButton = nil;
    self.presenter = nil;
    
    [[MobileRTC sharedRTC] getMeetingService].customizedUImeetingDelegate = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.meetButton];
    [self.view addSubview:self.joinButton];
    
    [self showIntroView];
    [self showSplashView];
    [self showWebView];
    
    [self.view addSubview:self.expandButton];
    self.expandButton.hidden = YES;
	
    [self.view addSubview:self.shareButton];
    self.shareButton.hidden = YES;
    
    [self.view addSubview:self.settingButton];
//    self.settingButton.hidden = YES;
    
//    //For Enable/Disable Copy URL
//    [MobileRTCInviteHelper sharedInstance].disableCopyURL = YES;
    
//    //For Enable/Disable Invite by Message
//    [MobileRTCInviteHelper sharedInstance].disableInviteSMS = YES;
    
//    MBProgressHUD* hud = [[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:hud];
//    hud.labelText =@"Initializing...";
//    hud.square = YES;
//    [hud showAnimated:YES whileExecutingBlock:^{
//        sleep(2);
//    } completionBlock:^{
//        [hud removeFromSuperview];
//    }];

}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //for bug that there exist 20 pixels in the bottom while leaving meeting quickly
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}

- (void)viewDidLayoutSubviews
{
    CGRect bounds = self.view.bounds;
    
#define padding 20
#define button1 50
#define button2 30

    CGFloat btnWidth = MIN(floorf((bounds.size.width - 3 * padding)/2), 160);
    CGFloat btnHeight = 46;
    
    CGFloat safeAreaTop = 0.0f;
    CGFloat safeAreaBottom = 0.0f;
    if(fabs(bounds.size.height - 812.0f) < 0.01f) {
        safeAreaTop = 44.0f;
        safeAreaBottom = 34.0f;
    }

    _meetButton.frame = CGRectMake(bounds.size.width/2-btnWidth-padding/2, bounds.size.height-1.5*padding -btnHeight - safeAreaBottom, btnWidth, btnHeight);
    _joinButton.frame = CGRectMake(bounds.size.width/2+padding/2, bounds.size.height-1.5*padding-btnHeight - safeAreaBottom, btnWidth, btnHeight);
    
    _expandButton.frame = CGRectMake(bounds.size.width-button1-padding, bounds.size.height-button1 -padding - safeAreaBottom, button1, button1);
    
    _settingButton.frame = CGRectMake(bounds.size.width-button2-padding, 1.5*padding + safeAreaTop, button2, button2);
}

- (SDKStartJoinMeetingPresenter *)presenter
{
    if (!_presenter)
    {
        _presenter = [[SDKStartJoinMeetingPresenter alloc] init];
        _presenter.mainVC = self;
    }
    
    return _presenter;
}

#pragma mark - Sub Views
- (void)showIntroView
{
    IntroViewController *vc = [IntroViewController new];
    self.introVC = vc;
    
    [self addChildViewController:self.introVC];
    [self.view insertSubview:self.introVC.view atIndex:0];
    [self.introVC didMoveToParentViewController:self];
    
    self.introVC.view.frame = self.view.bounds;
}

- (void)showSplashView
{
    SplashViewController *vc = [SplashViewController new];
    self.splashVC = vc;
    
    [self addChildViewController:self.splashVC];
    [self.view insertSubview:self.splashVC.view atIndex:0];
    [self.splashVC didMoveToParentViewController:self];
    
    self.splashVC.view.frame = self.view.bounds;
}

- (void)showWebView
{
    WebViewController *vc = [WebViewController new];
    self.webVC = vc;
    
    [self addChildViewController:self.webVC];
    [self.view insertSubview:self.webVC.view atIndex:0];
    [self.webVC didMoveToParentViewController:self];
    
    self.webVC.view.frame = self.view.bounds;
}

- (UIButton*)meetButton
{
    if (!_meetButton)
    {
        _meetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_meetButton setTitle:NSLocalizedString(@"Meet Now", @"") forState:UIControlStateNormal];
        [_meetButton setTitleColor:RGBCOLOR(45, 140, 255) forState:UIControlStateNormal];
        _meetButton.titleLabel.font = BUTTON_FONT;
        [_meetButton addTarget:self action:@selector(onMeetNow:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _meetButton;
}

- (UIButton*)joinButton
{
    if (!_joinButton)
    {
        _joinButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_joinButton setTitle:NSLocalizedString(@"Join a Meeting", @"") forState:UIControlStateNormal];
        [_joinButton setTitleColor:RGBCOLOR(45, 140, 255) forState:UIControlStateNormal];
        _joinButton.titleLabel.font = BUTTON_FONT;
        [_joinButton addTarget:self action:@selector(onJoinaMeeting:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _joinButton;
}

- (UIButton*)shareButton
{
    if (!_shareButton)
    {
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareButton.frame = CGRectMake(20, 30, button2, button2);
        [_shareButton setImage:[UIImage imageNamed:@"icon_resume"] forState:UIControlStateNormal];
        [_shareButton addTarget:self action:@selector(onShareBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _shareButton;
}

- (UIButton*)expandButton
{
    if (!_expandButton)
    {
        _expandButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _expandButton.frame = CGRectMake(0, 0, button1, button1);
        [_expandButton setImage:[UIImage imageNamed:@"icon_share_app"] forState:UIControlStateNormal];
        [_expandButton addTarget:self action:@selector(onExpand:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _expandButton;
}


- (UIButton*)settingButton
{
    if (!_settingButton)
    {
        _settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _settingButton.frame = CGRectMake(0, 0, button2, button2);
        [_settingButton setImage:[UIImage imageNamed:@"icon_setting"] forState:UIControlStateNormal];
        [_settingButton addTarget:self action:@selector(onSettings:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _settingButton;
}

#pragma mark - action -
- (void)onMeetNow:(id)sender
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if (!ms)
    {
        return;
    }

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Select Meeting Type", @"")
                                                                                 message:nil
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        if ([[[MobileRTC sharedRTC] getMeetingSettings] enableCustomMeeting])
        {
            BOOL enbleRawdataUI = [[NSUserDefaults standardUserDefaults] boolForKey:Raw_Data_UI_Enable];
            
            if (!enbleRawdataUI) {
                [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Custom Meeting", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    //                MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
                    //                if (ms)
                    //                {
                    //                    ms.customizedUImeetingDelegate = self;
                    //                }
                    [self startMeeting:NO];
                }]];
            } else {
                if (enbleRawdataUI) {
                    [alertController addAction:[UIAlertAction actionWithTitle:@"Rawdata UI" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        [self startMeeting:NO];
                    }]];
                }
            }
        }
        else
        {
            [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"App Share Meeting", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self startMeeting:YES];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Zoom Meeting", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self startMeeting:NO];
            }]];
        }
        
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Select Meeting Type", @"") delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"") destructiveButtonTitle:nil otherButtonTitles:nil];
        if ([[[MobileRTC sharedRTC] getMeetingSettings] enableCustomMeeting])
        {
            [sheet addButtonWithTitle:NSLocalizedString(@"Custom Meeting", @"")];
        }
        else
        {
            [sheet addButtonWithTitle:NSLocalizedString(@"App Share Meeting", @"")];
            [sheet addButtonWithTitle:NSLocalizedString(@"Zoom Meeting", @"")];
        }
        
        [sheet showInView:self.view];
    }
}

- (void)onJoinaMeeting:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Please input the meeting number", @"") delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"") otherButtonTitles:NSLocalizedString(@"OK", @""), nil];
    
    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [alert textFieldAtIndex:0].placeholder = @"#########";
    [alert textFieldAtIndex:0].keyboardType = UIKeyboardTypeNumberPad;
    
    [alert show];
    [alert release];
}

- (void)onLeave:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^(void){
        
        MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
        if (ms)
        {
            [ms leaveMeetingWithCmd:LeaveMeetingCmd_Leave];
        }
    }];
}

- (void)onShareBtn:(id)sender
{
    _isSharingWebView = !_isSharingWebView;
 
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if (_isSharingWebView)
    {
        if ([ms isDirectAppShareMeeting]) {
            [self.view insertSubview:self.webVC.view aboveSubview:self.introVC.view];
            
            [ms appShareWithView:self.webVC.webView];
        }
    }
    else
    {
        [self.view insertSubview:self.introVC.view aboveSubview:self.webVC.view];
        [ms appShareWithView:self.splashVC.view];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIImage *image = [UIImage imageNamed:_isSharingWebView?@"icon_pause":@"icon_resume"];
        [self.shareButton setImage:image forState:UIControlStateNormal];
    });
}

- (void)onExpand:(id)sender
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if (ms)
    {
        [ms showMobileRTCMeeting:^(void){
            [ms stopAppShare];
        }];
    }
}

- (void)onSettings:(id)sender
{
    MobileRTCMeetingSettings *settings = [[MobileRTC sharedRTC] getMeetingSettings];
    if (!settings)
        return;
    
    SettingsViewController *vc = [[SettingsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [self presentViewController:nav animated:YES completion:NULL];
    
    [nav release];
    [vc release];
}

#pragma mark - Start/Join Meeting
- (void)startMeeting:(BOOL)appShare
{
    [self.presenter startMeeting:appShare rootVC:self];
}

- (void)joinMeeting:(NSString*)meetingNo withPassword:(NSString*)pwd
{
    if (![meetingNo length])
        return;
    [self.presenter joinMeeting:meetingNo withPassword:pwd rootVC:self];
}

#pragma mark - AlertView/ActionSheet Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"alertView.tag == %ld",alertView.tag);
    if (alertView.tag == 10022 && self.joinMeetingBlock)
    {
        NSString *name = [alertView textFieldAtIndex:0].text;
        NSString *pwd = [alertView textFieldAtIndex:1].text;
        BOOL cancel = (buttonIndex == alertView.cancelButtonIndex);
        
        self.joinMeetingBlock(name, pwd, cancel);
        self.joinMeetingBlock = nil;
        return;
    }
#if kEnableSMSService
    if (alertView.tag == 10023)
    {
        NSString *verifyCode = [alertView textFieldAtIndex:0].text;
        BOOL cancel = (buttonIndex == alertView.cancelButtonIndex);
        if (!cancel && verifyCode.length > 0) {
            if (![self.verifyHandler verify:@"" phoneNumber:@"" andVerifyCode:@""]) {
                // retry to get verify handle again
            }
        } else {
            [self.verifyHandler cancelAndLeaveMeeting];
        }
        return;
    }
#endif
    
    if (buttonIndex != alertView.cancelButtonIndex)
    {
        NSString *meetingNo = [alertView textFieldAtIndex:0].text;
        NSString *meetingPwd = [alertView textFieldAtIndex:1].text;
        
        [self joinMeeting:meetingNo withPassword:meetingPwd];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:NSLocalizedString(@"App Share Meeting", @"")])
    {
        [self startMeeting:YES];
    }
    else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:NSLocalizedString(@"Zoom Meeting", @"")])
    {
        [self startMeeting:NO];
    }
    else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:NSLocalizedString(@"Custom Meeting", @"")])
    {
        [self startMeeting:NO];
    }
}

#pragma mark - Timer

- (void)startClockTimer
{
    NSTimeInterval interval = 1.0;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(handleClockTimer:) userInfo:nil repeats:YES];
    self.clockTimer = timer;
}

- (void)stopClockTimer
{
    if ([self.clockTimer isValid])
    {
        [self.clockTimer invalidate];
        self.clockTimer = nil;
    }
}

- (void)handleClockTimer:(NSTimer *)theTimer
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    MobileRTCNetworkQuality sendQuality = [ms queryNetworkQuality:MobileRTCComponentType_VIDEO withDataFlow:YES];
    MobileRTCNetworkQuality receiveQuality = [ms queryNetworkQuality:MobileRTCComponentType_VIDEO withDataFlow:NO];
    NSLog(@"Query Network Data [sending: %@, receiving: %@]...", @(sendQuality), @(receiveQuality));
}

#if kEnableSMSService
#pragma mark - sms service notification -
- (void)onNeedRealNameAuth:(NSString *)bindPhoneUrl signupUrl:(NSString *)signupUrl
{
    NSLog(@"bindPhoneUrl:%@, signupUrl: %@", bindPhoneUrl, signupUrl);
}

- (void)onNeedRealNameAuth:(NSArray<MobileRTCRealNameCountryInfo *> *)supportCountryList privacyURL:(NSString *)privacyUrl retrieveHandle:(MobileRTCRetrieveSMSHandler *)handle
{
    NSLog(@"Country List:%@, privacyUrl: %@, sendSMSHandle: %@", supportCountryList, privacyUrl, handle);
    if (![handle retrieve:@"" andPhoneNumber:@""]) {
        // retry to get retrieve handle again
    }
}

- (void)onRetrieveSMSVerificationCodeResultNotification:(MobileRTCSMSServiceErr)result verifyHandle:(MobileRTCVerifySMSHandler *)handler
{
    NSLog(@"send SMS cmd result %@, verify handle %@", @(result), handler);
    self.verifyHandler = handler;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Please input verify code", @"") delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"") otherButtonTitles:NSLocalizedString(@"OK", @""), nil];
        
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        alert.tag = 10023;
        [alert show];
        [alert release];
    });
}

- (void)onVerifySMSVerificationCodeResultNotification:(MobileRTCSMSServiceErr)result
{
    NSLog(@"verify sms result %@", @(result));
}
#endif
@end



