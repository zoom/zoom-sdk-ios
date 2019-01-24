//
//  AnnoFloatBarView.m
//  MobileRTCSample
//
//  Created by Chao Bai on 2018/6/12.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import "AnnoFloatBarView.h"

@interface AnnoFloatBarView ()

@property (strong, nonatomic) UIButton *switchBtn;
@property (assign, nonatomic) CGPoint  oldPoint;
@property (assign, nonatomic) BOOL isAnnotate;
@property (strong, nonatomic) NSMutableArray *itemArray;

@property (strong, nonatomic) UIButton *colorButton;

@end

@implementation AnnoFloatBarView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initSubView];
        _isAnnotate = NO;
    }
    return self;
}

- (id)initWithCoder:(NSCoder*)coder
{
    if (self = [super initWithCoder:coder])
    {
        [self initSubView];
        _isAnnotate = NO;
    }
    return self;
}

- (void)dealloc
{
    _switchBtn= nil;
    _delegate = nil;
    _colorButton = nil;
    [_itemArray removeAllObjects];
    _itemArray = nil;
    [super dealloc];
}

- (void)initSubView
{
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    UIImage *image = [UIImage imageNamed:@"icon_mainicon_normal"];
    self.switchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.switchBtn.frame = CGRectMake(5.0, 0.0, image.size.width, image.size.height);
    [self.switchBtn setBackgroundImage:[UIImage imageNamed:@"icon_mainicon_normal"] forState:UIControlStateNormal];
    [self.switchBtn setBackgroundImage:[UIImage imageNamed:@"icon_mainicon_pressed"] forState:UIControlStateSelected];
    [self.switchBtn addTarget:self action:@selector(onActionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.switchBtn setAccessibilityLabel:NSLocalizedString(@"Annotation Bar", @"")];
    [self addSubview:self.switchBtn];

    //add pan gesture
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    panGesture.maximumNumberOfTouches = 1;
    panGesture.minimumNumberOfTouches = 1;
    [self addGestureRecognizer:panGesture];
    [panGesture release];
}

- (void)hideActionView {
    self.backgroundColor = [UIColor clearColor];
    [self.switchBtn setSelected:NO];
    
    for (UIButton *itemBtn in self.itemArray) {
        [itemBtn removeFromSuperview];
    }
    
    [self.itemArray removeAllObjects];
}

- (void)showActionView {
    
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
    
    self.itemArray = [NSMutableArray array];
    [self.switchBtn setSelected:YES];
    
    CGSize iconSize = IS_IPAD?CGSizeMake(51, 49):CGSizeMake(51, 45);
    
    UIImage *image = [UIImage imageNamed:@"icon_mainicon_normal"];
    UIButton *penButton = [UIButton buttonWithType:UIButtonTypeCustom];
    penButton.frame = CGRectMake(image.size.width + 5, 5, iconSize.width, iconSize.height);
    [penButton setImage:[UIImage imageNamed:@"anno_icon_pen"] forState:UIControlStateNormal];
    [penButton setImage:[UIImage imageNamed:@"anno_icon_pen_selected"] forState:UIControlStateSelected];
    [penButton addTarget:self action:@selector(onPenButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [penButton setTitle:@"Pen" forState:UIControlStateNormal];
    penButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10];
    [self layoutSubViewsInCenter:0.0 byParentView:penButton];
    [self addSubview:penButton];
    [self.itemArray addObject:penButton];
    
    UIButton *highlightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    highlightButton.frame = penButton.frame;
    highlightButton.frame = CGRectOffset(penButton.frame, iconSize.width, 0);
    [highlightButton setImage:[UIImage imageNamed:@"anno_icon_highlight"] forState:UIControlStateNormal];
    [highlightButton setImage:[UIImage imageNamed:@"anno_icon_highlight_selected"] forState:UIControlStateSelected];
    [highlightButton addTarget:self action:@selector(onHighlightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [highlightButton setTitle:@"HighLight" forState:UIControlStateNormal];
    highlightButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10];
    [self layoutSubViewsInCenter:0.0 byParentView:highlightButton];
    [self addSubview:highlightButton];
    [self.itemArray addObject:highlightButton];
    
    UIButton *sportlightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sportlightButton setImage:[UIImage imageNamed:@"anno_icon_spotlight"] forState:UIControlStateNormal];
    [sportlightButton setImage:[UIImage imageNamed:@"anno_icon_spotlight_selected"] forState:UIControlStateSelected];
    sportlightButton.frame = highlightButton.frame;
    sportlightButton.frame = CGRectOffset(highlightButton.frame, iconSize.width, 0);
    [sportlightButton addTarget:self action:@selector(onSpotlightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [sportlightButton setTitle:@"SportLight" forState:UIControlStateNormal];
    sportlightButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10];
    [self layoutSubViewsInCenter:0.0 byParentView:sportlightButton];
    [self addSubview:sportlightButton];
    [self.itemArray addObject:sportlightButton];
    
    MobileRTCAnnotationService *annoService = [[MobileRTC sharedRTC] getAnnotationService];
    UIColor *toolColor = [annoService getToolColor:MobileRTCAnnoTool_Pen];
    UIImage *back = [self imageWithColor:[UIColor clearColor] size:CGSizeMake(20, 20) andRoundSize:0];
    UIImage *top = [self imageWithColor:toolColor size:CGSizeMake(20, 20) andRoundSize:10];
    UIImage *colorBtnImage = [self mergeTwoImages:top bottomImage:back];
    
    UIButton *colorButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [colorButton setImage:colorBtnImage forState:UIControlStateNormal];
    [colorButton setImage:colorBtnImage forState:UIControlStateSelected];
    colorButton.frame = sportlightButton.frame;
    colorButton.frame = CGRectOffset(sportlightButton.frame, iconSize.width, 0);
    [colorButton addTarget:self action:@selector(onColorButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [colorButton setTitle:@"Color" forState:UIControlStateNormal];
    colorButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10];
    [self layoutSubViewsInCenter:0.0 byParentView:colorButton];
    [self addSubview:colorButton];
    [self.itemArray addObject:colorButton];
    self.colorButton = colorButton;
    
    
    
    UIButton *widthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [widthButton setImage:[UIImage imageNamed:@"anno_icon_spotlight"] forState:UIControlStateNormal];
    [widthButton setImage:[UIImage imageNamed:@"anno_icon_spotlight_selected"] forState:UIControlStateSelected];
    widthButton.frame = penButton.frame;
    widthButton.frame = CGRectOffset(penButton.frame, 0, iconSize.height);
    [widthButton addTarget:self action:@selector(onWidthButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [widthButton setTitle:@"Width" forState:UIControlStateNormal];
    widthButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10];
    [self layoutSubViewsInCenter:0.0 byParentView:widthButton];
    [self addSubview:widthButton];
    [self.itemArray addObject:widthButton];
    
    UIButton *undoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [undoButton setImage:[UIImage imageNamed:@"anno_icon_undo"] forState:UIControlStateNormal];
    [undoButton setImage:[UIImage imageNamed:@"anno_icon_undo_selected"] forState:UIControlStateSelected];
    undoButton.frame = widthButton.frame;
    undoButton.frame = CGRectOffset(widthButton.frame, iconSize.width, 0);
    [undoButton addTarget:self action:@selector(onUndoButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [undoButton setTitle:@"Undo" forState:UIControlStateNormal];
    undoButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10];
    [self layoutSubViewsInCenter:0.0 byParentView:undoButton];
    [self addSubview:undoButton];
    [self.itemArray addObject:undoButton];
    
    UIButton *redoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [redoButton setImage:[UIImage imageNamed:@"anno_icon_redo"] forState:UIControlStateNormal];
    [redoButton setImage:[UIImage imageNamed:@"anno_icon_redo_selected"] forState:UIControlStateSelected];
    redoButton.frame = undoButton.frame;
    redoButton.frame = CGRectOffset(undoButton.frame, iconSize.width, 0);
    [redoButton addTarget:self action:@selector(onRedoButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [redoButton setTitle:@"Redo" forState:UIControlStateNormal];
    redoButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10];
    [self layoutSubViewsInCenter:0.0 byParentView:redoButton];
    [self addSubview:redoButton];
    [self.itemArray addObject:redoButton];
    
    UIButton *cleanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cleanButton setImage:[UIImage imageNamed:@"anno_icon_clear"] forState:UIControlStateNormal];
    [cleanButton setImage:[UIImage imageNamed:@"anno_icon_clear_selected"] forState:UIControlStateSelected];
    cleanButton.frame = redoButton.frame;
    cleanButton.frame = CGRectOffset(redoButton.frame, iconSize.width, 0);
    [cleanButton addTarget:self action:@selector(onCleanButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cleanButton setTitle:@"Clean" forState:UIControlStateNormal];
    cleanButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10];
    [self layoutSubViewsInCenter:0.0 byParentView:cleanButton];
    [self addSubview:cleanButton];
    [self.itemArray addObject:cleanButton];
    
    UIButton *eraseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [eraseButton setImage:[UIImage imageNamed:@"anno_icon_erase"] forState:UIControlStateNormal];
    [eraseButton setImage:[UIImage imageNamed:@"anno_icon_erase_selected"] forState:UIControlStateSelected];
    eraseButton.frame = cleanButton.frame;
    eraseButton.frame = CGRectOffset(cleanButton.frame, iconSize.width, 0);
    [eraseButton addTarget:self action:@selector(onEraseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [eraseButton setTitle:@"Erase" forState:UIControlStateNormal];
    eraseButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10];
    [self layoutSubViewsInCenter:0.0 byParentView:eraseButton];
    [self addSubview:eraseButton];
    [self.itemArray addObject:eraseButton];
}

- (void)handlePanGesture:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        _oldPoint = [gestureRecognizer locationInView: gestureRecognizer.view];
        return;
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        return;
    }
    
    [self locateUI:[gestureRecognizer locationInView: gestureRecognizer.view]];
}

- (void)locateUI:(CGPoint)newPoint
{
    CGFloat dx = newPoint.x - _oldPoint.x;
    CGFloat dy = newPoint.y - _oldPoint.y;
    
    CGPoint newCenter = CGPointMake(self.center.x+dx, self.center.y+dy);
    
    self.center = newCenter;
    [self setNeedsLayout];
}

- (void)onPenButtonClicked:(id)sender
{
    MobileRTCAnnotationService *annoService = [[MobileRTC sharedRTC] getAnnotationService];
    if (annoService)
    {
        [annoService setToolType:MobileRTCAnnoTool_Pen];
    }
}

- (void)onHighlightButtonClicked:(id)sender
{
    MobileRTCAnnotationService *annoService = [[MobileRTC sharedRTC] getAnnotationService];
    if (annoService)
    {
        if ([annoService isPresenter])
        {
            [annoService setToolType:MobileRTCAnnoTool_Highligher];
        }
        else
        {
            [annoService setToolType:MobileRTCAnnoTool_Arrow2];
        }
    }
}

- (void)onSpotlightButtonClicked:(id)sender {
    MobileRTCAnnotationService *annoService = [[MobileRTC sharedRTC] getAnnotationService];
    if (annoService)
    {
        if ([annoService isPresenter])
        {
            [annoService setToolType:MobileRTCAnnoTool_Spotlight];
        }
        else
        {
            [annoService setToolType:MobileRTCAnnoTool_Arrow2];
        }
    }
}

#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), 1.0)
- (void)onColorButtonClicked:(id)sendor {
    MobileRTCAnnotationService *annoService = [[MobileRTC sharedRTC] getAnnotationService];
    [annoService setToolColor:randomColor];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIColor *color = [annoService getToolColor:MobileRTCAnnoTool_Pen];
        UIImage *back = [self imageWithColor:[UIColor clearColor] size:CGSizeMake(20, 20) andRoundSize:0];
        UIImage *top = [self imageWithColor:color size:CGSizeMake(20, 20) andRoundSize:10];
        UIImage *colorBtnImage = [self mergeTwoImages:top bottomImage:back];
        [self.colorButton setImage:colorBtnImage forState:UIControlStateNormal];
        [self.colorButton setImage:colorBtnImage forState:UIControlStateSelected];
    });
}

- (void)onActionButtonClicked:(id)sender
{
    if (self.delegate)
    {
        if (!self.isAnnotate)
        {
            if ([self.delegate respondsToSelector:@selector(onClickStartAnnotate)])
            {
                if ([self.delegate onClickStartAnnotate])
                {
                    [self showActionView];
                    self.isAnnotate = !self.isAnnotate;
                }
            }
        }
        else
        {
            if ([self.delegate respondsToSelector:@selector(onClickStopAnnotate)])
            {
                if ([self.delegate onClickStopAnnotate])
                {
                    [self hideActionView];
                    self.isAnnotate = !self.isAnnotate;
                }
            }
        }
    }
}

- (void)onWidthButtonClicked:(id)sender {
    MobileRTCAnnotationService *annoService = [[MobileRTC sharedRTC] getAnnotationService];
    if (annoService)
    {
        [annoService setToolWidth:3.0];
    }
}

- (void)onEraseButtonClicked:(id)sender
{
    MobileRTCAnnotationService *annoService = [[MobileRTC sharedRTC] getAnnotationService];
    if (annoService)
    {
        [annoService setToolType:MobileRTCAnnoTool_Eraser];
    }
}

- (void)onCleanButtonClicked:(id)sender {
    MobileRTCAnnotationService *annoService = [[MobileRTC sharedRTC] getAnnotationService];
    if (annoService)
    {
        [annoService clear];
    }
}

- (void)onUndoButtonClicked:(id)sender {
    MobileRTCAnnotationService *annoService = [[MobileRTC sharedRTC] getAnnotationService];
    if (annoService)
    {
        [annoService undo];
    }
}

- (void)onRedoButtonClicked:(id)sender {
    MobileRTCAnnotationService *annoService = [[MobileRTC sharedRTC] getAnnotationService];
    if (annoService)
    {
        [annoService redo];
    }
}

- (void)stopAnnotate
{
    self.hidden = YES;
    if (self.isAnnotate)
    {
        self.isAnnotate = !self.isAnnotate;
        [self onActionButtonClicked:nil];
    }
}

- (void)layoutSubViewsInCenter:(CGFloat)space byParentView:(UIButton *)button
{
    // get the size of the elements here for readability
    CGSize imageSize = button.imageView.frame.size;
    CGSize titleSize = button.titleLabel.intrinsicContentSize;
    
    // lower the text and push it left to center it
    button.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, -(imageSize.height + space), 0.0);
    
    // raise the image and push it right to center it
    button.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + space), 0.0, 0.0, -titleSize.width);
    
    // center image
    CGPoint center = button.imageView.center;
    center.x = button.frame.size.width / 2;
    button.imageView.center = center;
}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size andRoundSize:(CGFloat)roundSize {
    if (!color)
        return nil;
    
    size = CGSizeMake(floor(size.width), floor(size.height));
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (roundSize > 0) {
        UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius: roundSize];
        [color setFill];
        [roundedRectanglePath fill];
    } else {
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextFillRect(context, rect);
        
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage*)mergeTwoImages:(UIImage*)topImage bottomImage:(UIImage*)bottomImage
{
    int bwidth = bottomImage.size.width;
    int bheight = bottomImage.size.height;
    int twidth = topImage.size.width;
    int theight = topImage.size.height;
    int xoffset = (bwidth - twidth) / 2;
    int yoffset = (bheight - theight) / 2;
    
    CGSize size = CGSizeMake(bwidth, bheight);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [bottomImage drawInRect:CGRectMake(0,0,bwidth,bheight)];
    [topImage drawInRect:CGRectMake(xoffset,yoffset,twidth,theight) blendMode:kCGBlendModeMultiply alpha:1.0];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
