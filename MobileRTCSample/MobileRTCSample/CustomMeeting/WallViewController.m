//
//  WallViewController.m
//  MobileRTCSample
//
//  Created by Robust on 2017/12/20.
//  Copyright © 2017年 Zoom Video Communications, Inc. All rights reserved.
//

#import "WallViewController.h"
#import "ThumbWallViewCell.h"

@interface WallViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation WallViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.wallVideoView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.wallVideoView = nil;
    
    [super dealloc];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGRect viewBounds = self.view.bounds;
    self.wallVideoView.transform = CGAffineTransformMakeRotation(-M_PI / 2);
    self.wallVideoView.frame = viewBounds;
    self.wallVideoView.rowHeight = viewBounds.size.width;
    
    [self updateWallVideo];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self updateWallVideo];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    NSArray *array = [self.wallVideoView visibleCells];
    for (ThumbWallViewCell *cell in array)
    {
        [cell stopAllThumbVideo];
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    CGSize bound = self.view.bounds.size;
    NSArray *array = [self.wallVideoView indexPathsForVisibleRows];
    if (array.count > 0) {
        NSIndexPath *indexPath = [array lastObject];
        CGPoint offset = CGPointMake(0, bound.width * indexPath.row);
        [self.wallVideoView setContentOffset:offset];
    }
    
    [self updateWallVideo];
}

#define kThumbWallViewCell  @"kThumbWallViewCell"

- (HorizontalTableView*)wallVideoView
{
    if (!_wallVideoView)
    {
        _wallVideoView = [[HorizontalTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _wallVideoView.backgroundColor = [UIColor clearColor];
        _wallVideoView.separatorColor = [UIColor clearColor];
        _wallVideoView.pagingEnabled = YES;
        _wallVideoView.delegate=self;
        _wallVideoView.dataSource=self;
        
        [_wallVideoView registerClass:[ThumbWallViewCell class] forCellReuseIdentifier:kThumbWallViewCell];
    }
    
    return _wallVideoView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = [[[[MobileRTC sharedRTC] getMeetingService] getInMeetingUserList] count];
    return (NSInteger) (count+3)/4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ThumbWallViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kThumbWallViewCell];
    if (cell == nil)
    {
        cell = [[[ThumbWallViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:kThumbWallViewCell] autorelease];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.transform = CGAffineTransformMakeRotation(M_PI / 2);

    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    NSMutableArray *videoArray = [NSMutableArray arrayWithArray:[ms getInMeetingUserList]];
    if ([videoArray count] == 0)
        return cell;
    
    // when in background no need to render video again
    UIApplicationState state = [UIApplication sharedApplication].applicationState;
    if(UIApplicationStateActive != state)
        return cell;
    
    //Subscribe attendee Video
    NSUInteger row = [indexPath row];
    if (row >= [videoArray count])
        return cell;
    
    if(tableView.decelerating)
    {
        [cell stopAllThumbVideo];
        return cell;
    }
    
    NSInteger userIndex = indexPath.row * 4;
    if (userIndex < [videoArray count])
    {
        NSUInteger userID = [[videoArray objectAtIndex: userIndex] intValue];
        [self showAttendeeVideo:cell.ltView withUserID:userID];
    }
    else
    {
        [cell.ltView stopAttendeeVideo];
        cell.ltView.layer.borderColor = [[UIColor clearColor] CGColor];
    }

     userIndex = indexPath.row * 4 + 1;
    if (userIndex < [videoArray count])
    {
        NSUInteger userID = [[videoArray objectAtIndex: userIndex] intValue];
        [self showAttendeeVideo:cell.rtView withUserID:userID];
    }
    else
    {
        [cell.rtView stopAttendeeVideo];
        cell.rtView.layer.borderColor = [[UIColor clearColor] CGColor];
    }
    
    userIndex = indexPath.row * 4 + 2;
    if (userIndex < [videoArray count])
    {
        NSUInteger userID = [[videoArray objectAtIndex: userIndex] intValue];
        [self showAttendeeVideo:cell.lbView withUserID:userID];
    }
    else
    {
        [cell.lbView stopAttendeeVideo];
        cell.lbView.layer.borderColor = [[UIColor clearColor] CGColor];
    }
    
    userIndex = indexPath.row * 4 + 3;
    if (userIndex < [videoArray count])
    {
        NSUInteger userID = [[videoArray objectAtIndex: userIndex] intValue];
        [self showAttendeeVideo:cell.rbView withUserID:userID];
    }
    else
    {
        [cell.rbView stopAttendeeVideo];
        cell.rbView.layer.borderColor = [[UIColor clearColor] CGColor];
    }
    
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self updateWallVideo];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (decelerate == NO)
    {
        [self scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)showAttendeeVideo:(MobileRTCVideoView*)videoView withUserID:(NSUInteger)userID
{
    [videoView showAttendeeVideoWithUserID:userID];
    
    NSUInteger activeUserID = [[[MobileRTC sharedRTC] getMeetingService] activeUserID];
    BOOL isActive = [[[MobileRTC sharedRTC] getMeetingService] isSameUser:activeUserID compareTo:userID];
    UIColor *color = [UIColor whiteColor];
    if (isActive)
    {
        color = [UIColor greenColor];
    }
    videoView.layer.borderColor = [color CGColor];
    
    NSUInteger myUserID = [[[MobileRTC sharedRTC] getMeetingService] myselfUserID];
    if ([[[MobileRTC sharedRTC] getMeetingService] isSameUser:myUserID compareTo:userID])
    {
        [videoView setVideoAspect:MobileRTCVideoAspect_PanAndScan];
        return;
    }
    
    CGSize size = [[[MobileRTC sharedRTC] getMeetingService] getUserVideoSize:userID];
    if (CGSizeEqualToSize(size, CGSizeZero))
        return;
    
    if ((fabs(size.width * 4 - size.height * 3) < 5) || (fabs(size.width * 16 - size.height * 9) < 5))
    {
        [videoView setVideoAspect:MobileRTCVideoAspect_PanAndScan];
    }
    else
    {
        [videoView setVideoAspect:MobileRTCVideoAspect_LetterBox];
    }
}

- (void)updateWallVideo
{
    [self.wallVideoView reloadData];
}

@end
