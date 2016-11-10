//
//  ViewController.m
//  ZoomSDKSample
//
//  Created by Robust Hu on 16/5/18.
//  Copyright © 2016年 Zoom Video Communications, Inc. All rights reserved.
//

#import "MainViewController.h"
#import "IntroViewController.h"
#import "InviteViewController.h"
#import "SplashViewController.h"
#import "SettingsViewController.h"
#import <MobileRTC/MobileRTC.h>
//#import "MBProgressHUD.h"

#define RGBCOLOR(r, g, b)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

#define BUTTON_FONT [UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0]

#define kSDKUserID      @""
#define kSDKUserName    @""
#define kSDKUserToken   @""
#define kSDKMeetNumber  @""

@interface MainViewController ()<UIAlertViewDelegate, UIActionSheetDelegate, MobileRTCMeetingServiceDelegate>

@property (retain, nonatomic) UIButton *meetButton;
@property (retain, nonatomic) UIButton *joinButton;

@property (retain, nonatomic) IntroViewController  *introVC;
@property (retain, nonatomic) SplashViewController *splashVC;

@property (retain, nonatomic) UIButton *shareButton;
@property (retain, nonatomic) UIButton *expandButton;
@property (retain, nonatomic) UIButton *settingButton;

@property (assign, nonatomic) BOOL isSharing;

@end

@implementation MainViewController

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
    
    [self.view addSubview:self.expandButton];
    self.expandButton.hidden = YES;
	
    [self.view addSubview:self.shareButton];
    self.shareButton.hidden = YES;
    
    [self.view addSubview:self.settingButton];
//    self.settingButton.hidden = YES;
    
//    //For Enable/Disable Copy URL
//    [ZoomSDKInviteHelper sharedInstance].disableCopyURL = YES;
    
//    //For Enable/Disable Invite by Message
//    [ZoomSDKInviteHelper sharedInstance].disableInviteSMS = YES;
    
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
    
    _meetButton.frame = CGRectMake(bounds.size.width/2-btnWidth-padding/2, bounds.size.height-1.5*padding-btnHeight, btnWidth, btnHeight);
    _joinButton.frame = CGRectMake(bounds.size.width/2+padding/2, bounds.size.height-1.5*padding-btnHeight, btnWidth, btnHeight);
    
    _expandButton.frame = CGRectMake(bounds.size.width-button1-padding, bounds.size.height-button1-padding, button1, button1);
    
    _settingButton.frame = CGRectMake(bounds.size.width-button2-padding, 1.5*padding, button2, button2);
}

#pragma mark - Sub Views

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
        
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"App Share Meeting", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self startMeeting:YES];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Zoom Meeting", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self startMeeting:NO];
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Select Meeting Type", @"") delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"") destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"App Share Meeting", @""), NSLocalizedString(@"Zoom Meeting", @""), nil];
        
        [sheet showInView:self.view];
    }
}

- (void)onJoinaMeeting:(id)sender
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if (!ms)
    {
        return;
    }
    
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
    _isSharing = !_isSharing;
    
    UIView *shareView = _isSharing ? self.introVC.view : self.splashVC.view;
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    [ms appShareWithView:shareView];
    
    UIImage *image = [UIImage imageNamed:_isSharing?@"icon_pause":@"icon_resume"];
    [self.shareButton setImage:image forState:UIControlStateNormal];
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
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [self presentViewController:nav animated:YES completion:NULL];
    
    [nav release];
    [vc release];
}

#pragma mark - Start/Join Meeting

- (void)startMeeting:(BOOL)appShare
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if (ms)
    {
#if 0
        //customize meeting title
        [ms customizeMeetingTitle:@"Sample Meeting Title"];
#endif
        
        ms.delegate = self;
        //If App share meeting is expected, please set kMeetingParam_IsAppShare to YES, or just remove this parameter.
        
        //For API User, the user type should be ZoomSDKUserType_APIUser.
        NSDictionary *paramDict = @{kMeetingParam_UserID:kSDKUserID,
                                    kMeetingParam_UserToken:kSDKUserToken,
                                    kMeetingParam_UserType:@(MobileRTCUserType_APIUser),
                                    kMeetingParam_Username:kSDKUserName,
                                    kMeetingParam_MeetingNumber:kSDKMeetNumber,
                                    kMeetingParam_IsAppShare:@(appShare),
                                    //kMeetingParam_ParticipantID:@"111"
                                    };
        
//        //For login user start scheduled meeting, user type can be ignored
//        NSDictionary *paramDict = @{
//                                    //kMeetingParam_UserType:@(ZoomSDKUserType_ZoomUser),
//                                    kMeetingParam_MeetingNumber:kSDKMeetNumber,
//                                    //kMeetingParam_IsAppShare:@(YES)
//                                    };
//
//        //For login user start instant meeting, user type can be ignored
//        NSDictionary *paramDict = @{
//                                    //kMeetingParam_UserType:@(ZoomSDKUserType_ZoomUser),
//                                    //kMeetingParam_IsAppShare:@(YES)
//                                    };
        
        MobileRTCMeetError ret = [ms startMeetingWithDictionary:paramDict];
        
        NSLog(@"onMeetNow ret:%d", ret);
    }
}

- (void)joinMeeting:(NSString*)meetingNo withPassword:(NSString*)pwd
{
    if (![meetingNo length])
        return;

    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if (ms)
    {
        ms.delegate = self;
        
        //For Join a meeting with password
        NSDictionary *paramDict = @{
                                    kMeetingParam_Username:kSDKUserName,
                                    kMeetingParam_MeetingNumber:meetingNo,
                                    kMeetingParam_MeetingPassword:pwd,
                                    //kMeetingParam_ParticipantID:@"111"
                                    };
//            //For Join a meeting
//            NSDictionary *paramDict = @{
//                                        kMeetingParam_Username:kSDKUserName,
//                                        kMeetingParam_MeetingNumber:meetingNo,
//                                        kMeetingParam_MeetingPassword:pwd,
//                                        //kMeetingParam_ParticipantID:@"111"
//                                        };
        
        MobileRTCMeetError ret = [ms joinMeetingWithDictionary:paramDict];
        
        NSLog(@"onJoinaMeeting ret:%d", ret);
    }
}

