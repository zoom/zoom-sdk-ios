//
//  UIColor+Additions.m
//  ZoomSDKSample
//
//  Created by Xiaojian Hu on 3/17/14.
//  Copyright (c) 2014 Zoom Video Communications, Inc. All rights reserved.
//

#import "UIColor+Additions.h"

@implementation UIColor (Additions)

+ (UIColor*)colorWithHex:(NSUInteger)hexColor
{
    CGFloat red = ((hexColor >> 16) & 0xFF) / 255.f;
    CGFloat green = ((hexColor >> 8) & 0xFF) / 255.f;
    CGFloat blue = (hexColor & 0xFF) / 255.f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.f];
}

@end
