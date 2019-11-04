//
//  WebViewController.h
//  MobileRTCSample
//
//  Created by Murray Li on 2019/6/21.
//  Copyright © 2019 Zoom Video Communications, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebViewController : UINavigationController

@property (retain, nonatomic) WKWebView  *webView;

@end

NS_ASSUME_NONNULL_END
