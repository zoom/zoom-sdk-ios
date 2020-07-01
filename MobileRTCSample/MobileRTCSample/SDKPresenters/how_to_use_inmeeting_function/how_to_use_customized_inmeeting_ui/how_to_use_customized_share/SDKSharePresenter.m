//
//  SDKSharePresenter.m
//  MobileRTCSample
//
//  Created by Zoom Video Communications on 2018/11/20.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import "SDKSharePresenter.h"

@implementation SDKSharePresenter

- (void)startOrStopAppShare
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if (ms) {
        if (ms.isStartingShare) {
            [ms stopAppShare];
        } else {
            [ms startAppShare];
        }
    }
}

- (void)appShareWithView:(UIView *)view
{
    [[[MobileRTC sharedRTC] getMeetingService] appShareWithView:view];
}

@end
