//
//  ZBBMIntroViewController.m
//  ZoomBBM
//
//  Created by Robust Hu on 7/7/15.
//  Copyright (c) 2015 zoom.us. All rights reserved.
//

#import "IntroViewController.h"

#define kTagTitleLabel      1
#define kTagImgView         2
#define kTagDetailLabel     3

#define kTitleFont [UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0]
#define kTitlePadFont [UIFont fontWithName:@"HelveticaNeue-Bold" size:32.0]
#define kDetailFont [UIFont fontWithName:@"HelveticaNeue" size:12.0]
#define kDetailPadFont [UIFont fontWithName:@"HelveticaNeue" size:20.0]

#define kButtonNormalFont [UIFont fontWithName:@"HelveticaNeue" size:20.0]
#define kButtonBoldFont [UIFont fontWithName:@"HelveticaNeue-Medium" size:20.0]

#define kBGColor [UIColor colorWithRed:26./255. green:163./255. blue:227./255. alpha:1.]
#define kTextColor [UIColor colorWithRed:57./255. green:57./255. blue:57./255. alpha:1.]

#define is_iPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define RGBCOLOR(r, g, b)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

@interface IntroViewController ()<UIScrollViewDelegate>

@property (retain, nonatomic)  UIScrollView *scrollView;
@property (retain, nonatomic)  UIPageControl *pageControl;

@property (retain, nonatomic)  UIView *firstView;
@property (retain, nonatomic)  UIView *secondView;
@property (retain, nonatomic)  UIView *thirdView;
@property (retain, nonatomic)  UIView *forthView;

@end

@implementation IntroViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.firstView];
    [self.scrollView addSubview:self.secondView];
    [self.scrollView addSubview:self.thirdView];
    [self.scrollView addSubview:self.forthView];
    
    [self.view addSubview:self.pageControl];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_10_3
    if (@available(iOS 11.0, *))
    {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
#endif
}

- (void)dealloc
{
    self.firstView = nil;
    self.secondView = nil;
    self.thirdView = nil;
    self.forthView = nil;
    
    self.scrollView = nil;
    self.pageControl = nil;
    
//    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
#define kPageHeight  20
#define kTitleHeight 24
#define kPadTitleHeight 60
#define kDetailHeight 30
    CGRect bounds = self.view.bounds;
    
    
    if(fabs(bounds.size.height - 812.0f) < 0.01f) {
        self.pageControl.frame = CGRectMake(0, bounds.size.height-kPageHeight - 34, bounds.size.width, kPageHeight);
    } else {
        self.pageControl.frame = CGRectMake(0, bounds.size.height-kPageHeight, bounds.size.width, kPageHeight);
    }
    
    self.scrollView.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height);
    self.scrollView.contentSize = CGSizeMake(bounds.size.width*self.pageControl.numberOfPages, self.scrollView.frame.size.height);
    
    [self updateFirstViewFrame];
    [self updateSecondViewFrame];
    [self updateThirdViewFrame];
    [self updateForthViewFrame];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    //This is the starting point of the ScrollView
    CGPoint scrollPoint = CGPointMake(0, 0);
    [_scrollView setContentOffset:scrollPoint animated:NO];
}

- (void)updateFirstViewFrame
{
    CGRect viewFrame = self.view.bounds;
    self.firstView.frame = viewFrame;
    
    UIView *titleLabel = [self.firstView viewWithTag:kTagTitleLabel];
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGFloat offsetY = (is_iPad || UIInterfaceOrientationIsPortrait(orientation)) ? 3*kPageHeight : kPageHeight;
    CGFloat titleHeight = is_iPad ? kPadTitleHeight : kTitleHeight;
    titleLabel.frame = CGRectMake(kPageHeight, offsetY, viewFrame.size.width-2*kPageHeight, titleHeight);
    
    UIView *detailLabel = [self.firstView viewWithTag:kTagDetailLabel];
    detailLabel.frame = CGRectMake(kDetailHeight/4, CGRectGetMaxY(titleLabel.frame), viewFrame.size.width-kDetailHeight/2, kDetailHeight);
    
    UIView *imgView = [self.firstView viewWithTag:kTagImgView];
    CGFloat length = MIN(viewFrame.size.width, viewFrame.size.height) - 4*kPageHeight;
    length = is_iPad ? length/2. : length;
    imgView.frame = CGRectMake(0, 0, length, length);
    imgView.center = self.view.center;
}

