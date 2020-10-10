#import "CameraCaptureAdapter.h"

@interface CameraCaptureAdapter ()
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) MobileRTCVideoSender *videoRawdataSender;

@end

@implementation CameraCaptureAdapter
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initNotification];
    }
    return self;
}

- (void)dealloc
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}

- (void)initNotification {
    NSNotificationCenter * nc = [NSNotificationCenter defaultCenter];

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
    [self onStopSend];
}

- (void)onApplicationDidBecomeActiveNotification:(NSNotification *)aNotification
{
    [self onStartSend];
}

#pragma mark - send raw data cb -
- (void)onInitialize:(MobileRTCVideoSender *_Nonnull)rawDataSender supportCapabilityArray:(NSArray *_Nonnull)supportCapabilityArray suggestCapabilityItem:(MobileRTCVideoCapabilityItem *_Nonnull)suggestCapabilityItem
{
    // save video rawdata sender
    self.videoRawdataSender = rawDataSender;
    
    [self createtCameraCaptureSession];
}

- (void)onPropertyChange:(NSArray *_Nonnull)supportCapabilityArray suggestCapabilityItem:(MobileRTCVideoCapabilityItem *_Nonnull)suggestCapabilityItem
{
    
}

- (void)onStartSend
{
    [self.captureSession startRunning];
}

- (void)onStopSend
{
    [self.captureSession stopRunning];
}

- (void)onUninitialized
{
    self.captureSession = nil;
}

- (void)createtCameraCaptureSession
{
    AVCaptureVideoDataOutput *captureOutput = [[AVCaptureVideoDataOutput alloc] init];
    captureOutput.alwaysDiscardsLateVideoFrames = YES;
    
    dispatch_queue_t queue;
    queue = dispatch_queue_create("CameraQueue", NULL);
    [captureOutput setSampleBufferDelegate:self queue:queue];
    NSDictionary* videoSettings = [NSDictionary dictionaryWithObject:[NSNumber numberWithUnsignedInt:kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange]
                                                              forKey:(NSString*)kCVPixelBufferPixelFormatTypeKey];
    [captureOutput setVideoSettings:videoSettings];
    
    AVCaptureDeviceInput *captureInput = [[AVCaptureDeviceInput alloc]initWithDevice:[self getFrontCameraDevice] error:nil];
    
    self.captureSession = [[AVCaptureSession alloc] init];
    [self.captureSession addInput:captureInput];
    [self.captureSession addOutput:captureOutput];
    [self.captureSession setSessionPreset:AVCaptureSessionPreset640x480];
}

- (AVCaptureDevice *)getFrontCameraDevice{
    NSArray *cameras= [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *camera in cameras) {
        if ([camera position] == AVCaptureDevicePositionFront) {
            return camera;
        }
    }
    return nil;
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
       fromConnection:(AVCaptureConnection *)connection {
    
    CVPixelBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CVPixelBufferLockBaseAddress(imageBuffer, 0);

    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    
    void *imageAddress = CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 0);
    Byte *sourceAddress = (Byte *)imageAddress;
    
    Byte *buf = malloc(width * height * 3 / 2);
    memcpy(buf, imageAddress, width * height);
    
    size_t uAddress = width * height;
    size_t vAddress = width * height * 5 / 4;
    
    for (NSInteger i = 0; i < width * height / 4; i++) {
        buf[uAddress + i] = sourceAddress[uAddress + 2*i];
        buf[vAddress + i] = sourceAddress[uAddress + 2*i + 1];
    }
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    
    MobileRTCVideoRawDataRotation rotate = MobileRTCVideoRawDataRotationNone;
    
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    if ((orientation == UIDeviceOrientationUnknown) || (orientation == UIDeviceOrientationFaceUp) || (orientation == UIDeviceOrientationFaceDown))
    {
        orientation = (UIDeviceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    }
    
    switch (orientation)
    {
        case UIInterfaceOrientationLandscapeLeft:
            rotate = MobileRTCVideoRawDataRotationNone;
            break;
            
        case UIInterfaceOrientationPortraitUpsideDown:
            rotate = MobileRTCVideoRawDataRotation270;
            break;
            
        case UIInterfaceOrientationLandscapeRight:
            rotate = MobileRTCVideoRawDataRotation180;
            break;
            
        case UIInterfaceOrientationPortrait:
            rotate = MobileRTCVideoRawDataRotation90;
            break;
            
        default:
            return;
    }
    
    
    [_videoRawdataSender sendVideoFrame:(char *)buf width:width height:height dataLength:width * height * 3/ 2 rotation:rotate];
    
    free(buf);
}

@end
