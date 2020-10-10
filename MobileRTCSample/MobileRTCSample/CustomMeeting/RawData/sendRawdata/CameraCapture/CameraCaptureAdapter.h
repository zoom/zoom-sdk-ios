
#import <MobileRTC/MobileRTC.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface CameraCaptureAdapter : NSObject <MobileRTCVideoSourceDelegate, AVCaptureVideoDataOutputSampleBufferDelegate>

@end

