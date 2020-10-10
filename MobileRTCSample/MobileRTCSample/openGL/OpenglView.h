
#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import <OpenGLES/EAGL.h>
#include <sys/time.h>

@interface OpenglView : UIView
typedef enum : NSUInteger {
    DisplayMode_LetterBox,
    DisplayMode_PanAndScan,
} DisplayMode;

- (void)displayYUV:(MobileRTCVideoRawData *)rawData mode:(DisplayMode)mode mirror:(BOOL)mirror;

- (void)clearFrame;

- (void)addAvatar;
- (void)removeAvatar;
@end
