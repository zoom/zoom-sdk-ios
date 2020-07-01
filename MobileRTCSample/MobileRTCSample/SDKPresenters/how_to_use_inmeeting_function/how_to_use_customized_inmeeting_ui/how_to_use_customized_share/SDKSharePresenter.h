//
//  SDKSharePresenter.h
//  MobileRTCSample
//
//  Created by Zoom Video Communications on 2018/11/20.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDKSharePresenter : NSObject

- (void)startOrStopAppShare;

- (void)appShareWithView:(UIView *)view;

@end
