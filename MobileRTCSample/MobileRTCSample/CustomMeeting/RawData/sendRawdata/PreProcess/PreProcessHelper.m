#import "PreProcessHelper.h"
#import "MobileRTCSample-Prefix.pch"

@implementation PreProcessHelper

static unsigned char * wateri420;
static UIImage *waterImage;

- (id)init
{
    self = [super init];
    if (self) {
        self.videoSourceHelper = [[MobileRTCVideoSourceHelper alloc] init];
    }
    return self;
}

- (void)onPreProcessRawData:(MobileRTCPreProcessRawData *)rawData
{
    waterImage = [UIImage imageNamed:@"waterMark"];
    if (!wateri420) {
        wateri420 = [PreProcessHelper imageToi420:waterImage];
    }
    
    [PreProcessHelper addWaterMark:rawData
                        waterImage:waterImage
                         wateri420:wateri420
                              offX:rawData.size.width/2
                              offY:rawData.size.height/2
                 enableTransparent:YES];
}

- (void)setPreProcessor;
{
    
    [self.videoSourceHelper setPreProcessor:self];
}

- (void)cleanVideoCapturePreProcessor;
{
    [self.videoSourceHelper setPreProcessor:nil];
    if (wateri420) {
        free(wateri420);
        wateri420 = nil;
    }
}

+ (void)addWaterMark:(MobileRTCPreProcessRawData *)rawData waterImage:(UIImage *)waterImage wateri420:(unsigned char *)wateri420 offX:(int)off_x offY:(int)off_y enableTransparent:(BOOL)enableTransparent
{
    int waterWidth = waterImage.size.width;
    int waterHeight = waterImage.size.height;
    if (waterWidth > rawData.size.width || waterHeight > rawData.size.height) {
        return;
    }
    
    int water_uvWidth = waterWidth / 2;
    int water_uvHight = waterHeight / 2;
    
    unsigned char * water_yBuffer = wateri420;
    unsigned char * water_uBuffer = wateri420 + waterWidth * waterHeight;
    unsigned char * water_vBuffer = wateri420 + waterWidth * waterHeight + (waterWidth / 2) * (waterHeight / 2);
    
    // yyyy
    for (int i = 0, len = waterHeight; i < len; i++) {
        int index_h_y = off_y + i; // water at which row
        char * yBuffer = [rawData getYBuffer:index_h_y];
        if (enableTransparent) {
            for (int j = 0; j < waterWidth; j++) {
                int offset = i * waterWidth + j;
                int y = wateri420[offset];
                if ((y != 16 && y != -128)) {
                    yBuffer[off_x+j] = y;
                }
            }
        } else {
            memcpy(yBuffer + off_x, water_yBuffer + i * waterWidth, waterWidth);
        }
    }
    
    //  uuvv
    for (int i = 0, len = water_uvHight; i < len; i++) {
        int index_h_uv = off_y / 2 + i; // water at which row
        char * uBuffer = [rawData getUBuffer:index_h_uv];
        char * vBuffer = [rawData getVBuffer:index_h_uv];
        if (enableTransparent) {
            for (int j = 0; j < water_uvWidth; j++) {
                int u = wateri420[waterWidth * waterHeight + i * water_uvWidth + j];
                
                int v = wateri420[waterWidth * waterHeight * 5 / 4 + i * water_uvWidth + j];
                
                if (u != 16 && u != -128 && u != -21) {
                    uBuffer[off_x/2 + j] = u;
                }
                
                if (v != 16 && v != -128 && v != -21) {
                    vBuffer[off_x/2 + j] = v;
                }
                
            }
        } else {
            memcpy(uBuffer+off_x/2, water_uBuffer + i * water_uvWidth, water_uvWidth);
            memcpy(vBuffer+off_x/2, water_vBuffer + i * water_uvWidth, water_uvWidth);
        }
    }
}

+ (unsigned char *)imageToi420:(UIImage *)uiimage
{
    unsigned char * i420;
    CGImageRef image = [uiimage CGImage];
    CGSize size = uiimage.size;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int pixelCount = size.width * size.height;
    uint8_t* argb = malloc(pixelCount * 4);
    CGContextRef context = CGBitmapContextCreate(argb, size.width, size.height, 8, 4 * size.width, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, size.width, size.height), image);
    CGContextRelease(context);
    
    
    int i420_length = pixelCount + (size.width / 2) * (size.height / 2) * 2;
    i420 = malloc(i420_length);
    int yIndex = 0;                   // Y start index
    int uIndex = pixelCount;           // U statt index
    int vIndex = pixelCount + (size.width / 2) * (size.height / 2); // V start index: w*h*5/4
    
    int a, R, G, B, Y, U, V;
    int index = 0;
    for (int j = 0; j < size.height; j++) {
        for (int i = 0; i < size.width; i++) {
            a = argb[index*4];
            R = argb[index*4 + 1];
            G = argb[index*4 + 2];
            B = argb[index*4 + 3];
            
            Y  = (unsigned char)(0.299*R + 0.587*G + 0.114*B  + 16);   //Y
            U =  (unsigned char)(-0.169*R - 0.331*G + 0.499*B  + 128);//U
            V =  (unsigned char)(0.499*R - 0.418*G - 0.0813*B + 128); //V
            
            i420[yIndex++] = (char) ((Y < 0) ? 0 : ((Y > 255) ? 255 : Y));
            if (j % 2 == 0 && i % 2 == 0) {
                i420[uIndex++] = (char) ((U < 0) ? 0 : ((U > 255) ? 255 : U));
                i420[vIndex++] = (char) ((V < 0) ? 0 : ((V > 255) ? 255 : V));
            }
            index++;
        }
    }
    free(argb);
    [PreProcessHelper yuvFrameMirror:i420 image:uiimage];
    return i420;
}

+ (void)yuvFrameMirror:(unsigned char *)data image:(UIImage *)image {
    NSInteger width = image.size.width;
    NSInteger height = image.size.height;
    unsigned char tempData;
    
    for (int i = 0; i < height * 3 / 2; i++) {
        for (int j = 0; j < width / 2; j++) {
            tempData = data[i * width + j];
            data[i * width + j] = data[(i + 1) * width - 1 - j];
            data[(i + 1) * width - 1 - j] = tempData;
        }
    }
    
}


@end
