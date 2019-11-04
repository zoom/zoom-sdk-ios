
#import "OpenglView.h"
#include <pthread.h>

#define kEmojiTag           10002
#define kBackgroudTag       10003

enum AttribEnum
{
    ATTRIB_VERTEX,
    ATTRIB_TEXTURE,
    ATTRIB_COLOR,
};

enum TextureType
{
    TEXY = 0,
    TEXU,
    TEXV,
    TEXC
};

@interface OpenglView ()
{
    EAGLContext             *_glContext;
    GLuint                  _framebuffer;
    GLuint                  _renderBuffer;
    GLuint                  _program;
    GLuint                  _textureYUV[3];
    GLuint                  _videoW;
    GLuint                  _videoH;
    GLsizei                 _viewScale;
    
    CGSize                  _boundSize;
    DisplayMode             _displayMode;
    pthread_mutex_t         _lock;
    
#ifdef DEBUG
    struct timeval          _time;
    NSInteger               _frameRate;
#endif
}

@end

@implementation OpenglView

- (BOOL)doInit{

    self.backgroundColor = [UIColor blackColor];
    CAEAGLLayer *eaglLayer = (CAEAGLLayer*) self.layer;
    eaglLayer.opaque = YES;
    eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithBool:NO], kEAGLDrawablePropertyRetainedBacking,
                                    kEAGLColorFormatRGB565, kEAGLDrawablePropertyColorFormat,
                                    //[NSNumber numberWithBool:YES], kEAGLDrawablePropertyRetainedBacking,
                                    nil];
    
    self.contentScaleFactor = [UIScreen mainScreen].scale;
    _viewScale = [UIScreen mainScreen].scale;
    
    _glContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];

    if(!_glContext || ![EAGLContext setCurrentContext:_glContext]) {
        return NO;
    }
    
    if (![self setupYUVTexture]) {
        return NO;
    }
    
    _displayMode = DisplayMode_PanAndScan;
    
    [self loadShader];
    
    glPixelStorei(GL_UNPACK_ALIGNMENT, 1);
    
    glUseProgram(_program);

    GLuint textureUniformY = glGetUniformLocation(_program, "SamplerY");
    GLuint textureUniformU = glGetUniformLocation(_program, "SamplerU");
    GLuint textureUniformV = glGetUniformLocation(_program, "SamplerV");

    glUniform1i(textureUniformY, 0);
    glUniform1i(textureUniformU, 1);
    glUniform1i(textureUniformV, 2);
    
    pthread_mutex_init(&_lock, NULL);
    
    return YES;
}


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        if (![self doInit]) {
            self = nil;
        }
        _boundSize = frame.size;
    }
    
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        if (![self doInit]) {
            self = nil;
        }
    }
    
    return self;
}

- (void)destoryFrameAndRenderBuffer
{
    if (_framebuffer)
    {
        glDeleteFramebuffers(1, &_framebuffer);
    }
    
    if (_renderBuffer)
    {
        glDeleteRenderbuffers(1, &_renderBuffer);
    }
    
    _framebuffer = 0;
    _renderBuffer = 0;
}

- (BOOL)setupYUVTexture{
    
    if (_textureYUV[TEXY]) {
        glDeleteTextures(3, _textureYUV);
    }
    
    glGenTextures(3, _textureYUV);
    if (!_textureYUV[TEXY] || !_textureYUV[TEXU] || !_textureYUV[TEXV]) {
        return NO;
    }
    
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, _textureYUV[TEXY]);
    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    
    glActiveTexture(GL_TEXTURE1);
    glBindTexture(GL_TEXTURE_2D, _textureYUV[TEXU]);
    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    
    glActiveTexture(GL_TEXTURE2);
    glBindTexture(GL_TEXTURE_2D, _textureYUV[TEXV]);
    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    return YES;
}

#define FSH @"varying lowp vec2 TexCoordOut;\
\
uniform sampler2D SamplerY;\
uniform sampler2D SamplerU;\
uniform sampler2D SamplerV;\
\
void main(void)\
{\
mediump vec3 yuv;\
lowp vec3 rgb;\
\
yuv.x = texture2D(SamplerY, TexCoordOut).r;\
yuv.y = texture2D(SamplerU, TexCoordOut).r - 0.5;\
yuv.z = texture2D(SamplerV, TexCoordOut).r - 0.5;\
\
rgb = mat3( 1,       1,         1,\
0,       -0.39465,  2.03211,\
1.13983, -0.58060,  0) * yuv;\
\
gl_FragColor = vec4(rgb, 1);\
\
}"

