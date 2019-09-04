//
//  CustomRemoteControl.h
//  MobileRTCSample
//
//  Created by Murray Li on 2018/6/26.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RemoteControlBarDelegate <NSObject>
@optional
- (void)onClickGrap;
- (void)onClickInput;
@end

@interface RemoteControlBar : UIView
@property (strong, nonatomic) UIButton             * action;
@property (assign, nonatomic) id<RemoteControlBarDelegate>  delegate;
@end

@interface CustomRemoteControl : NSObject
- (void)setupRemoteControl:(UIView *)remoteShareView;
@end



