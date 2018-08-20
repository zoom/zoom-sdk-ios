//
//  ThumbWallViewCell.h
//  RTCVideoWindow
//
//  Created by Robust on 2017/12/20.
//  Copyright © 2017年 Zoom Video Communications, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThumbWallViewCell : UITableViewCell

@property (retain, nonatomic) MobileRTCVideoView *  ltView;
@property (retain, nonatomic) MobileRTCVideoView *  lbView;
@property (retain, nonatomic) MobileRTCVideoView *  rtView;
@property (retain, nonatomic) MobileRTCVideoView *  rbView;

- (void)stopAllThumbVideo;

@end
