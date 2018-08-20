//
//  MainViewController+MeetingServiceDelegate.h
//  MobileRTCSample
//
//  Created by Robust on 2017/12/28.
//  Copyright © 2017年 Zoom Video Communications, Inc. All rights reserved.
//

#import "MainViewController.h"
#import <Mobilertc/MobileRTCMeetingDelegate.h>

@interface MainViewController (MeetingServiceDelegate) <MobileRTCMeetingServiceDelegate,MobileRTCCustomizedUIMeetingDelegate>

@end
