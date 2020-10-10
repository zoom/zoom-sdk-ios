//
//  MobileRTCPreProcessRawData.h
//  MobileRTC
//
//  Created by Zoom Video Communications on 2020/2/26.
//  Copyright © 2020 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MobileRTCPreProcessRawData : NSObject

/*!
 @brief the size of video data.
 */
@property (nonatomic, assign) CGSize size;

/*!
 @brief y data pointer of video's YUV data stride.
 */
@property (nonatomic, assign) int yStride;

/*!
 @brief u data pointer of video's YUV data stride.
 */
@property (nonatomic, assign) int uStride;

/*!
 @brief v data pointer of video's YUV data stride.
 */
@property (nonatomic, assign) int vStride;

/*!
@brief y data pointer of video's YUV data .
*/
- (char *)getYBuffer:(int)lineNum;

/*!
@brief u data pointer of video's YUV data .
*/
- (char *)getUBuffer:(int)lineNum;

/*!
@brief v data pointer of video's YUV data .
*/
- (char *)getVBuffer:(int)lineNum;

/*!
 @brief The raw data format of video data
 */
@property (nonatomic, assign) MobileRTCVideoRawDataFormat format;

/*!
 @brief The direction of video data.
 */
@property (nonatomic, assign) MobileRTCVideoRawDataRotation rotation;

@end

