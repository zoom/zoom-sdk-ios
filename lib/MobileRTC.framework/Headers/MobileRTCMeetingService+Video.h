//
//  MobileRTCMeetingService+Video.h
//  MobileRTC
//
//  Created by Chao Bai on 2018/6/6.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import <MobileRTC/MobileRTC.h>

@interface MobileRTCMeetingService (Video)

/*!
 @brief This method is used to check user is sending his video or not.
 @return YES means that video is sending.
 */
- (BOOL)isSendingMyVideo;

/*!
 @brief This method is used to check user can unmute his video or not.
 @return YES means that can unmute.
 */
- (BOOL)canUnmuteMyVideo;

/*!
 @brief This method is used to mute My Video.
 @param mute: if YES means that mute my video
 @return mute my video result.
 */
- (MobileRTCVideoError)muteMyVideo:(BOOL)mute;

/*!
 @brief This method is used to check the user's video spotlighted or not.
 @param userId user's ID in meeting.
 @return YES means the user's video is spotlighted.
 */
- (BOOL)isUserSpotlighted:(NSUInteger)userId;

/*!
 @brief This method is used to spotlight the user's video or not.
 @param on if YES to spotlight user's video; if NO to cancel spotlight user's video.
 @param userId the user id in meeting.
 @return YES means call this method successfully.
 @warning only meeting host can run this function, and userId should not be myself.
 */
- (BOOL)spotlightVideo:(BOOL)on withUser:(NSUInteger)userId;

/*!
 @brief This method is used to check the user's video pinned or not.
 @param userId user's ID in meeting.
 @return YES means the user's video is pinned.
 */
- (BOOL)isUserPinned:(NSUInteger)userId;

/*!
 @brief This method is used to pin the user's video or not.
 @param on if YES to pin user's video; if NO to cancel pin user's video.
 @param userId the user id in meeting.
 @return YES means call this method successfully.
 */
- (BOOL)pinVideo:(BOOL)on withUser:(NSUInteger)userId;

/*!
 @brief This method is used to check the user video is sending or not.
 @param userID the user id in meeting
 @return YES means video is sending.
 */
- (BOOL)isUserVideoSending:(NSUInteger)userID;

/*!
 @brief This method is used to stop user's video.
 @param userID the user id in meeting, the userID should not be host himself
 @return YES means call this method successfully.
 @warning only meeting host can run this function.
 */
- (BOOL)stopUserVideo:(NSUInteger)userID;

/*!
 @brief This method is used to ask to start user's video.
 @param userID the user id in meeting, the userID should not be host himself
 @return YES means call this method successfully.
 @warning only meeting host can run this function.
 */
- (BOOL)askUserStartVideo:(NSUInteger)userID;

/*!
 @brief This method is used to retrieve user video's size.
 @param userID the user id in meeting
 @return the size of user video.
 */
- (CGSize)getUserVideoSize:(NSUInteger)userID;

#pragma mark Camera Related
/*!
 @brief This method is used to check user is using back camera or not.
 @return YES means that Back camera is using.
 */
- (BOOL)isBackCamera;

/*!
 @brief This method is used to Switch Local Device Video Camera Source.
 @return switch my camera result.
 */
- (MobileRTCCameraError)switchMyCamera;
@end
