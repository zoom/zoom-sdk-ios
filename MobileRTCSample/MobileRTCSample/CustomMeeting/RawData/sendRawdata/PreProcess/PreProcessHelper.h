#import <Foundation/Foundation.h>

@interface PreProcessHelper : NSObject <MobileRTCPreProcessorDelegate>

@property (nonatomic, strong) MobileRTCVideoSourceHelper *videoSourceHelper;

- (void)setPreProcessor;
- (void)cleanVideoCapturePreProcessor;

+ (void)addWaterMark:(MobileRTCPreProcessRawData *)rawData waterImage:(UIImage *)waterImage wateri420:(unsigned char *)wateri420 offX:(int)offX offY:(int)offY enableTransparent:(BOOL)enableTransparent;

+ (unsigned char *)imageToi420:(UIImage *)uiimage;

@end

