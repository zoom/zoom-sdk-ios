//
//  SDKAuthPresenter+authDelegate.m
//  MobileRTCSample
//
//  Created by Murray Li on 2018/11/21.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import "SDKAuthPresenter+AuthDelegate.h"

@implementation SDKAuthPresenter (AuthDelegate)

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

@end