- (void)updateSecondViewFrame
{
    CGRect viewFrame = CGRectOffset(self.firstView.frame, self.firstView.frame.size.width, 0);
    self.secondView.frame = viewFrame;
    
    UIView *titleLabel = [self.secondView viewWithTag:kTagTitleLabel];
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGFloat offsetY = (is_iPad || UIInterfaceOrientationIsPortrait(orientation)) ? 3*kPageHeight : kPageHeight;
    CGFloat titleHeight = is_iPad ? kPadTitleHeight : kTitleHeight;
    titleLabel.frame = CGRectMake(kPageHeight, offsetY, viewFrame.size.width-2*kPageHeight, titleHeight);
    
    UIView *detailLabel = [self.secondView viewWithTag:kTagDetailLabel];
    detailLabel.frame = CGRectMake(kDetailHeight/4, CGRectGetMaxY(titleLabel.frame), viewFrame.size.width-kDetailHeight/2, kDetailHeight);
    
    UIView *imgView = [self.secondView viewWithTag:kTagImgView];
    CGFloat length = MIN(viewFrame.size.width, viewFrame.size.height) - 4*kPageHeight;
    length = is_iPad ? length/2. : length;
    imgView.frame = CGRectMake(0, 0, length, length);
    imgView.center = self.view.center;
}

- (void)updateThirdViewFrame
{
    CGRect viewFrame = CGRectOffset(self.secondView.frame, self.secondView.frame.size.width, 0);
    self.thirdView.frame = viewFrame;
    
    UIView *titleLabel = [self.thirdView viewWithTag:kTagTitleLabel];
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGFloat offsetY = (is_iPad || UIInterfaceOrientationIsPortrait(orientation)) ? 3*kPageHeight : kPageHeight;
    CGFloat titleHeight = is_iPad ? kPadTitleHeight : kTitleHeight;
    titleLabel.frame = CGRectMake(kPageHeight, offsetY, viewFrame.size.width-2*kPageHeight, titleHeight);
    
    UIView *detailLabel = [self.thirdView viewWithTag:kTagDetailLabel];
    detailLabel.frame = CGRectMake(kDetailHeight/4, CGRectGetMaxY(titleLabel.frame), viewFrame.size.width-kDetailHeight/2, kDetailHeight);
    
    UIView *imgView = [self.thirdView viewWithTag:kTagImgView];
    CGFloat length = MIN(viewFrame.size.width, viewFrame.size.height) - 4*kPageHeight;
    length = is_iPad ? length/2. : length;
    imgView.frame = CGRectMake(0, 0, length, length);
    imgView.center = self.view.center;
}

- (void)updateForthViewFrame
{
    CGRect viewFrame = CGRectOffset(self.thirdView.frame, self.thirdView.frame.size.width, 0);
    self.forthView.frame = viewFrame;
    
    UIView *titleLabel = [self.forthView viewWithTag:kTagTitleLabel];
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGFloat offsetY = (is_iPad || UIInterfaceOrientationIsPortrait(orientation)) ? 3*kPageHeight : kPageHeight;
    CGFloat titleHeight = is_iPad ? kPadTitleHeight : kTitleHeight;
    titleLabel.frame = CGRectMake(kPageHeight, offsetY, viewFrame.size.width-2*kPageHeight, titleHeight);
    
    UIView *detailLabel = [self.forthView viewWithTag:kTagDetailLabel];
    detailLabel.frame = CGRectMake(kDetailHeight/4, CGRectGetMaxY(titleLabel.frame), viewFrame.size.width-kDetailHeight/2, kDetailHeight);
    
    UIView *imgView = [self.forthView viewWithTag:kTagImgView];
    CGFloat length = MIN(viewFrame.size.width, viewFrame.size.height) - 4*kPageHeight;
    length = is_iPad ? length/2. : length;
    imgView.frame = CGRectMake(0, 0, length, length);
    imgView.center = self.view.center;
}

- (UIScrollView*)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        
        //This is the starting point of the ScrollView
        CGPoint scrollPoint = CGPointMake(0, 0);
        [_scrollView setContentOffset:scrollPoint animated:YES];
    }
    
    return _scrollView;
}

- (UIPageControl*)pageControl
{
    if (!_pageControl)
    {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        _pageControl.userInteractionEnabled = NO;
        _pageControl.currentPageIndicatorTintColor = RGBCOLOR(128, 128, 148);
        _pageControl.pageIndicatorTintColor = RGBCOLOR(228, 228, 238);
        _pageControl.numberOfPages = 4;
    }
    
    return _pageControl;
}

- (UIView*)firstView
{
    if (!_firstView)
    {
        _firstView = [[UIView alloc] initWithFrame:CGRectZero];
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageview.tag = kTagImgView;
        imageview.clipsToBounds = YES;
        imageview.contentMode = UIViewContentModeScaleAspectFit;
        imageview.image = [UIImage imageNamed:@"zoom_intro1.png"];
        [_firstView addSubview:imageview];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.tag = kTagTitleLabel;
        titleLabel.text = NSLocalizedString(@"Start a Meeting", @"");
        titleLabel.font = is_iPad ? kTitlePadFont : kTitleFont;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = kTextColor;
        titleLabel.textAlignment =  NSTextAlignmentCenter;
        titleLabel.numberOfLines = 0;
        [_firstView addSubview:titleLabel];
        
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        detailLabel.tag = kTagDetailLabel;
        detailLabel.text = NSLocalizedString(@"Start or join a video meeting on the go", @"");
        detailLabel.font = is_iPad ? kDetailPadFont : kDetailFont;
        detailLabel.backgroundColor = [UIColor clearColor];
        detailLabel.textColor = kTextColor;
        detailLabel.textAlignment =  NSTextAlignmentCenter;
        detailLabel.numberOfLines = 0;
        [_firstView addSubview:detailLabel];
        
    }
    
    return _firstView;
}

