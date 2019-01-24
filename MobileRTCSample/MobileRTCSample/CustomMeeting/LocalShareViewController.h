//
//  LocalShareViewController.h
//  MobileRTCSample
//
//  Created by Murray Li on 2018/10/16.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface LocalShareViewController : UIViewController <WKNavigationDelegate>
@property (strong, nonatomic) WKWebView *   webView;

@end

