//
//  SampleHandler.m
//  ExtensionReplayKit
//
//  Created by Chao Bai on 2018/5/11.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//


#import "SampleHandler.h"
#import <MobileRTCScreenShare/MobileRTCScreenShareService.h>

@interface SampleHandler () <MobileRTCScreenShareServiceDelegate>

@property (strong, nonatomic) MobileRTCScreenShareService * screenShareService;

@end

@implementation SampleHandler

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        MobileRTCScreenShareService * service = [[MobileRTCScreenShareService alloc]init];
        self.screenShareService = service;
        self.screenShareService.appGroup = @"";
        self.screenShareService.delegate = self;
        [service release];
    }
    return self;
}

- (void)dealloc
{
    self.screenShareService = nil;
    [super dealloc];
}


- (void)broadcastStartedWithSetupInfo:(NSDictionary<NSString *,NSObject *> *)setupInfo {
    // User has requested to start the broadcast. Setup info from the UI extension can be supplied but optional.
        [self.screenShareService broadcastStartedWithSetupInfo:setupInfo];
    
}

- (void)broadcastPaused {
        [self.screenShareService broadcastPaused];
    // User has requested to pause the broadcast. Samples will stop being delivered.
}

- (void)broadcastResumed {
        [self.screenShareService broadcastResumed];
    // User has requested to resume the broadcast. Samples delivery will resume.
}

- (void)broadcastFinished {
    // User has requested to finish the broadcast.
        [self.screenShareService broadcastFinished];
}

- (void)processSampleBuffer:(CMSampleBufferRef)sampleBuffer withType:(RPSampleBufferType)sampleBufferType {
    [self.screenShareService processSampleBuffer:sampleBuffer withType:sampleBufferType];
}

- (void)MobileRTCScreenShareServiceFinishBroadcastWithError:(NSError *)error
{
    [self finishBroadcastWithError:error];
}

@end
