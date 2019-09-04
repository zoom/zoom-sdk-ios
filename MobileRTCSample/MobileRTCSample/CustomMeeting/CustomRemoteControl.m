//
//  CustomRemoteControl.m
//  MobileRTCSample
//
//  Created by Murray Li on 2018/6/26.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import "CustomRemoteControl.h"

@implementation RemoteControlBar

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initSubView];
    }
    return self;
}

- (void)dealloc
{
    self.action= nil;
    [super dealloc];
}

- (void)initSubView
{
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    
    UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [actionButton setTitle:@"grap" forState:UIControlStateNormal];
    [actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [actionButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    actionButton.frame = CGRectMake(5, 5, 80, 40);
    [actionButton addTarget:self action:@selector(onActionButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:actionButton];
    self.action = actionButton;
    actionButton.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    
    UIButton *inputButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [inputButton setTitle:@"input" forState:UIControlStateNormal];
    [inputButton setTintColor:[UIColor whiteColor] ];
    inputButton.frame = CGRectMake(90, 5, 80, 40);
    [inputButton addTarget:self action:@selector(onActionInputClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:inputButton];
    inputButton.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
}

- (void)onActionButtonClicked
{
    if ([self.delegate respondsToSelector:@selector(onClickGrap)])
    {
        [self.delegate onClickGrap];
    }
}

- (void)onActionInputClicked
{
    if ([self.delegate respondsToSelector:@selector(onClickInput)])
    {
        [self.delegate onClickInput];
    }
}

@end

typedef enum
{
    DragMode_Unknown,
    DragMode_Start,
    DragMode_Drag,
    DragMode_End,
}DragModeStatus;

@interface CustomRemoteControl () <MobileRTCRemoteControlDelegate, RemoteControlBarDelegate, UITextViewDelegate>
@property (strong, nonatomic) RemoteControlBar              *remoteContrlBar;
@property (nonatomic, strong) MobileRTCActiveShareView      *remoteShareView;
@property (strong, nonatomic) UIView                        *coverView;
@property (strong, nonatomic) UIScrollView                  *scrollView;
@property (strong, nonatomic) UIButton                      *mouseButton;
@property (strong, nonatomic) UITextView                    *keyboardView;
@property (strong, nonatomic) NSString                      *inputText;
@end

@implementation CustomRemoteControl
{
    NSTimeInterval prevMouseDragTime;
    DragModeStatus dragStatus;
}

- (void)dealloc
{
    self.remoteContrlBar = nil;
    self.remoteShareView = nil;
    self.scrollView = nil;
    self.coverView = nil;
    self.mouseButton = nil;
    self.keyboardView = nil;
    self.inputText = nil;
    [super dealloc];
}

- (void)setupRemoteControl:(UIView *)remoteShareView
{
    self.remoteShareView = remoteShareView;
    [self initSubView];
    [self initSerVice];
}

- (void)initSubView
{
    self.remoteContrlBar = [[RemoteControlBar alloc] initWithFrame:CGRectMake(50, SCREEN_HEIGHT-200,175, 50)];
    self.remoteContrlBar.delegate = self;
    [self.remoteShareView addSubview:self.remoteContrlBar];
    self.remoteContrlBar.hidden = YES;
    
    UIButton * mouseButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-60)/2, (SCREEN_HEIGHT-30)/2, 60, 30)];
    [mouseButton setTitle:@"mouse" forState:UIControlStateNormal];
    mouseButton.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
    [mouseButton addTarget: self action: @selector(onMouseButtonTouchDrag:withEvent:) forControlEvents: UIControlEventTouchDragInside];
    [mouseButton addTarget: self action: @selector(onMouseButtonTouchUp:withEvent:) forControlEvents: UIControlEventTouchUpInside];
    [mouseButton addTarget: self action: @selector(onMouseButtonTouchDrag:withEvent:) forControlEvents: UIControlEventTouchDragOutside];
    [mouseButton addTarget: self action: @selector(onMouseButtonTouchUp:withEvent:) forControlEvents: UIControlEventTouchUpOutside];
    self.mouseButton = mouseButton;
    [self.remoteShareView addSubview:self.mouseButton];
    self.mouseButton.hidden = YES;
    
    UITextView * keyboardView = [[UITextView alloc] init];
    keyboardView.delegate = self;
    self.keyboardView = keyboardView;
    [self.remoteShareView addSubview:self.keyboardView];
    
}

- (void)initSerVice
{
    MobileRTCRemoteControlService * ms = [[MobileRTC sharedRTC] getRemoteControlService];
    ms.delegate = self;
}

- (void)initGesture
{
    UILongPressGestureRecognizer *mousePress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleMousePressGesture:)];
    mousePress.minimumPressDuration = 1;
    mousePress.numberOfTouchesRequired = 1;
    mousePress.cancelsTouchesInView = NO;
    [self.mouseButton addGestureRecognizer:mousePress];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleShareTap:)];
    doubleTap.numberOfTapsRequired = 2;
    doubleTap.numberOfTouchesRequired = 1;
    [self.coverView addGestureRecognizer:doubleTap];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleShareTap:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    [self.coverView addGestureRecognizer:singleTap];
    
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
    longPress.minimumPressDuration = 1;
    longPress.numberOfTouchesRequired = 1;
    [self.coverView addGestureRecognizer:longPress];
    
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    panGesture.maximumNumberOfTouches = 2;
    panGesture.minimumNumberOfTouches = 2;
    [self.scrollView addGestureRecognizer:panGesture];
    
}
#pragma mark - Action
- (void)onMouseButtonTouchDrag:(UIButton *)button withEvent:(UIEvent *)event
{
    MobileRTCRemoteControlService * ms = [[MobileRTC sharedRTC] getRemoteControlService];
    
    // get the touch
    UITouch *touch = [[event touchesForView:button] anyObject];
    
    // get delta
    CGPoint previousLocation = [touch previousLocationInView:button];
    CGPoint location = [touch locationInView:button];
    CGFloat delta_x = location.x - previousLocation.x;
    CGFloat delta_y = location.y - previousLocation.y;
    
    CGPoint btnPoint = CGPointMake(self.mouseButton.center.x + delta_x, self.mouseButton.center.y + delta_y);
    CGPoint mousePoint = CGPointMake(btnPoint.x, btnPoint.y - 40);
    {
        self.mouseButton.center = btnPoint;
        mousePoint = [[button superview] convertPoint:mousePoint toView:self.remoteShareView];
        if ((touch.timestamp - prevMouseDragTime) * 1000 > 50)
        {
            [ms remoteControlSingleMove:mousePoint];
            prevMouseDragTime = touch.timestamp;
        }
    }
    
    switch (dragStatus) {
        case DragMode_Start:
        {
            dragStatus = DragMode_Drag;
            [ms remoteControlMouseLeftDown:mousePoint];
            NSLog(@"remoteControlMouseLeftDrag start %@", NSStringFromCGPoint(mousePoint));
        }
            break;
            
        case DragMode_Drag:
        {
            [ms remoteControlMouseLeftDrag:mousePoint];
            NSLog(@"remoteControlMouseLeftDrag drag %@", NSStringFromCGPoint(mousePoint));
        }
            break;
            
        case DragMode_End:
        {
            dragStatus = DragMode_Unknown;
            [ms remoteControlMouseLeftUp:mousePoint];
            NSLog(@"remoteControlMouseLeftDrag end %@", NSStringFromCGPoint(mousePoint));
        }
            break;
            
        default:
            break;
    }
}

