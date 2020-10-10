//
//  MobileRTCVideoSender.h
//  MobileRTC
//
//  Created by Zoom Video Communications on 2020/3/9.
//  Copyright © 2020 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MobileRTCVideoSender : NSObject
/*!
@brief This method is used to send video's rawdata.
@param frameBuffer The YUV420i for each frame of the video.
@param width The width of the raw data of each frame of the video.
@param height The height of the raw data of each frame of the video
@param dataLength The data length of the raw data of each frame of the video
@param rotation The direction of the raw data of each frame of the video
*/
- (void)sendVideoFrame:(char *)frameBuffer width:(NSUInteger)width height:(NSUInteger)height dataLength:(NSUInteger)dataLength rotation:(MobileRTCVideoRawDataRotation)rotation;
@end

