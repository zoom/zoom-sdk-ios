//
//  SDKAudioPresenter.h
//  MobileRTCSample
//
//  Created by Zoom Video Communications on 2018/11/20.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDKAudioPresenter : NSObject

- (void)muteMyAudio;

- (void)switchMyAudioSource;

- (MobileRTCAudioType)myAudioType;

- (BOOL)connectMyAudio:(BOOL)on;

// only meeting host can run this function.
- (BOOL)muteUserAudio:(BOOL)mute withUID:(NSUInteger)userID;

// only meeting host can run this function.
- (BOOL)muteAllUserAudio:(BOOL)allowSelfUnmute;
@end
