//
//  MobileRTCRenderer.h
//  MobileRTC
//
//  Created by Zoom Video Communications on 2019/8/6.
//  Copyright © 2019 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MobileRTCMeetingDelegate.h"

@interface MobileRTCRenderer : NSObject

/*!
@brief the userId of MobileRTCRenderer object.
*/
@property (nonatomic, assign, readonly) NSUInteger userId;

/*!
 @brief the video type of MobileRTCRenderer object.
 */
@property (nonatomic, assign, readonly) MobileRTCVideoType videoType;

/*!
 @brief the video resolution of MobileRTCRenderer object.
 */
@property (nonatomic, assign, readonly) MobileRTCVideoResolution resolution;

/*!
 @brief Call the function to initialize MobileRTCRenderer.
 @return The MobileRTCRenderer object.
 */
- (instancetype _Nonnull)initWithDelegate:(id<MobileRTCVideoRawDataDelegate>_Nonnull) delegate;

/*!
 @brief Call the function to set video resolution.
 */
- (MobileRTCRawDataError)setRawDataResolution:(MobileRTCVideoResolution)resolution;

/*!
 @brief Call the function to subscribe video raw data. Before entering the meeting, you can subscribe your preview video data with userid=0, If you are already in the meeting, you can subscribe your own video data using the real userid or userid=0.
 @return the result of the method.
 */
- (MobileRTCRawDataError)subscribe:(NSUInteger)userId
                    videoType:(MobileRTCVideoType)type;

/*!
 @brief Call the function to unsubscribe video raw data.
 @return the result of the method.
 */
- (MobileRTCRawDataError)unSubscribe;

@end