- (void)onMouseButtonTouchUp:(UIButton *)button withEvent:(UIEvent *)event
{
    prevMouseDragTime = 0;
    dragStatus = DragMode_End;
    
    [self onMouseButtonTouchDrag:button withEvent:event];
}

#pragma mark - UIGestureRecognizer Delegate
- (void)handleDoubleShareTap:(UIGestureRecognizer *)gestureRecognizer
{
    MobileRTCRemoteControlService * ms = [[MobileRTC sharedRTC] getRemoteControlService];
    if (![ms isRemoteController])return;
    
    CGPoint point = [gestureRecognizer locationInView: gestureRecognizer.view];
    NSLog(@"handleDoubletapGesture %@", NSStringFromCGPoint(point));
    [ms remoteControlDoubleTap:point];
}

- (void)handleMousePressGesture:(UIGestureRecognizer *)gestureRecognizer
{
    MobileRTCRemoteControlService * ms = [[MobileRTC sharedRTC] getRemoteControlService];
    if (![ms isRemoteController])return;
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        dragStatus = DragMode_Start;
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateEnded ||
             gestureRecognizer.state == UIGestureRecognizerStateFailed ||
             gestureRecognizer.state == UIGestureRecognizerStateCancelled)
    {
        dragStatus = DragMode_Unknown;
    }
}

- (void)handleSingleShareTap:(UIGestureRecognizer *)gestureRecognizer
{
    MobileRTCRemoteControlService * ms = [[MobileRTC sharedRTC] getRemoteControlService];
    if (![ms isRemoteController])return;
    
    CGPoint point = [gestureRecognizer locationInView: gestureRecognizer.view];
    NSLog(@"handleSingleShareTap %@", NSStringFromCGPoint(point));
    self.mouseButton.center = CGPointMake(point.x, point.y);
    [ms remoteControlSingleTap:point];
}