#define VSH @"attribute vec4 position;\
attribute vec2 TexCoordIn;\
varying vec2 TexCoordOut;\
\
void main(void)\
{\
gl_Position = position;\
TexCoordOut = TexCoordIn;\
}"

- (void)loadShader {
    GLuint vertexShader = [self compileShader:VSH withType:GL_VERTEX_SHADER];
    GLuint fragmentShader = [self compileShader:FSH withType:GL_FRAGMENT_SHADER];
    
    _program = glCreateProgram();
    glAttachShader(_program, vertexShader);
    glAttachShader(_program, fragmentShader);
    
    glBindAttribLocation(_program, ATTRIB_VERTEX, "position");
    glBindAttribLocation(_program, ATTRIB_TEXTURE, "TexCoordIn");
    
    glLinkProgram(_program);
    
    GLint linkSuccess;
    glGetProgramiv(_program, GL_LINK_STATUS, &linkSuccess);
    if (linkSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetProgramInfoLog(_program, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"<<<<shader link fail %@>>>", messageString);
        //        exit(1);
    }
    
    if (vertexShader)
        glDeleteShader(vertexShader);
    if (fragmentShader)
        glDeleteShader(fragmentShader);
}

- (GLuint)compileShader:(NSString*)shaderString withType:(GLenum)shaderType
{
    if (!shaderString) {
        exit(1);
    }
    
    GLuint shaderHandle = glCreateShader(shaderType);
    
    const char * shaderStringUTF8 = [shaderString UTF8String];
    int shaderStringLength = (int)[shaderString length];
    glShaderSource(shaderHandle, 1, &shaderStringUTF8, &shaderStringLength);
    
    glCompileShader(shaderHandle);
    GLint compileSuccess;
    
    glGetShaderiv(shaderHandle, GL_COMPILE_STATUS, &compileSuccess);
    if (compileSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetShaderInfoLog(shaderHandle, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messageString);
        exit(1);
    }
    
    return shaderHandle;
}

-(void)layoutSubviews{
     [super layoutSubviews];
    _boundSize = self.frame.size;
    dispatch_async(dispatch_get_main_queue(), ^{
        pthread_mutex_lock(&_lock);
        [EAGLContext setCurrentContext:_glContext];
        [self destoryFrameAndRenderBuffer];
        [self createFrameAndRenderBuffer];
        pthread_mutex_unlock(&_lock);
        glViewport(1, 1, self.bounds.size.width*_viewScale - 2, self.bounds.size.height*_viewScale - 2);
    });
    
    for (UIView *subView in self.subviews) {
        if (subView.tag == kBackgroudTag) {
            subView.frame = self.bounds;
        }
        
        if (subView.tag == kEmojiTag) {
            subView.frame = CGRectMake(self.bounds.size.width * 0.25, self.bounds.size.height * 0.25, self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
        }
    }
}

#pragma mark - opengl setting -
+ (Class)layerClass
{
    return [CAEAGLLayer class];
}

- (BOOL)createFrameAndRenderBuffer
{
    glGenFramebuffers(1, &_framebuffer);
    glGenRenderbuffers(1, &_renderBuffer);
    
    glBindFramebuffer(GL_FRAMEBUFFER, _framebuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _renderBuffer);

    if (![_glContext renderbufferStorage:GL_RENDERBUFFER fromDrawable:(CAEAGLLayer *)self.layer]) {
        NSLog(@"attach render buffer fail");
    }
    
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _renderBuffer);
    
    if (glCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE)
    {
        NSLog(@"creat frame buffer fail. 0x%x", glCheckFramebufferStatus(GL_FRAMEBUFFER));
        return NO;
    }
    return YES;
}

#pragma mark - interface -
-(void)setVideoWidth:(GLuint)width height:(GLuint)height{
    _videoH = height;
    _videoW = width;
    
    void *blackData = malloc((width * height * 3 + 1) / 2);
    if (blackData) {
        memset(blackData, 0x0, (width * height * 3 + 1) / 2);
    }
    
    [EAGLContext setCurrentContext:_glContext];
    
    glBindTexture(GL_TEXTURE_2D, _textureYUV[TEXY]);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RED_EXT, width, height, 0, GL_RED_EXT, GL_UNSIGNED_BYTE, blackData);
    
    glBindTexture(GL_TEXTURE_2D, _textureYUV[TEXU]);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RED_EXT, (width + 1)/2, (height + 1)/2, 0, GL_RED_EXT, GL_UNSIGNED_BYTE, blackData + width * height);
    
    glBindTexture(GL_TEXTURE_2D, _textureYUV[TEXV]);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RED_EXT, (width + 1)/2, (height + 1)/2, 0, GL_RED_EXT, GL_UNSIGNED_BYTE, blackData + (width * height * 5 + 1)/ 4);
    
    free(blackData);
}

