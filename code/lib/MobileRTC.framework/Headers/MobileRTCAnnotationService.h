//
//  MobileRTCAnnotationService.h
//  MobileRTC
//
//  Created by Chao Bai on 2018/6/12.
//  Copyright © 2019 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @brief An enumeration of annotation tool types in meeting. 
 */
typedef enum {
	/*!
	 White board.
	 */
    MobileRTCAnnoTool_Whiteboard = 1,
	/*!
	 Laser pointer.
	 */
    MobileRTCAnnoTool_Spotlight = 2,
	/*!
	 Pen.
	 */
    MobileRTCAnnoTool_Pen = 3,
	/*!
	 Highlighter.
	 */
    MobileRTCAnnoTool_Highligher = 4,
	/*!
	 A straight line changes automatically in pace with the mouse cursor.
	 */
    MobileRTCAnnoTool_Line = 8,
	/*!
	 An arrow.
	 */
    MobileRTCAnnoTool_Arrow = 9,
	/*!
	 An arrow changes automatically in pace with the mouse cursor.
	 */
    MobileRTCAnnoTool_Arrow2 = 10,
	/*!
	 A rectangle.
	 */
    MobileRTCAnnoTool_Rectangle = 11,
	/*!
	 A circle.  
	 */
    MobileRTCAnnoTool_Ellipse = 12,
	/*!
	 Input text.
	 */
    MobileRTCAnnoTool_Text = 13,
	/*!
	 An eraser to clear annotations.
	 */
    MobileRTCAnnoTool_Eraser = 15,
} MobileRTCAnnoTool;

/*!
 @brief The method is used to provide annotate service. 
 @warning User, as the presenter, should stop the current share before starting another share. 
 */

@class MobileRTCAnnotationService;
/*!
 @class MobileRTCAnnotationServiceDelegate
 @brief the share sender will disable the annotation, this delegate will notify the status change to viewer #only for custom UI#.
 */
@protocol MobileRTCAnnotationServiceDelegate <NSObject>
@optional
- (void)onAnnotationService:(nullable MobileRTCAnnotationService *)service supportStatusChanged:(BOOL)support;
@end

@interface MobileRTCAnnotationService : NSObject

/*!
 @brief Callback of receiving meeting events.
 */
@property (nullable, assign, nonatomic) id<MobileRTCAnnotationServiceDelegate> delegate;

/*!
 @brief Set to start annotations on the shared view. 
 @param view The shared view. 
 @return The result of operation.
 */
- (MobileRTCAnnotationError)startAnnotationWithSharedView:(nullable UIView*)view;

/*!
 @brief Set to stop annotations.
 @return The result of operation. 
 */
- (BOOL)stopAnnotation;

/*!
 @brief Set the colors of annotation tools.
 @return The result of setting the colors.
 */
- (MobileRTCAnnotationError)setToolColor:(nullable UIColor *)toolColor;

/*!
 @brief This method is used to get current Anno Tool Color.
 @return Get Color by tool type.
 */
- (nullable UIColor *)getToolColor:(MobileRTCAnnoTool)tooltype;

/*!
 @brief Set the types of annotation tools.  
 @return The result of operation.  
 @warning Check firstly if the tool is supported via getSupportedToolType. 
 */
- (MobileRTCAnnotationError)setToolType:(MobileRTCAnnoTool)type;

/*!
 @brief Set the line width of annotation tools.  
 @return The result of operation.
 */
- (MobileRTCAnnotationError)setToolWidth:(NSUInteger)width;

/*!
 @brief Set to clear the annotations.  
 @return The result of operation.
 @warning Check firstly if the tool is supported via getSupportedToolType.
 */
- (MobileRTCAnnotationError)clear;

/*!
 @brief Undo the last annotation.  
 @return The result of undoing the annotations.
 @warning Check firstly if the tool is supported via getSupportedToolType.
 */
- (MobileRTCAnnotationError)undo;

/*!
 @brief Redo the last annotation.
 @return The result of redoing the annotations. 
 @warning Check firstly if the tool is supported via getSupportedToolType.
 */
- (MobileRTCAnnotationError)redo;

/*!
 @brief Get the supported tool types.
 @return tool type array, each tool is a NSNumber object, value corresponding to enum MobileRTCAnnoTool.
 */
- (nullable NSArray *)getSupportedToolType;

/*!
 @brief Check if the current user is the presenter.
 @return Yes if be presenter.
 */
- (BOOL)isPresenter;

/*!
 @brief Check if support to disable viewer's annotation item.
 @return Yes if support.
 */
- (BOOL)canDisableViewerAnnoataion;

/*!
 @brief Check currently sender disabled the viewer's annotation or not.
 @return Yes if disabled viewer's annotation.
 */
- (BOOL)isViewerAnnoataionDisabled;

/*!
 @brief disable viewer's annotation.
 @return MobileRTCAnnotationError_Successed if disabled the viewer's annotation success.
 */
- (MobileRTCAnnotationError)disableViewerAnnoataion:(BOOL)isDisable;

/*!
 @brief Check can do annotation or not.
 @return Yes if can do the annotation.
 */
- (BOOL)canDoAnnotation;

@end
