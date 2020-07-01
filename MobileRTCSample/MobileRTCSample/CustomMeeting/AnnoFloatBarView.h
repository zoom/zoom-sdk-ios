//
//  AnnoFloatBarView.h
//  MobileRTCSample
//
//  Created by Zoom Video Communications on 2018/6/12.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AnnoFloatBarViewDelegate <NSObject>

@optional

- (BOOL)onClickStartAnnotate;
- (BOOL)onClickStopAnnotate;

@end

@interface AnnoFloatBarView : UIView

@property (assign, nonatomic) id<AnnoFloatBarViewDelegate>  delegate;

- (void)stopAnnotate;

@end