- (void)handleLongPressGesture:(UIGestureRecognizer *)gestureRecognizer
{
    MobileRTCRemoteControlService * ms = [[MobileRTC sharedRTC] getRemoteControlService];
    if (![ms isRemoteController])return;
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        CGPoint point = [gestureRecognizer locationInView: gestureRecognizer.view];
        NSLog(@"handleLongPressGesture %@", NSStringFromCGPoint(point));
        [ms remoteControlLongPress:point];
    }
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    MobileRTCRemoteControlService * ms = [[MobileRTC sharedRTC] getRemoteControlService];
    if (![ms isRemoteController])return;
    
    CGPoint velocity = [gestureRecognizer velocityInView: gestureRecognizer.view];
    
    if (fabs(velocity.x) > fabs(velocity.y))
    {
        if (velocity.x > 0)
        {
            NSLog(@"gesture go right");
        }
        else
        {
            NSLog(@"gesture go left");
        }
    }
    else if (fabs(velocity.x) < fabs(velocity.y))
    {
        {
            if (velocity.y > 0)
            {
                NSLog(@"gesture go down");
                [ms remoteControlDoubleScroll:CGPointMake(0, 1)];
            }
            else
            {
                NSLog(@"gesture go up");
                [ms remoteControlDoubleScroll:CGPointMake(0, -1)];
            }
        }
    }
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    MobileRTCRemoteControlService * ms = [[MobileRTC sharedRTC] getRemoteControlService];
    
    if (range.length > 0 && [text isEqualToString:@""]) {
        NSLog(@"press Backspace.");
        [ms remoteControlKeyInput:MobileRTCRemoteControl_Del];
    }
    else if ([text isEqualToString:@"\n"])
    {
        NSLog(@"press return.");
        [ms remoteControlKeyInput:MobileRTCRemoteControl_Return];
    }
    else {
        NSLog(@"text %@ range len %ld", text, range.length);
        if (range.length)
        {
            // if replace need reset inputText
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_8_0
            [self.ms remoteControlCharInput:text];
#endif
            self.inputText = nil;
        }
        else
        {
            // otherwise remember it
            self.inputText = text.length ? text : nil;
        }
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if (textView.markedTextRange)
    {
        self.inputText = [textView textInRange:textView.markedTextRange];
    }
#endif
    
    NSLog(@"mark %p, %@", textView.markedTextRange, self.inputText);
    
    if (textView.markedTextRange == nil && self.inputText)
    {
        MobileRTCRemoteControlService * ms = [[MobileRTC sharedRTC] getRemoteControlService];
        [ms remoteControlCharInput:self.inputText];
        self.inputText = nil;
    }
}


#pragma mark - RemoteControlBarDelegate Delegate
- (void)onClickGrap
{
    MobileRTCRemoteControlService * ms = [[MobileRTC sharedRTC] getRemoteControlService];
    if (![ms isRemoteController]) {
        MobileRTCRemoteControlService * ms = [[MobileRTC sharedRTC] getRemoteControlService];
        [ms grabRemoteControl:self.remoteShareView];
    }
}

- (void)onClickInput
{

    MobileRTCRemoteControlService * ms = [[MobileRTC sharedRTC] getRemoteControlService];
    if (![ms isRemoteController])return;
    
    if ([self.keyboardView isFirstResponder])
    {
        if ([self.keyboardView canResignFirstResponder])
        {
            [self.keyboardView resignFirstResponder];
        }
    }
    else
    {
        if ([self.keyboardView canBecomeFirstResponder])
        {
            [self.keyboardView becomeFirstResponder];
        }
    }
}

#pragma mark - MobileRTCRemoteControlDelegate
- (void) remoteControlPrivilegeChanged:(BOOL) isMyControl
{
    if (!isMyControl) {
        [self removeCoverView];
    }
    [self.remoteContrlBar setHidden:!isMyControl];
}

- (void) startRemoteControlCallBack:(MobileRTCRemoteControlError)resultValue
{
    switch (resultValue) {
        case MobileRTCRemoteControlError_Successed:
            self.remoteContrlBar.action.enabled = NO;
            self.mouseButton.hidden = NO;
            
            // init cover view for Gesture
            [self.remoteShareView addSubview:self.scrollView];
            [self.scrollView addSubview:self.coverView];
            [self initGesture];
            [self bringCoverViewToFront];
            break;
        default:
            self.remoteContrlBar.action.enabled = YES;
            self.mouseButton.hidden = YES;
            
            [self removeCoverView];
            
            break;
    }
}

// solve annotation inputView
- (void)bringCoverViewToFront
{
    [self.remoteShareView bringSubviewToFront:self.scrollView];
    [self.remoteShareView bringSubviewToFront:self.remoteContrlBar];
    [self.remoteShareView bringSubviewToFront:self.mouseButton];
}

- (void)removeCoverView
{
    [self.scrollView removeFromSuperview];
    self.scrollView = nil;
    
    [self.coverView removeFromSuperview];
    self.coverView = nil;

}

- (UIView*)coverView
{
    if (!_coverView)
    {
        _coverView = [[UIView alloc] initWithFrame:self.remoteShareView.bounds];
        _coverView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    }
    return _coverView;
}

- (UIScrollView*)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.remoteShareView.bounds];
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    }
    return _scrollView;
}

@end
