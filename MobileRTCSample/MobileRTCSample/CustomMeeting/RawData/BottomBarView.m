//
//  BottomBarView.m
//
//  Created by Zoom Video Communications on 2019/5/29.
//  Copyright © 2019 Zoom. All rights reserved.
//

#import "BottomBarView.h"
#import "HorizontalTableView.h"

@implementation ViewItem

- (BOOL)isEqual:(id)object {
    
    if (![object isKindOfClass:[ViewItem class]]) {
        return NO;
    }
    
    ViewItem *newObj = (ViewItem *)object;
    
    if (_userId == newObj.userId && [_view isEqual:newObj.view]) {
        return YES;
    }
    
    return NO;
}

-(NSString *)description {
        return [NSString stringWithFormat:@"View Item userId:%@, view addr:0x%x, is active %@", @(self.userId), self.view, @(self.isActive)];
}

@end

@implementation LeftLabel

-(void)drawTextInRect:(CGRect)rect
{
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(0, 8, 0, 25))];
}

@end

#define kNameTag        11001

@interface BottomBarView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) id<BottomBarViewDelegate> handle;
@property (strong, nonatomic) CAGradientLayer           *gradientLayer;
@end

@implementation BottomBarView

- (instancetype)initWithDelegate:(id<BottomBarViewDelegate>)delegate
{
    self = [super init];
    if (self) {
        _handle = delegate;
        _viewArray = [[NSMutableArray alloc] init];
        [self.layer addSublayer:self.gradientLayer];
        [self addSubview:self.thumbTableView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = [UIColor clearColor];
    self.gradientLayer.frame = self.bounds;
    
    
    self.frame = CGRectMake(0, SCREEN_HEIGHT - kTableHeight, SCREEN_WIDTH, kTableHeight);
    
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    BOOL landscape = UIInterfaceOrientationIsLandscape(orientation);
    
    if (landscape) {
        if (orientation == UIInterfaceOrientationLandscapeRight && IPHONE_X) {
            self.thumbTableView.frame = CGRectMake(SAFE_ZOOM_INSETS+10, 0, SCREEN_WIDTH, kTableHeight);
        } else {
            self.thumbTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kTableHeight);
        }
    } else {
        self.thumbTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kTableHeight);
    }
    [self updateLayout];
}

- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = self.bounds;
        [self.layer addSublayer:_gradientLayer];
        _gradientLayer.startPoint = CGPointMake(0.5, 0);
        _gradientLayer.endPoint = CGPointMake(0.5, 1);
        _gradientLayer.colors = @[(__bridge id)[UIColor colorWithWhite:0.f alpha:0.0].CGColor,
                                  (__bridge id)[UIColor colorWithWhite:0.f alpha:0.75].CGColor];
    }
    return _gradientLayer;
}

- (HorizontalTableView*)thumbTableView
{
    if (!_thumbTableView) {
        _thumbTableView = [[HorizontalTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _thumbTableView.backgroundColor = [UIColor clearColor];
        _thumbTableView.separatorColor = [UIColor clearColor];
        _thumbTableView.pagingEnabled = NO;
        _thumbTableView.delegate = self;
        _thumbTableView.dataSource = self;
        _thumbTableView.showsVerticalScrollIndicator = NO;
    }
    
    return _thumbTableView;
}

- (void)addThumberViewItem:(ViewItem *)item; {
    if ([self.viewArray containsObject:item]) {
        return;
    }
    
    LeftLabel *nameLabel = [[LeftLabel alloc] init];
    nameLabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
    nameLabel.text = item.itemName; // [NSString stringWithFormat:@"%@", @(item.userId)];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont systemFontOfSize:12.0];
    nameLabel.tag = kNameTag;
    [item.view addSubview:nameLabel];

    item.view.layer.cornerRadius = 10.0;
    item.view.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:0.5].CGColor;
    item.view.layer.borderWidth = 1.0;
    [item.view setClipsToBounds:YES];
    
    item.view.transform = CGAffineTransformMakeRotation(M_PI / 2);
    
    [self.viewArray addObject:item];
    [self updateLayout];
}

- (void)removeThumberViewItem:(ViewItem *)item; {
    if (![self.viewArray containsObject:item]) {
        return;
    }
    
    [self.viewArray removeObject:item];
    [self updateLayout];
}

- (void)updateItem:(ViewItem *)item withViewItem:(ViewItem *)newItem {
    
    NSUInteger index = [self.viewArray indexOfObject:item];
    if (index == NSNotFound) {
        return;
    }
    
    for (UIView *view in [newItem.view subviews]) {
        if (view.tag == kNameTag) {
            [view removeFromSuperview];
        }
    }
    
    LeftLabel *nameLabel = [[LeftLabel alloc] init];
    nameLabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
    nameLabel.text = newItem.itemName;
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont systemFontOfSize:12.0];
    nameLabel.tag = kNameTag;
    [newItem.view addSubview:nameLabel];
    
    newItem.view.layer.cornerRadius = 10.0;
    newItem.view.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:0.5].CGColor;
    newItem.view.layer.borderWidth = 1.0;
    [newItem.view setClipsToBounds:YES];
    
    newItem.view.transform = CGAffineTransformMakeRotation(M_PI / 2);
    
    [self.viewArray replaceObjectAtIndex:index withObject:newItem];
    [self updateLayout];
}

