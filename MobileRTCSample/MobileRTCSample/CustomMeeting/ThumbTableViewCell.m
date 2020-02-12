//
//  ThumbTableViewCell.m
//  MobileRTCSample
//
//  Created by Murray Li on 2018/10/12.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import "ThumbTableViewCell.h"

@implementation ThumbTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.thumbView];

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    BOOL landscape = UIInterfaceOrientationIsLandscape(orientation);
    CGRect frame = [UIScreen mainScreen].bounds;
    CGFloat cellSize = 0;
    if (landscape)
    {
        cellSize = ceilf(frame.size.height/4.);
    }
    else
    {
        cellSize = ceilf(frame.size.width/4.);
    }
    self.thumbView.frame = CGRectMake(ThumbViewBorderWidth, ThumbViewBorderWidth, cellSize - ThumbViewBorderWidth*2, cellSize - ThumbViewBorderWidth*2);
}

- (UIView*)thumbView
{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    BOOL landscape = UIInterfaceOrientationIsLandscape(orientation);
    CGRect frame = [UIScreen mainScreen].bounds;
    CGFloat cellSize = 0;
    if (landscape)
    {
        cellSize = ceilf(frame.size.height/4.);
    }
    else
    {
        cellSize = ceilf(frame.size.width/4.);
    }
    if (!_thumbView)
    {
        _thumbView = [[MobileRTCVideoView alloc] initWithFrame:CGRectMake(ThumbViewBorderWidth, ThumbViewBorderWidth, cellSize - ThumbViewBorderWidth*2, cellSize - ThumbViewBorderWidth*2)];
        _thumbView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _thumbView.backgroundColor = [UIColor blackColor];
    }
    
    return _thumbView;
}

- (void)stopThumbVideo
{
    [self.thumbView stopAttendeeVideo];

}

- (void)dealloc
{
    self.thumbView = nil;
    [super dealloc];
}
@end
