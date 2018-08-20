//
//  MobileRTCAnnotationService.h
//  MobileRTC
//
//  Created by Chao Bai on 2018/6/12.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @brief MobileRTCAnnoTool An Enum which provide annotation tool type supported in meeting.
 */
typedef enum {
    MobileRTCAnnoTool_Whiteboard = 1,
    MobileRTCAnnoTool_Spotlight = 2,
    MobileRTCAnnoTool_Pen = 3,
    MobileRTCAnnoTool_Highligher = 4,
    MobileRTCAnnoTool_Line = 8,
    MobileRTCAnnoTool_Arrow = 9,
    MobileRTCAnnoTool_Arrow2 = 10,
    MobileRTCAnnoTool_Rectangle = 11,
    MobileRTCAnnoTool_Ellipse = 12,
    MobileRTCAnnoTool_Text = 13,
    MobileRTCAnnoTool_Editing = 14,
    MobileRTCAnnoTool_Eraser = 15,
} MobileRTCAnnoTool;

/*!
 @brief MobileRTCAnnotationService provides Annotate Servcie.
 @warning If you are presenter & share local view, for screen Rotate case, APP need to stop annotation first, then re-start annotation.
 */

@interface MobileRTCAnnotationService : NSObject

/*!
 @brief This method is used to start annotation.
 @param view the shared view.
 @return Start Annotate Result.
 */
- (MobileRTCAnnotationError)startAnnotationWithSharedView:(UIView*)view;

/*!
 @brief This method is used to stop annotation.
 @return Stop Annotate Result.
 */
- (BOOL)stopAnnotation;

/*!
 @brief This method is used to set all Anno Tool Color.
 @return Set Color Result.
 */
- (MobileRTCAnnotationError)setToolColor:(NSUInteger)color;

/*!
 @brief This method is used to set Anno Tool Type.
 @return Set Anno Tool Result.
 @waring Use interface getSupportedToolType to check supported tool firstly
 */
- (MobileRTCAnnotationError)setToolType:(MobileRTCAnnoTool)type;

/*!
 @brief This method is used to set Anno Tool Width.
 @return Set Anno Width Result.
 */
- (MobileRTCAnnotationError)setToolWidth:(NSUInteger)width;

/*!
 @brief This method is used to clear.
 @return Clear Result.
 @waring Use interface getSupportedToolType to check supported tool firstly
 */
- (MobileRTCAnnotationError)clear;

/*!
 @brief This method is used to undo.
 @return Undo Result.
 @waring Use interface getSupportedToolType to check supported tool firstly
 */
- (MobileRTCAnnotationError)undo;

/*!
 @brief This method is used to redo.
 @return Redo Result.
 @waring Use interface getSupportedToolType to check supported tool firstly
 */
- (MobileRTCAnnotationError)redo;

/*!
 @brief This method is used to get supported tool type.
 @return tool type array, each tool is a NSNumber object, value corresponding to enum MobileRTCAnnoTool.
 */
- (NSArray *)getSupportedToolType;

/*!
 @brief This method is used to check wether is presenter.
 @return Yes if be presenter.
 */
- (BOOL)isPresenter;
@end
