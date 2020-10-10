//
//  MobileRTCVideoSourceHelper.h
//  MobileRTC
//
//  Created by Zoom Video Communications on 2020/7/20.
//  Copyright © 2020 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MobileRTCVideoSourceHelper : NSObject

/*!
@brief This method is used to preprocess video's YUV420 data before rendering receive.
@param delegate please See MobileRTCPreProcessorDelegate.
@warning Set nil stop preProcessor
*/
-(MobileRTCRawDataError)setPreProcessor:(id<MobileRTCPreProcessorDelegate>) delegate;

/*!
@brief This method is used to send your own video rawdata.
@param delegate please See MobileRTCVideoSourceDelegate.
@warning Set nil for Switch to internal video source.
*/
-(MobileRTCRawDataError)setExternalVideoSource:(id<MobileRTCVideoSourceDelegate>)delegate;

@end
