//
//  AppDelegate.m
//  ZoomSDKSample
//
//  Created by Robust Hu on 3/17/14.
//  Copyright (c) 2014 Zoom Video Communications, Inc. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

#define kZoomSDKAppKey      @""
#define kZoomSDKAppSecret   @""
#define kZoomSDKDomain      @""

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"%@", paths[0]);
    
    MainViewController *mainVC = [[[MainViewController alloc] init] autorelease];
    UINavigationController *navVC = [[[UINavigationController alloc] initWithRootViewController:mainVC] autorelease];
    navVC.navigationBarHidden = YES;
    
    self.window.rootViewController = navVC;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    NSLog(@"MobileRTC Version: %@", [[MobileRTC sharedRTC] mobileRTCVersion]);
    
    //1. Set MobileRTC Domain
    [[MobileRTC sharedRTC] setMobileRTCDomain:kZoomSDKDomain];
//    //2. Set MobileRTC Resource Bundle path
//    //Note: This step is optional, If MobileRTCResources.bundle is included in other bundle/framework, use this method to set the path of MobileRTCResources.bundle, or just ignore this step
//    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
//    [[MobileRTC sharedRTC] setMobileRTCResPath:bundlePath];
    //3. Set Root Navigation Controller
    //Note: This step is optional, If app’s rootViewController is not a UINavigationController, just ignore this step.
    [[MobileRTC sharedRTC] setMobileRTCRootController:navVC];
    //4. ZoomSDK Authorize
    [self sdkAuth];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    [[MobileRTC sharedRTC] appWillResignActive];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[MobileRTC sharedRTC] appDidEnterBackgroud];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [[MobileRTC sharedRTC] appDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[MobileRTC sharedRTC] appWillTerminate];
}

// For iOS 4.2+ support
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return YES;
}

#pragma mark - Auth Delegate

- (void)sdkAuth
{
    MobileRTCAuthService *authService = [[MobileRTC sharedRTC] getAuthService];
    if (authService)
    {
        authService.delegate = self;
        
        authService.clientKey = kZoomSDKAppKey;
        authService.clientSecret = kZoomSDKAppSecret;
        
        [authService sdkAuth];
    }
}

- (void)onMobileRTCAuthReturn:(MobileRTCAuthError)returnValue
{
    NSLog(@"onMobileRTCAuthReturn %d", returnValue);
    
    if (returnValue != MobileRTCAuthError_Success)
    {
        NSString *message = [NSString stringWithFormat:NSLocalizedString(@"SDK authentication failed, error code: %zd", @""), returnValue];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:NSLocalizedString(@"Retry", @""), nil];
        [alert show];
    }
}

- (void)onMobileRTCLoginReturn:(NSInteger)returnValue
{
    NSLog(@"onMobileRTCLoginReturn result=%zd", returnValue);
    
    MobileRTCPremeetingService *service = [[MobileRTC sharedRTC] getPreMeetingService];
    if (service)
    {
        service.delegate = self;
    }
}

- (void)onMobileRTCLogoutReturn:(NSInteger)returnValue
{
    NSLog(@"onMobileRTCLogoutReturn result=%zd", returnValue);
}

#pragma mark - AlertView Delegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != alertView.cancelButtonIndex)
    {
        [self performSelector:@selector(sdkAuth) withObject:nil afterDelay:0.f];
    }
}

#pragma mark - Premeeting Delegate


- (void)sinkSchedultMeeting:(PreMeetingError)result meetingNumber:(unsigned long long)number
{
    NSLog(@"sinkSchedultMeeting result: %zd, meetingNumber:%zd", result, number);
}

- (void)sinkEditMeeting:(PreMeetingError)result
{
    NSLog(@"sinkEditMeeting result: %zd", result);
}

- (void)sinkDeleteMeeting:(PreMeetingError)result
{
    NSLog(@"sinkDeleteMeeting result: %zd", result);
}

- (void)sinkListMeeting:(PreMeetingError)result withMeetingItems:(NSArray*)array
{
    NSLog(@"sinkListMeeting result: %zd  items: %@", result, array);
}

@end
