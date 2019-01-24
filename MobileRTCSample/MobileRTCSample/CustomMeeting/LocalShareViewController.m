//
//  LocalShareViewController.m
//  MobileRTCSample
//
//  Created by Murray Li on 2018/10/16.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import "LocalShareViewController.h"

#define TEXT_FIELD_HEIGHT 50

@interface LocalShareViewController () <UITextFieldDelegate>

@property (strong, nonatomic) UITextField * textField;
@end

@implementation LocalShareViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.textField];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadRequestWithURLString:@"https://zoom.us"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [self.webView removeFromSuperview];
    self.webView = nil;
    
    [self.textField removeFromSuperview];
    self.textField = nil;
    
    [super dealloc];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGRect webViewFrame = self.webView.frame;
    webViewFrame.size.height = self.view.bounds.size.height-TEXT_FIELD_HEIGHT-80-60;
    webViewFrame.size.width = self.view.bounds.size.width;
    self.webView.frame = webViewFrame;
    
    CGRect textFiledFrame = self.textField.frame;
    textFiledFrame.size.height = TEXT_FIELD_HEIGHT;
    textFiledFrame.size.width = self.view.bounds.size.width;
    self.textField.frame = textFiledFrame;
}

- (void)loadRequestWithURLString:(NSString*)urlStr
{
    NSURL *url = [NSURL URLWithString:urlStr];
    if (!url.scheme.length)
    {
        url = [NSURL URLWithString:[@"https://" stringByAppendingString:urlStr]];
    }
    [self.textField setText:urlStr];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

#pragma mark - webView & Delegate
- (WKWebView*)webView
{
    if (!_webView)
    {
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 80+TEXT_FIELD_HEIGHT, self.view.bounds.size.width, self.view.bounds.size.height-TEXT_FIELD_HEIGHT-80-60)];
        [_webView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [_webView setNavigationDelegate:self];
    }
    
    return _webView;
}

- (void)webView:(WKWebView*)webView decidePolicyForNavigationAction:(WKNavigationAction*)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    //    NSString * URL = [navigationAction.request.URL absoluteString];
    //    if (![URL isEqualToString:@"about:blank"])
    //    {
    //        [self.textField setText:URL];
    //    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark - TextFeild & Delegate
- (UITextField*)textField
{
    if (!_textField)
    {
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(0,80,self.view.bounds.size.width,TEXT_FIELD_HEIGHT)];
        _textField.backgroundColor = [UIColor grayColor];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.keyboardType = UIKeyboardTypeURL;
        _textField.delegate = self;
    }
    return _textField;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString * inputUrl = [textField text];
    NSString * url = [inputUrl stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (url)
    {
        [self loadRequestWithURLString: url];
        [self.view endEditing:YES];
        return YES;
    }
    return NO;
}

@end
