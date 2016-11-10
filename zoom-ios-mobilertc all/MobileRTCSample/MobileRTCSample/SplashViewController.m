//
//  SplashViewController.m
//  IntroTest
//
//  Created by Robust on 15/12/2.
//  Copyright © 2015年 Robust. All rights reserved.
//

#import "SplashViewController.h"

#define RGBCOLOR(r, g, b)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

#define is_iPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


@interface SplashViewController ()

@property (retain, nonatomic) UIImageView *logoImageView;

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.logoImageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.logoImageView.frame = self.view.bounds;
}

- (UIImageView*)logoImageView
{
    if (!_logoImageView)
    {
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _logoImageView.image = [UIImage imageNamed:@"icon_meet"];
        _logoImageView.contentMode = UIViewContentModeCenter;
    }
    
    return _logoImageView;
}

@end
