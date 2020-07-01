//
//  MobileRTCAudioRawDataHelper.h
//  MobileRTC
//
//  Created by Zoom Video Communications on 2019/8/8.
//  Copyright © 2019 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MobileRTCAudioRawDataHelper : NSObject
/*!
 @brief Call the function to initialize MobileRTCAudioRawDataHelper.
 @param delegate Specify the delegate to receive the callback.
 @return The MobileRTCAudioRawDataHelper object.
 */
- (instancetype _Nonnull)initWithDelegate:(id<MobileRTCAudioRawDataDelegate>_Nonnull) delegate;

/*!
 @brief Call the function to start audio rawdata.
 */
-(MobileRTCRawDataError)subscribe;

/*!
 @brief Call the function to stop audio rawdata.
 */
- (MobileRTCRawDataError)unSubscribe;

@end
