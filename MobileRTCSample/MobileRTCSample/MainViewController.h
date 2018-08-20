//
//  ViewController.h
//  MobileRTCSample
//
//  Created by Robust Hu on 16/5/18.
//  Copyright © 2016年 Zoom Video Communications, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomMeetingViewController.h"

@interface MainViewController : UIViewController

//For User Custom In-Meeting View
@property (retain, nonatomic) CustomMeetingViewController *customMeetingVC;

@end

