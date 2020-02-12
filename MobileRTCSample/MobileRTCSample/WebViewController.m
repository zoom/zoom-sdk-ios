//
//  WebViewController.m
//  MobileRTCSample
//
//  Created by Murray Li on 2019/6/21.
//  Copyright © 2019 Zoom Video Communications, Inc. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIScrollViewDelegate>

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.webView.scrollView.delegate = self;
    NSURL *url = [NSURL URLWithString:@"https://zoom.us"];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:req];
    [self.view addSubview:self.webView];
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view
{
    NSLog(@"========>BeginZooming");
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if([ms isStartingShare])
    {
        BOOL ret = [[[MobileRTC sharedRTC] getMeetingService] suspendSharing:YES];
        NSLog(@"========>%d",ret);
    }
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale
{
    NSLog(@"========>EndZooming");
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if([ms isStartingShare])
    {
        BOOL ret = [[[MobileRTC sharedRTC] getMeetingService] suspendSharing:NO];
        NSLog(@"========>%d",ret);
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"========>BeginDecelerating");
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if([ms isStartingShare])
    {
        BOOL ret = [[[MobileRTC sharedRTC] getMeetingService] suspendSharing:YES];
        NSLog(@"========>%d",ret);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"========>EndDecelerating");
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if([ms isStartingShare])
    {
        BOOL ret = [[[MobileRTC sharedRTC] getMeetingService] suspendSharing:NO];
        NSLog(@"========>%d",ret);
    }
}

- (void)dealloc
{
    self.webView = nil;
    [super dealloc];
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
