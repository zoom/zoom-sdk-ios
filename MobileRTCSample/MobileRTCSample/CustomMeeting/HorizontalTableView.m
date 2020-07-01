//
//  HorizontalTableView.m
//  MobileRTCSample
//
//  Created by Zoom Video Communications on 14/11/2017.
//  Copyright © 2017 Zoom Video Communications, Inc. All rights reserved.
//

#import "HorizontalTableView.h"

@implementation HorizontalTableView

-(void)setFrame:( CGRect )frame_
{
    if (CGRectIsEmpty(frame_) || CGRectIsNull(frame_))
        return;
    
    if (CGAffineTransformIsIdentity(self.transform))
    {
        [super setFrame:frame_];
        return;
    }
    
    CGAffineTransform transform_ = self.transform;
    self.transform = CGAffineTransformIdentity;
#ifdef __IPHONE_11_0
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11"))
    {
        self.estimatedRowHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
#endif
    
    CGRect new_rect_ = CGRectMake( frame_.origin.x + ( frame_.size.width - frame_.size.height ) / 2.f,
                                  frame_.origin.y + ( frame_.size.height - frame_.size.width ) / 2.f,
                                  frame_.size.height, frame_.size.width );
    
    [ super setFrame: new_rect_ ];
    
    self.transform = transform_;
}

-(CGRect)frame
{
    if (CGAffineTransformIsIdentity(self.transform))
    {
        return super.frame;
    }
   
    CGRect rect_ = super.frame;
    CGRect new_rect_ = CGRectMake( rect_.origin.x + ( rect_.size.width - rect_.size.height ) / 2.f,
                                  rect_.origin.y + ( rect_.size.height - rect_.size.width ) / 2.f,
                                  rect_.size.height, rect_.size.width );
    
    return new_rect_;
}

@end
