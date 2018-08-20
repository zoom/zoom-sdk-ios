//
//  ThumbWallViewCell.m
//  RTCVideoWindow
//
//  Created by Robust on 2017/12/20.
//  Copyright © 2017年 Zoom Video Communications, Inc. All rights reserved.
//

#import "ThumbWallViewCell.h"

@implementation ThumbWallViewCell

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
        
        [self addSubview:self.ltView];
        [self addSubview:self.lbView];
        [self addSubview:self.rtView];
        [self addSubview:self.rbView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    const CGFloat SPACE = 1;
    CGRect bounds = self.bounds;
    CGFloat width = (bounds.size.width - 3*SPACE) / 2.;
    CGFloat height = (bounds.size.height - 3*SPACE) / 2.;
    self.ltView.frame = CGRectMake(SPACE, SPACE, width, height);
    self.rtView.frame = CGRectOffset(self.ltView.frame, width+SPACE, 0);
    self.lbView.frame = CGRectOffset(self.ltView.frame, 0, height+SPACE);
    self.rbView.frame = CGRectOffset(self.ltView.frame, width+SPACE, height+SPACE);
}

- (UIView*)ltView
{
    if (!_ltView)
    {
        _ltView = [[MobileRTCVideoView alloc] initWithFrame:CGRectZero];
        _ltView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _ltView.backgroundColor = [UIColor blackColor];
        _ltView.layer.borderWidth = 1;
        _ltView.layer.borderColor = [[UIColor clearColor] CGColor];
    }
    return _ltView;
}

- (UIView*)lbView
{
    if (!_lbView)
    {
        _lbView = [[MobileRTCVideoView alloc] initWithFrame:CGRectZero];
        _lbView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _lbView.backgroundColor = [UIColor blackColor];
        _lbView.layer.borderWidth = 1;
        _lbView.layer.borderColor = [[UIColor clearColor] CGColor];
    }
    return _lbView;
}

- (UIView*)rtView
{
    if (!_rtView)
    {
        _rtView = [[MobileRTCVideoView alloc] initWithFrame:CGRectZero];
        _rtView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _rtView.backgroundColor = [UIColor blackColor];
        _rtView.layer.borderWidth = 1;
        _rtView.layer.borderColor = [[UIColor clearColor] CGColor];
    }
    return _rtView;
}

- (UIView*)rbView
{
    if (!_rbView)
    {
        _rbView = [[MobileRTCVideoView alloc] initWithFrame:CGRectZero];
        _rbView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _rbView.backgroundColor = [UIColor blackColor];
        _rbView.layer.borderWidth = 1;
        _rbView.layer.borderColor = [[UIColor clearColor] CGColor];
    }
    return _rbView;
}

- (void)stopAllThumbVideo
{
    [_ltView stopAttendeeVideo];
    [_lbView stopAttendeeVideo];
    [_rtView stopAttendeeVideo];
    [_rbView stopAttendeeVideo];
}

- (void)dealloc
{
    self.ltView = nil;
    self.lbView = nil;
    self.rtView = nil;
    self.rbView = nil;
    [super dealloc];
}
@end
