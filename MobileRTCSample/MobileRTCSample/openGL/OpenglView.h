
#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import <OpenGLES/EAGL.h>
#include <sys/time.h>

@interface OpenglView : UIView

- (void)displayYUV:(MobileRTCVideoRawData *)rawData mode:(DisplayMode)mode;

- (void)clearFrame;

@end
