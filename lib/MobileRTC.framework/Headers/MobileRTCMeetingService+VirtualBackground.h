//
//  MobileRTCMeetingService+VirtualBackground.h
//  MobileRTC
//
//  Created by Zoom Video Communications on 2019/10/22.
//  Copyright © 2019 Zoom Video Communications, Inc. All rights reserved.
//

#import <MobileRTC/MobileRTC.h>

/*!
 @brief image item property
 */
@interface ZoomSDKVirtualBGImageInfo : NSObject

/*!
 @brief None item if yes.
 */
@property(nonatomic, assign) BOOL isNone;

/*!
 @brief current using image item if yes.
 */
@property(nonatomic, assign) BOOL isSelect;

/*!
 @brief Image path of image item, nil for none image item.
 */
@property(nonatomic, retain) NSString* _Nullable imagePath;

@end

/*!
 @brief meeting service for virtual background
 */
@interface MobileRTCMeetingService (VirtualBackground)

/*!
 @brief The preview for inspect the virtual background effect.
 */
@property (retain, nonatomic) UIView    * _Nullable previewView;

/*!
 @brief Start preview for inspect the virtual background effect.
 @return YES mean preview is ready.
 */
- (BOOL)startPreviewWithFrame:(CGRect)frame;

/*!
 @brief is support virtual background.
 @return YES mean support, you can use it.
 */
- (BOOL)isSupportVirtualBG;

/*!
 @brief is Support smart virtual background.
 @return YES mean support, you can use it.
 */
- (BOOL)isSupportSmartVirtualBG;


#pragma mark smart virtual background
/*!
 @brief get the virtual background list.
 @return Return Narray of the items which include the None item.
 */
- (NSArray * _Nonnull)getBGImageList;

/*!
 @brief add and use the image for virtual background.
 @return Add and use virtual background result.
 */
- (MobileRTCMeetError)addBGImage:(UIImage *_Nonnull)image;

/*!
 @brief Remove image item form image list.
 @brief Will use the previous one for virtual background.
 @return Remove result.
 */
- (MobileRTCMeetError)removeBGImage:(ZoomSDKVirtualBGImageInfo *_Nonnull)bgImageInfo;

/*!
 @brief use the specify image item for virtual background.
 @return The result of use image item.
 */
- (MobileRTCMeetError)useBGImage:(ZoomSDKVirtualBGImageInfo *_Nonnull)bgImage;

/*!
 @brief Disable the virtrual background, same as use a none image item.
 @return The result of disable virtual background.
 */
- (MobileRTCMeetError)useNoneImage;

#pragma mark green virtual background
/*!
 @brief is using green virtual background.
 @return Return yes if using green virtual background.
 */
- (BOOL)isUsingGreenVB;

/*!
 @brief Enable green virtual background mode.
 @param enable or disable.
 @return result of enable green virtual background.
 */
- (MobileRTCMeetError)enableGreenVB:(BOOL)enable;

/*!
 @brief Select the point that regard as background.
 @param point in preview view.
 @return result of set background point action.
 */
- (MobileRTCMeetError)selectGreenVBPoint:(CGPoint)point;

@end

