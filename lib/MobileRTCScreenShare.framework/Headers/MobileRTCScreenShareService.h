//
//  MobileRTCScreenShareService.h
//  MobileRTCScreenShare
//
//  Created by Zoom Video Communications on 2018/5/24.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReplayKit/ReplayKit.h>

@protocol MobileRTCScreenShareServiceDelegate <NSObject>

@required
- (void)MobileRTCScreenShareServiceFinishBroadcastWithError:(NSError *)error;

@end

@interface MobileRTCScreenShareService : NSObject

@property (assign, nonatomic) id<MobileRTCScreenShareServiceDelegate> delegate;

@property (retain, nonatomic) NSString * appGroup;

- (void)broadcastStartedWithSetupInfo:(NSDictionary<NSString *,NSObject *> *)setupInfo;

- (void)broadcastPaused;

- (void)broadcastResumed;

- (void)broadcastFinished;

- (void)processSampleBuffer:(CMSampleBufferRef)sampleBuffer withType:(RPSampleBufferType)sampleBufferType;

@end
