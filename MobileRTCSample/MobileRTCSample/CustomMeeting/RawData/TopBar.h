//
//  OpenGLVCTopBar.h
//  MobileRTCSample
//
//  Created by Zoom Video Communications on 2019/8/6.
//  Copyright © 2019 Zoom Video Communications, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define Top_Height               70
#define kTagButtonEnd         2000

@interface TopBar : UIView
@property (nonatomic,copy) void(^endOnClickBlock)(void);
- (void)updateFrame;
@end

