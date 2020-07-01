//
//  SDKVideoPresenter.h
//  MobileRTCSample
//
//  Created by Zoom Video Communications on 2018/11/20.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDKVideoPresenter : NSObject

- (void)muteMyVideo;

- (void)switchMyCamera;

- (BOOL)pinVideo:(BOOL)on withUser:(NSUInteger)userId;

// only meeting host can run this function.
- (BOOL)stopUserVideo:(NSUInteger)userID;

// only meeting host can run this function.
- (BOOL)askUserStartVideo:(NSUInteger)userID;

@end

