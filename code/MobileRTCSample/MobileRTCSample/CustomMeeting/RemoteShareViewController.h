//
//  RemoteShareViewController.h
//  MobileRTCSample
//
//  Created by chaobai on 27/11/2017.
//  Copyright © 2017 Zoom Video Communications, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RemoteShareViewController : UIViewController

@property (assign, nonatomic) NSUInteger activeShareID;

@property (strong, nonatomic) MobileRTCActiveShareView* shareView;

- (void)updateShareView;

@end