#pragma mark - AlertView/ActionSheet Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
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
}

#pragma mark - Meeting Service Delegate

- (void)onMeetingReturn:(MobileRTCMeetError)error internalError:(NSInteger)internalError
{
    NSLog(@"onMeetingReturn:%d, internalError:%zd", error, internalError);
}

- (void)onMeetingError:(NSInteger)error message:(NSString*)message
{
    NSLog(@"onMeetingError:%zd, message:%@", error, message);
}

- (void)onMeetingStateChange:(MobileRTCMeetingState)state
{
    NSLog(@"onMeetingStateChange:%d", state);
    
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    BOOL inAppShare = [ms isDirectAppShareMeeting] && (state == MobileRTCMeetingState_InMeeting);
    self.expandButton.hidden = !inAppShare;
    self.shareButton.hidden = !inAppShare;
    self.meetButton.hidden = inAppShare;
    self.joinButton.hidden = inAppShare;
    
    if (state != MobileRTCMeetingState_InMeeting)
    {
        self.isSharing = NO;
    }
    
#if 1
    if (state == MobileRTCMeetingState_InMeeting)
    {
        //For customizing the content of Invite by SMS
        NSString *meetingID = [[MobileRTCInviteHelper sharedInstance] meetingID];
        NSString *smsMessage = [NSString stringWithFormat:NSLocalizedString(@"Please join meeting with ID: %@", @""), meetingID];
        [[MobileRTCInviteHelper sharedInstance] setInviteSMS:smsMessage];
        
        //For customizing the content of Copy URL
        NSString *joinURL = [[MobileRTCInviteHelper sharedInstance] joinMeetingURL];
        NSString *copyURLMsg = [NSString stringWithFormat:NSLocalizedString(@"Meeting URL: %@", @""), joinURL];
        [[MobileRTCInviteHelper sharedInstance] setInviteCopyURL:copyURLMsg];
    }
#endif
    
#if 0
    //For adding customize view above the meeting view
    if (state == ZoomSDKMeetingState_InMeeting)
    {
        MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
        UIView *v = [ms meetingView];
        
        UIView *sv = [[UIView alloc] initWithFrame:CGRectMake(30, 100, 50, 50)];
        sv.backgroundColor = [UIColor redColor];
        [v addSubview:sv];
        [sv release];
    }
    
#endif
}

- (void)onMeetingReady
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if ([ms isDirectAppShareMeeting])
    {
        if ([ms isStartingShare] || [ms isViewingShare])
        {
            NSLog(@"There exist an ongoing share");
            [ms showMobileRTCMeeting:nil];
            return;
        }
        
        BOOL ret = [ms startAppShare];
        NSLog(@"Start App Share... ret:%zd", ret);
    }
}

- (void)onAppShareSplash
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if (ms)
    {
        [ms appShareWithView:self.splashVC.view];
        
        [self.shareButton setImage:[UIImage imageNamed:@"icon_resume"] forState:UIControlStateNormal];
        self.isSharing = NO;
    }
}

- (void)onClickedShareButton
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if (ms)
    {
        if ([ms isStartingShare] || [ms isViewingShare])
        {
            NSLog(@"There exist an ongoing share");
            return;
        }

        [ms hideMobileRTCMeeting:^(void){
            [ms startAppShare];
        }];
    }
}

- (void)onOngoingShareStopped
{
    NSLog(@"There does not exist ongoing share");
//    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
//    if (ms)
//    {
//        [ms startAppShare];
//    }
}

#if 0
- (void)onJBHWaitingWithCmd:(JBHCmd)cmd
{
    switch (cmd) {
        case JBHCmd_Show:
        {
            UIViewController *vc = [UIViewController new];
            
            NSString *meetingID = [ZoomSDKInviteHelper sharedInstance].meetingID;
            vc.title = meetingID;
            
            UIBarButtonItem *leaveItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Leave", @"") style:UIBarButtonItemStylePlain target:self action:@selector(onLeave:)];
            [vc.navigationItem setRightBarButtonItem:leaveItem];
            
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            nav.modalPresentationStyle = UIModalPresentationFormSheet;
            [self presentViewController:nav animated:YES completion:NULL];
        }
            break;
            
        case JBHCmd_Hide:
        default:
        {
            [self dismissViewControllerAnimated:YES completion:NULL];
        }
            break;
    }
}
#endif

#if 0
- (void)onClickedInviteButton:(UIViewController*)parentVC
{
    InviteViewController *inviteVC = [[InviteViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:inviteVC];
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [parentVC presentViewController:nav animated:YES completion:NULL];
}
#endif

#if 0
- (void)onClickedDialOut:(UIViewController*)parentVC isCallMe:(BOOL)me
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if (!ms)
        return;
    
    if ([ms isDialOutInProgress])
    {
        NSLog(@"There already exists an ongoing call");
        return;
    }
    
    NSString *callName = me ? nil : @"Dialer";
    BOOL ret = [ms dialOut:@"+866004" isCallMe:me withName:callName];
    NSLog(@"Dial out result: %zd", ret);
}

- (void)onDialOutStatusChanged:(DialOutStatus)status
{
    NSLog(@"onDialOutStatusChanged: %zd", status);
}
#endif

@end