- (UIView*)secondView
{
    if (!_secondView)
    {
        _secondView = [[UIView alloc] initWithFrame:CGRectZero];
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageview.tag = kTagImgView;
        imageview.clipsToBounds = YES;
        imageview.contentMode = UIViewContentModeScaleAspectFit;
        imageview.image = [UIImage imageNamed:@"zoom_intro2.png"];
        [_secondView addSubview:imageview];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.tag = kTagTitleLabel;
        titleLabel.text = NSLocalizedString(@"Share Your Content", @"");
        titleLabel.font = is_iPad ? kTitlePadFont : kTitleFont;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = kTextColor;
        titleLabel.textAlignment =  NSTextAlignmentCenter;
        titleLabel.numberOfLines = 0;
        [_secondView addSubview:titleLabel];
        
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        detailLabel.tag = kTagDetailLabel;
        detailLabel.text = NSLocalizedString(@"They see what you see", @"");
        detailLabel.font = is_iPad ? kDetailPadFont : kDetailFont;
        detailLabel.backgroundColor = [UIColor clearColor];
        detailLabel.textColor = kTextColor;
        detailLabel.textAlignment =  NSTextAlignmentCenter;
        detailLabel.numberOfLines = 0;
        [_secondView addSubview:detailLabel];
    }
    
    return _secondView;
}

- (UIView*)thirdView
{
    if (!_thirdView)
    {
        _thirdView = [[UIView alloc] initWithFrame:CGRectZero];
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageview.tag = kTagImgView;
        imageview.clipsToBounds = YES;
        imageview.contentMode = UIViewContentModeScaleAspectFit;
        imageview.image = [UIImage imageNamed:@"zoom_intro3.png"];
        [_thirdView addSubview:imageview];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.tag = kTagTitleLabel;
        titleLabel.text = NSLocalizedString(@"Message Your Team", @"");
        titleLabel.font = is_iPad ? kTitlePadFont : kTitleFont;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = kTextColor;
        titleLabel.textAlignment =  NSTextAlignmentCenter;
        titleLabel.numberOfLines = 0;
        [_thirdView addSubview:titleLabel];
        
        
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        detailLabel.tag = kTagDetailLabel;
        detailLabel.text = NSLocalizedString(@"Send texts, voice messages, files and images", @"");
        detailLabel.font = is_iPad ? kDetailPadFont : kDetailFont;
        detailLabel.backgroundColor = [UIColor clearColor];
        detailLabel.textColor = kTextColor;
        detailLabel.textAlignment =  NSTextAlignmentCenter;
        detailLabel.numberOfLines = 0;
        [_thirdView addSubview:detailLabel];
    }
    
    return _thirdView;
}

- (UIView*)forthView
{
    if (!_forthView)
    {
        _forthView = [[UIView alloc] initWithFrame:CGRectZero];
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageview.tag = kTagImgView;
        imageview.clipsToBounds = YES;
        imageview.contentMode = UIViewContentModeScaleAspectFit;
        imageview.image = [UIImage imageNamed:@"zoom_intro4.png"];
        [_forthView addSubview:imageview];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.tag = kTagTitleLabel;
        titleLabel.text = NSLocalizedString(@"Get Meeting!", @"");
        titleLabel.font = is_iPad ? kTitlePadFont : kTitleFont;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = kTextColor;
        titleLabel.textAlignment =  NSTextAlignmentCenter;
        titleLabel.numberOfLines = 0;
        [_forthView addSubview:titleLabel];
        
        
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        detailLabel.tag = kTagDetailLabel;
        detailLabel.text = NSLocalizedString(@"Work anywhere, with anyone, on any device", @"");
        detailLabel.font = is_iPad ? kDetailPadFont : kDetailFont;
        detailLabel.backgroundColor = [UIColor clearColor];
        detailLabel.textColor = kTextColor;
        detailLabel.textAlignment =  NSTextAlignmentCenter;
        detailLabel.numberOfLines = 0;
        [_forthView addSubview:detailLabel];
    }
    
    return _forthView;
}

#pragma mark - ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = CGRectGetWidth(self.view.bounds);
    CGFloat pageFraction = self.scrollView.contentOffset.x / pageWidth;
    self.pageControl.currentPage = roundf(pageFraction);
}

@end
