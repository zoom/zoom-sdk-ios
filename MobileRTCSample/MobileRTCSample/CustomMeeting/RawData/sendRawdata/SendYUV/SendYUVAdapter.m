//
//  SendYUVAdapter.m
//  ZoomInstantSample
//
//  Created by Zoom Video Communications on 2020/7/8.
//  Copyright © 2020 Zoom. All rights reserved.
//

#import "SendYUVAdapter.h"

#define Default_fps 25
#define usec_per_fps (1000000/Default_fps)

@interface SendYUVAdapter ()
@property (nonatomic, strong) MobileRTCVideoSender *videoRawdataSender;

@property (strong, nonatomic) NSThread  *workThread;
@property (assign, nonatomic) int width;
@property (assign, nonatomic) int height;
@end

@implementation SendYUVAdapter

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)dealloc {
    [self stop];
    [super dealloc];
}


#pragma mark - send raw data cb -
- (void)onInitialize:(MobileRTCVideoSender *_Nonnull)rawDataSender supportCapabilityArray:(NSArray *_Nonnull)supportCapabilityArray suggestCapabilityItem:(MobileRTCVideoCapabilityItem *_Nonnull)suggestCapabilityItem
{
    // save video rawdata sender
    self.videoRawdataSender = rawDataSender;

    self.width = 640;
    self.height = 480;
}

- (void)onPropertyChange:(NSArray *_Nonnull)supportCapabilityArray suggestCapabilityItem:(MobileRTCVideoCapabilityItem *_Nonnull)suggestCapabilityItem
{
    
}

- (void)onStartSend
{
    [self beginPullVideo];
}

- (void)onStopSend
{
    [self stop];
}

- (void)onUninitialized
{
    self.videoRawdataSender = nil;
}


- (void)beginPullVideo
{
    if (self.workThread == nil) {
        self.workThread = [[NSThread alloc] initWithTarget:self selector:@selector(pullRunloop) object:nil];
        [self.workThread start];
    }
}

- (void)pullRunloop
{
    NSString *lpath = [[NSBundle mainBundle] pathForResource:@"640x480_2" ofType:@"yuv"];
    NSURL *fileUrl = [NSURL fileURLWithPath:lpath];
    NSString *path = fileUrl.path;
    if (path.length == 0) {
        NSLog(@"path = nil");
        return;
    }
    
    // 以二进制方式读取文件
    FILE *yuvFile = fopen([path UTF8String], "rb");
    if (yuvFile == NULL) {
        NSLog(@"open yuv failed");
        return;
    }
    if (self.width <= 0 || self.height <= 0) {
        NSLog(@"yuv width or heigh = 0");
        return;
    }
    
    BOOL needRetry = NO;
//    NSLog(@"begain pull video");
    while (![NSThread currentThread].isCancelled) {

        unsigned char * yuvFrame = malloc(self.height*self.width* 3 / 2);
        
        size_t uAddress = self.height*self.width;
        size_t vAddress = self.height*self.width * 5 / 4;
        
        size_t size = fread(&yuvFrame[0], 1, self.width * self.height, yuvFile);
        size = fread(&yuvFrame[uAddress], 1, self.width * self.height/4, yuvFile);
        size = fread(&yuvFrame[vAddress], 1, self.width * self.height/4, yuvFile);
        
        if (size == 0) {
            NSLog(@"read data size = 0");
            needRetry = YES;
            break;
        }
        
         dispatch_sync(dispatch_get_main_queue(), ^{
            [self.videoRawdataSender sendVideoFrame:(char *)yuvFrame width:self.width height:self.height dataLength:self.height*self.width*1.5 rotation:MobileRTCVideoRawDataRotationNone];
             free(yuvFrame);
         });
        
        usleep(usec_per_fps);
    }
    
    fclose(yuvFile);
    yuvFile = NULL;
//    NSLog(@"end pull video");
    [self stop];
    if (needRetry) {
        [self beginPullVideo];
    }
}

- (void)stop
{
    if (self.workThread) {
        [self.workThread cancel];
        self.workThread = nil;
    }
}

@end
