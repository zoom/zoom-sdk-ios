//
//  MobileRTCVideoView.h
//  MobileRTC
//
//  Created by Robust on 2017/11/15.
//  Copyright © 2019年 Zoom Video Communications, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 @brief MobileRTCVideoAspect An Enum which provide video aspect.
 */
typedef enum {
    ///Original
    MobileRTCVideoAspect_Original       = 0,
    ///Full Filled
    MobileRTCVideoAspect_Full_Filled    = 1,
    ///Letter Box
    MobileRTCVideoAspect_LetterBox  = 2,
    ///Pan And Scan
    MobileRTCVideoAspect_PanAndScan = 3,
}MobileRTCVideoAspect;

/*!
 @class MobileRTCVideoView
 @brief MobileRTCVideoView is designed for Render Attendee Video.
 */
@interface MobileRTCVideoView : UIView

/*!
 @brief Designated for get rendering user's ID.
 @return userid that rendering.
 */
- (NSInteger)getUserID;

/*!
 @brief Designated for Render Attendee Video.
 @param userId user's video will be shown up.
 */
- (BOOL)showAttendeeVideoWithUserID:(NSUInteger)userID;

/*!
 @brief Designated for Stop Render.
 */
- (void)stopAttendeeVideo;

/*!
 @brief Designated for changing video aspect according to customer's requirement.
 */
- (void)setVideoAspect:(MobileRTCVideoAspect)aspect;

@end

/*!
 @class MobileRTCPreviewVideoView
 @brief MobileRTCPreviewVideoView is designed for Preview Self Video.
 @warning App need reponse to onSinkMeetingPreviewStopped, SDK handle start & stop Preview.
 */
@interface MobileRTCPreviewVideoView : MobileRTCVideoView

@end

/*!
 @class MobileRTCActiveVideoView
 @brief MobileRTCActiveVideoView is designed for Render Active Video.
 */
@interface MobileRTCActiveVideoView : MobileRTCVideoView

@end

/*!
 @class MobileRTCActiveShareView
 @brief MobileRTCActiveShareView is designed for Render Share Content.
 */
@interface MobileRTCActiveShareView : MobileRTCVideoView

/*!
 @brief Designated for Render Share Content.
 @param userId user's shared content will be shown up.
 */
- (void)showActiveShareWithUserID:(NSUInteger)userID;

/*!
 @brief Designated for Stop Render Share Content.
 */
- (void)stopActiveShare;

/*!
 @brief Designated for Render Share Content Scale Change.
 @param userId user's shared content scale change.
 */
- (void)changeShareScaleWithUserID:(NSUInteger)userID;

@end
