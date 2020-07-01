//
//  MobileRTCAudioRawData.h
//  MobileRTC
//
//  Created by Zoom Video Communications on 2019/8/6.
//  Copyright © 2019 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MobileRTCAudioRawData : NSObject

/*!
 @brief Data pointer of audio buffer data.
 */
@property (nonatomic, assign) char      *buffer;

/*!
 @brief Audio buffer data lenth.
 */
@property (nonatomic, assign) NSInteger bufferLen;

/*!
 @brief Audio sampling rate.
 */
@property (nonatomic, assign) NSInteger sampleRate;

/*!
 @brief Number of audio channels.
 */
@property (nonatomic, assign) NSInteger channelNum;

/*!
 @brief Can add reference count or not
 */
- (BOOL)canAddRef;

/*!
 @brief Add reference count
 */
- (BOOL)addRef;

/*!
 @brief Minus reference count
 */
- (NSInteger)releaseRef;

@end

