//
//  BaseNavigationController.m
//  MobileRTCSample
//
//  Created by Byron Zhang on 2020/8/27.
//  Copyright © 2020 Zoom Video Communications, Inc. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [[MobileRTC sharedRTC] willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [[MobileRTC sharedRTC] viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
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
