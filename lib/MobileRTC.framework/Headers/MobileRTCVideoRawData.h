//
//  MobileRTCVideoRawData.h
//  MobileRTC
//
//  Created by Zoom Video Communications on 2019/8/6.
//  Copyright © 2019 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MobileRTCVideoRawData : NSObject

/*!
 @brief y data pointer of video's YUV data.
 */
@property (nonatomic, assign) char *yBuffer;

/*!
 @brief u data pointer of video's YUV data.
 */
@property (nonatomic, assign) char *uBuffer;

/*!
 @brief v data pointer of video's YUV data.
 */
@property (nonatomic, assign) char *vBuffer;

/*!
 @brief the size of video data.
 */
@property (nonatomic, assign) CGSize size;

/*!
 @brief The raw data format of video data
 */
@property (nonatomic, assign) MobileRTCVideoRawDataFormat format;

/*!
 @brief The direction of video data.
 */
@property (nonatomic, assign) MobileRTCVideoRawDataRotation rotation;

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

