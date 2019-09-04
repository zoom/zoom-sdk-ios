//
//  InviteViewController.m
//  MobileRTCSample
//
//  Created by Robust Hu on 7/30/15.
//  Copyright (c) 2015 Zoom Video Communications, Inc. All rights reserved.
//

#import "InviteViewController.h"
#import <MobileRTC/MobileRTC.h>

@interface InviteViewController ()

@property (retain, nonatomic) UILabel *meetingURLLabel;

@end

@implementation InviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cancel", @"") style:UIBarButtonItemStyleBordered target:self action:@selector(onCancel:)];
    [self.navigationItem setLeftBarButtonItem:cancelItem];
    
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Pause/Resume", @"") style:UIBarButtonItemStyleBordered target:self action:@selector(onDone:)];
    [self.navigationItem setRightBarButtonItem:doneItem];
    
    NSString *meetingNumber = [MobileRTCInviteHelper sharedInstance].ongoingMeetingNumber;
    self.title = meetingNumber;
    
    [self.view addSubview:self.meetingURLLabel];
    NSString *meetingURL = [MobileRTCInviteHelper sharedInstance].joinMeetingURL;
    self.meetingURLLabel.text = meetingURL;
    
    
    NSLog(@"meeting password: %@", [MobileRTCInviteHelper sharedInstance].meetingPassword);
    NSLog(@"raw meeting password: %@", [MobileRTCInviteHelper sharedInstance].rawMeetingPassword);
    NSLog(@"invite email subject: %@", [MobileRTCInviteHelper sharedInstance].inviteEmailSubject);
    NSLog(@"invite email content: %@", [MobileRTCInviteHelper sharedInstance].inviteEmailContent);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UILabel*)meetingURLLabel
{
    if (!_meetingURLLabel)
    {
        _meetingURLLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _meetingURLLabel.numberOfLines = 0;
        _meetingURLLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _meetingURLLabel;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.meetingURLLabel.frame = self.view.bounds;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)onCancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)onDone:(id)sender
{
    BOOL isNoAudio = ([[[MobileRTC sharedRTC] getMeetingService] myAudioType] == MobileRTCAudioType_None);
    [[[MobileRTC sharedRTC] getMeetingService] connectMyAudio:isNoAudio];
}

@end