- (void)clearFrame{
    if ([self window])
    {
        pthread_mutex_lock(&_lock);
        [EAGLContext setCurrentContext:_glContext];
        glClearColor(0.0, 0.0, 0.0, 1.0);
        glClear(GL_COLOR_BUFFER_BIT);
        glBindRenderbuffer(GL_RENDERBUFFER, _renderBuffer);
        [_glContext presentRenderbuffer:GL_RENDERBUFFER];
        pthread_mutex_unlock(&_lock);
    }
}

- (void)displayYUV:(MobileRTCVideoRawData *)rawData mode:(DisplayMode)mode
{
    int w = (int)rawData.size.width;
    int h = (int)rawData.size.height;

    pthread_mutex_lock(&_lock);
        if (w != _videoW || h != _videoH) {
            [self setVideoWidth:(GLuint)w height:(GLuint)h];
        }
        if (mode != _displayMode) {
            _displayMode = mode;
//            [self clearFrame];
        }
        
        [EAGLContext setCurrentContext:_glContext];
        
        glBindTexture(GL_TEXTURE_2D, _textureYUV[TEXY]);
        glTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, (GLsizei)w, (GLsizei)h, GL_RED_EXT, GL_UNSIGNED_BYTE, rawData.yBuffer);
        
        glBindTexture(GL_TEXTURE_2D, _textureYUV[TEXU]);
        glTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, (GLsizei)(w + 1)/2, (GLsizei)(h + 1)/2, GL_RED_EXT, GL_UNSIGNED_BYTE, rawData.uBuffer);

        glBindTexture(GL_TEXTURE_2D, _textureYUV[TEXV]);
        glTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, (GLsizei)(w + 1)/2, (GLsizei)(h + 1)/2, GL_RED_EXT, GL_UNSIGNED_BYTE, rawData.vBuffer);
        
        [self renderWithRotate:rawData.rotation size:rawData.size andMode:mode];
    pthread_mutex_unlock(&_lock);

#ifdef DEBUG
    
//    GLenum err = glGetError();
//    if (err != GL_NO_ERROR)
//    {
//        printf("GL_ERROR=======>%d\n", err);
//    }
//    struct timeval nowtime;
//    gettimeofday(&nowtime, NULL);
//    if (nowtime.tv_sec != _time.tv_sec)
//    {
//        printf("视频 %ld 帧率:   %ld\n", self.tag, (long)_frameRate);
//        memcpy(&_time, &nowtime, sizeof(struct timeval));
//        _frameRate = 1;
//    }
//    else
//    {
//        _frameRate++;
//    }
#endif
}


