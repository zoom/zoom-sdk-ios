//
//  TopPanelView.h
//  MobileRTCSample
//
//  Created by Zoom Video Communications on 2018/10/12.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define Top_Height               80

#define kTagButtonShrink         1000
#define kTagButtonCameraSwitch   (kTagButtonShrink+1)
#define kTagButtonEnd            (kTagButtonShrink+2)

@interface TopPanelView : UIView

@property (strong, nonatomic) UIButton        *shrinkBtn;
@property (nonatomic,copy) void(^shrinkButtonClickBlock)(void);

- (void)updateFrame;
- (void)showTopPanelView;
- (void)hiddenTopPanelView;
@end