- (void)removeThumberViewItemWithUserId:(NSUInteger)userId {
    
    NSMutableArray *removeItem = [NSMutableArray array];
    for (ViewItem *item in self.viewArray) {
        if (userId == item.userId) {
            [removeItem addObject:item];
        }
    }
    
    for (ViewItem *item in removeItem) {
        [self.viewArray removeObject:item];
    }
    
    [self updateLayout];
}

- (void)activeThumberViewItem:(NSUInteger)userId {
    for (ViewItem *item in self.viewArray) {
        if (userId == item.userId) {
            item.isActive = YES;
        } else {
            item.isActive = NO;
        }
    }
    [self updateLayout];
}

- (void)deactiveAllThumberView {
    for (ViewItem *item in self.viewArray) {
        item.isActive = NO;
    }
    [self updateLayout];
}

- (void)updateLayout {
    self.thumbTableView.transform = CGAffineTransformMakeRotation(-M_PI / 2);
    [self.thumbTableView reloadData];
}

- (NSArray *)getThumberViewItems:(NSUInteger)userId {
    NSMutableArray *items = [NSMutableArray array];
    for (ViewItem *item in self.viewArray) {
        if (userId == item.userId) {
            [items addObject:item];
        }
    }
    
    return [items copy];
}

#pragma mark - UITableView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"===================>scrollViewDidScroll");
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopThumbViewVideo];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"===================>scrollViewDidEndDecelerating");
    [self startThumbViewVideo];
    [self scrollToRowPosition];
    [self.thumbTableView reloadData];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"===================>scrollViewDidEndDragging");
    if (decelerate == NO)
    {
        [self startThumbViewVideo];
        [self scrollToRowPosition];
        [self.thumbTableView reloadData];
    }
}

- (void)stopThumbViewVideo {
    [self.handle stopThumbViewVideo];
}

- (void)startThumbViewVideo {
    [self.handle startThumbViewVideo];
}

- (void)scrollToRowPosition {
    NSInteger rowHeight = kCellHeight;
    NSInteger offsetY = (NSInteger)self.thumbTableView.contentOffset.y % rowHeight;
    BOOL visibleCell = offsetY >= rowHeight/2;
    
    NSIndexPath *indexPath = [self.thumbTableView indexPathForRowAtPoint:CGPointMake(self.thumbTableView.contentOffset.x, self.thumbTableView.contentOffset.y)];
    if (visibleCell)
    {
        indexPath = [NSIndexPath indexPathForRow: indexPath.row+1 inSection: 0];
    }
    
    if (indexPath.row < self.viewArray.count) {
        [self.thumbTableView scrollToRowAtIndexPath: indexPath atScrollPosition: UITableViewScrollPositionTop animated: YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    CGFloat headerHeight = 0;
    CGFloat margin = SCREEN_WIDTH - self.viewArray.count * kCellHeight;
    if (margin > 0) {
        headerHeight = margin * 0.5 - 5;
    }
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    BOOL landscape = UIInterfaceOrientationIsLandscape(orientation);
    if (IS_IPAD || landscape) {
        headerHeight = 0.1;
    }
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kCellHeight, headerHeight)];
    header.backgroundColor = [UIColor clearColor];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    BOOL landscape = UIInterfaceOrientationIsLandscape(orientation);
    if (IS_IPAD || landscape) {
        return 0.1;
    }
    
    CGFloat margin = SCREEN_WIDTH - self.viewArray.count * kCellHeight;
    if (margin > 0)
        return margin * 0.5 - 5;
    
    return 0.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    ViewItem *item = [self.viewArray objectAtIndex:indexPath.row];
    if (!item) {
        return cell;
    }
    [item.view setFrame:CGRectMake(15, 10, kTableHeight - 15 * 2, kCellHeight - 10)];
    
    for (UIView *view in item.view.subviews) {
        if (view.tag == kNameTag) {
            view.frame = CGRectMake(0, kTableHeight - 15 * 2 - 24, kCellHeight - 10, 24);
            [item.view bringSubviewToFront:view];
        }
    }
    
    [cell.contentView addSubview:item.view];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.handle && [self.handle respondsToSelector:@selector(pinThumberViewItem:)]) {
        ViewItem *item = [self.viewArray objectAtIndex:indexPath.row];
        [self.handle pinThumberViewItem:item];
    }
}


@end