-(void)renderWithRotate:(MobileRTCVideoRawDataRotation)rotate size:(CGSize)rawSize andMode:(DisplayMode)mode {
    
    glClearColor(0.0, 0.0, 0.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    
    [EAGLContext setCurrentContext:_glContext];
    CGSize size = _boundSize;
    glViewport(1, 1, size.width * _viewScale -2, size.height * _viewScale -2);

    static const GLfloat coordVertices[] = {
        0.0f, 1.0f,
        1.0f, 1.0f,
        0.0f,  0.0f,
        1.0f,  0.0f,
    };
    
    glVertexAttribPointer(ATTRIB_TEXTURE, 2, GL_FLOAT, 0, 0, coordVertices);
    glEnableVertexAttribArray(ATTRIB_TEXTURE);
    
    CGSize cropSize = [self cropSizeWithRawSize:rawSize andModel:mode rotate:rotate];
    
    switch (rotate) {
        case MobileRTCVideoRawDataRotationNone: {
            GLfloat squareVertices[] = {
                1.0 * cropSize.width, -1.0 * cropSize.height,
                -1.0 * cropSize.width, -1.0 * cropSize.height,
                1.0 * cropSize.width,  1.0 * cropSize.height,
                -1.0 * cropSize.width,  1.0 * cropSize.height,
            };
            glVertexAttribPointer(ATTRIB_VERTEX, 2, GL_FLOAT, 0, 0, squareVertices);
            glEnableVertexAttribArray(ATTRIB_VERTEX);
        }
            break;
        case MobileRTCVideoRawDataRotation90: {
            GLfloat squareVertices[] = {
                -1.0 * cropSize.width,  1.0 * cropSize.height,
                -1.0 * cropSize.width, -1.0 * cropSize.height,
                1.0 * cropSize.width,  1.0 * cropSize.height,
                1.0 * cropSize.width, -1.0 * cropSize.height,
            };
            glVertexAttribPointer(ATTRIB_VERTEX, 2, GL_FLOAT, 0, 0, squareVertices);
            glEnableVertexAttribArray(ATTRIB_VERTEX);
        }
            break;
        case MobileRTCVideoRawDataRotation180: {
            GLfloat squareVertices[] = {
                1.0 * cropSize.width, 1.0 * cropSize.height,
                -1.0 * cropSize.width,  1.0 * cropSize.height,
                1.0 * cropSize.width, -1.0 * cropSize.height,
                -1.0 * cropSize.width,  -1.0 * cropSize.height,
            };
            glVertexAttribPointer(ATTRIB_VERTEX, 2, GL_FLOAT, 0, 0, squareVertices);
            glEnableVertexAttribArray(ATTRIB_VERTEX);
        }
            break;
        case MobileRTCVideoRawDataRotation270: {
            GLfloat squareVertices[] = {
                1.0 * cropSize.width, -1.0 * cropSize.height,
                1.0 * cropSize.width, 1.0 * cropSize.height,
                -1.0 * cropSize.width,  -1.0 * cropSize.height,
                -1.0  * cropSize.width, 1.0 * cropSize.height,
            };
            glVertexAttribPointer(ATTRIB_VERTEX, 2, GL_FLOAT, 0, 0, squareVertices);
            glEnableVertexAttribArray(ATTRIB_VERTEX);
        }
            break;
        default:
            break;
    }
    
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    
    glBindRenderbuffer(GL_RENDERBUFFER, _renderBuffer);
    
    [_glContext presentRenderbuffer:GL_RENDERBUFFER];
}

- (CGSize)cropSizeWithRawSize:(CGSize)rawSize andModel:(DisplayMode)mode rotate:(MobileRTCVideoRawDataRotation)rotate {
    
    CGSize displaySize = _boundSize;
    CGSize cropSize = CGSizeMake(0.0, 0.0);
    CGSize sourceSize = CGSizeMake(rawSize.width, rawSize.height);
    if (rotate == MobileRTCVideoRawDataRotation90 || rotate == MobileRTCVideoRawDataRotation270) {
        sourceSize = CGSizeMake(rawSize.height, rawSize.width);
    }
    CGSize cropScale = CGSizeMake(sourceSize.width/displaySize.width, sourceSize.height/displaySize.height);
    
    if (mode == DisplayMode_PanAndScan) {
        if (cropScale.width > cropScale.height) {
            cropSize.height = 1.0;
            cropSize.width = cropScale.width/cropScale.height;
        }
        else {
            cropSize.width = 1.0;
            cropSize.height = cropScale.height/cropScale.width;
        }
    } else if (mode == DisplayMode_LetterBox) {
        if (cropScale.width > cropScale.height) {
            cropSize.width = 1.0;
            cropSize.height = cropScale.height/cropScale.width;
        }
        else {
            cropSize.height = 1.0;
            cropSize.width = cropScale.width/cropScale.height;
        }
    }

    return cropSize;
}

- (void)dealloc {

    NSLog(@"gl dealloc");
    [self clearFrame];
//    _glContext = nil;
    [self destoryFrameAndRenderBuffer];
    
    pthread_mutex_destroy(&_lock);
}

- (void)addAvatar {
    UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
    bgView.backgroundColor = RGBCOLOR(0x23, 0x23, 0x23);
    bgView.tag = kBackgroudTag;
    [self addSubview:bgView];
    [self sendSubviewToBack:bgView];
    
    NSString *imageName = [NSString stringWithFormat:@"default_avatar"];
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *view = [[UIImageView alloc] initWithImage:image];
    view.frame = CGRectMake(self.bounds.size.width * 0.25, self.bounds.size.height * 0.25, self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    view.contentMode = UIViewContentModeScaleAspectFit;
    view.tag = kEmojiTag;
    [self addSubview:view];
}

- (void)removeAvatar {
    NSMutableArray *needRemove = [NSMutableArray new];
    for (UIView *view in [self subviews]) {
        if (view.tag == kEmojiTag) {
            [needRemove addObject:view];
        }
        if (view.tag == kBackgroudTag) {
            [needRemove addObject:view];
        }
    }
    [needRemove makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

@end
