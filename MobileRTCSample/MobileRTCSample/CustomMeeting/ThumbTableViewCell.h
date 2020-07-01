//
//  ThumbTableViewCell.h
//  MobileRTCSample
//
//  Created by Zoom Video Communications on 2018/10/12.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ThumbViewBorderWidth 1

@interface ThumbTableViewCell : UITableViewCell
@property (strong, nonatomic) MobileRTCVideoView *  thumbView;
- (void)stopThumbVideo;
@end

