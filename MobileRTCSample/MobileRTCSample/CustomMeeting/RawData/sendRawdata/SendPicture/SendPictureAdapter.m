#import "SendPictureAdapter.h"
#import "PreProcessHelper.h"

@interface SendPictureAdapter ()
@property (nonatomic, strong) MobileRTCVideoSender *videoRawdataSender;
@property(nonatomic, assign) unsigned char *sendBuff1;
@property(nonatomic, assign) unsigned char *sendBuff2;
@property(nonatomic, strong) NSTimer *sendPicTimer;

@end

@implementation SendPictureAdapter

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initNotification];
    }
    return self;
}

- (void)initNotification {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];

    [nc addObserver:self
           selector:@selector(onApplicationWillResignActiveNotification:)
               name:UIApplicationWillResignActiveNotification
             object:nil];

    [nc addObserver:self
           selector:@selector(onApplicationDidBecomeActiveNotification:)
               name:UIApplicationDidBecomeActiveNotification
             object:nil];
    
}

- (void)onApplicationWillResignActiveNotification:(NSNotification *)aNotification
{
    [self timerPause];
}

- (void)onApplicationDidBecomeActiveNotification:(NSNotification *)aNotification
{
    [self timerResume];
}

#pragma mark - send raw data cb -
- (void)onInitialize:(MobileRTCVideoSender *_Nonnull)rawDataSender supportCapabilityArray:(NSArray *_Nonnull)supportCapabilityArray suggestCapabilityItem:(MobileRTCVideoCapabilityItem *_Nonnull)suggestCapabilityItem
{
    // save video rawdata sender
    self.videoRawdataSender = rawDataSender;
    
    [self createtPictureCaptureSession];
    [self.sendPicTimer fire];
    [[NSRunLoop currentRunLoop] addTimer:self.sendPicTimer forMode:NSRunLoopCommonModes];
}

- (void)onPropertyChange:(NSArray *_Nonnull)supportCapabilityArray suggestCapabilityItem:(MobileRTCVideoCapabilityItem *_Nonnull)suggestCapabilityItem
{
    
}

- (void)onStartSend
{
    [self timerResume];
}

- (void)onStopSend
{
    [self timerPause];
}

- (void)onUninitialized
{
    [self timerStop];
    self.videoRawdataSender = nil;
}

- (void)createtPictureCaptureSession
{
    UIImage *sendPic1 = [UIImage imageNamed:@"frame_one.jpg"];
    UIImage *sendPic2 = [UIImage imageNamed:@"frame_two.jpg"];
    self.sendBuff1 = [PreProcessHelper imageToi420:sendPic1];
    self.sendBuff2 = [PreProcessHelper imageToi420:sendPic2];
    __block NSInteger index = 0;
    if (@available(iOS 10.0, *)) {
        self.sendPicTimer = [NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
            if (index % 2 == 0) {
                [self.videoRawdataSender sendVideoFrame:(char *)self.sendBuff1 width:640 height:480 dataLength:640*480*1.5 rotation:MobileRTCVideoRawDataRotationNone];
            } else {
                [self.videoRawdataSender sendVideoFrame:(char *)self.sendBuff2 width:640 height:480 dataLength:640*480*1.5 rotation:MobileRTCVideoRawDataRotationNone];
            }
            index++;
        }];
    } else {
        // Fallback on earlier versions
    }
    
}

- (void)dealloc
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
    
    if ([self.sendPicTimer isValid]) {
        [self.sendPicTimer invalidate];
    }
    self.sendPicTimer = nil;
    self.videoRawdataSender = nil;
}

- (void)timerPause {
    if (!self.sendPicTimer.isValid) {
        return;
    }
    
    [self.sendPicTimer setFireDate:[NSDate distantFuture]];
}

- (void)timerResume {
    if (!self.sendPicTimer.isValid) {
        return;
    }
    
    [self.sendPicTimer setFireDate:[NSDate date]];
}

-(void)timerStop
{
    if (self.sendPicTimer.isValid) {
        [self.sendPicTimer invalidate];
        self.sendPicTimer=nil;
    }
}

@end
