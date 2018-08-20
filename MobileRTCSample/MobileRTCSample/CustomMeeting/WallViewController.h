//
//  WallViewController.h
//  MobileRTCSample
//
//  Created by Robust on 2017/12/20.
//  Copyright © 2017年 Zoom Video Communications, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HorizontalTableView.h"

@interface WallViewController : UIViewController

@property (strong, nonatomic) HorizontalTableView *wallVideoView;

- (void)updateWallVideo;

@end
