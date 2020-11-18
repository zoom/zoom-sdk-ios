//
//  ManageLanInterpreViewController.h
//  MobileRTCSample
//
//  Created by Zoom Video Communications on 2020/10/22.
//  Copyright © 2020 Zoom Video Communications, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SampleInterpreter : NSObject
@property (nonatomic, assign)   NSInteger           userID;
@property (nonatomic, assign)   NSInteger           languageID1;
@property (nonatomic, assign)   NSInteger           languageID2;
@property (nonatomic, assign)   BOOL                isAvailable;
@end

@interface ManageLanInterpreViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
