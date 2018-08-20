//
//  MobileRTCRemoteControlService.h
//  MobileRTC
//
//  Created by Murray Li on 2018/6/22.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MobileRTCRemoteControlDelegate;

/*!
 @brief MobileRTCRemoteControlInputType An Enum which provide input type when keyboard return or delete key is pressed.
 */
typedef enum
{
    MobileRTCRemoteControl_Del,
    MobileRTCRemoteControl_Return
} MobileRTCRemoteControlInputType;

/*!
 @brief MobileRTCRemoteControlService provides Remote Control Servcie.
 */
@interface MobileRTCRemoteControlService : NSObject

/*!
 @brief The object that acts as the delegate of the receiving remote control events.
 */
@property (assign, nonatomic) id<MobileRTCRemoteControlDelegate> delegate;

/*!
 @brief This method is used to get can remote control or not.
 @return return can remote control or not.
 */
- (BOOL)isRemoteController;

/*!
 @brief This method is used to grab remote control.
 @param the remote shared view.
 @return Grab RemoteControl Result.
 */
- (MobileRTCRemoteControlError)grabRemoteControl:(UIView*)remoteShareView;

/*!
 @brief This method is used to simulate a single mouse click, such as tap the screen with one finger to click the mouse.
 @param the point that the screen clicks on.
 @return result of this gesture.
 */
- (MobileRTCRemoteControlError)remoteControlSingleTap:(CGPoint)point;

/*!
 @brief This method is used to simulate a double mouse click, such as double tap with one finger to double click the mouse.
 @param the point that the screen clicks on.
 @return result of this gesture.
 */
- (MobileRTCRemoteControlError)remoteControlDoubleTap:(CGPoint)point;

/*!
 @brief This method is used to simulate a mouse right-click, such as press the screen with one finger to right-click the mouse.
 @param the point that the screen clicks on.
 @return result of this gesture.
 */
- (MobileRTCRemoteControlError)remoteControlLongPress:(CGPoint)point;

/*!
 @brief This method is used to simulate the mouse scroll, such as swipe with two fingers to scroll up and down.
 @param up is CGPointMake(0, -1), down is CGPointMake(0, 1).
 @return result of this gesture.
 */
- (MobileRTCRemoteControlError)remoteControlDoubleScroll:(CGPoint)point;

/*!
 @brief This method is used to simulate the mouse move, such as drag the mouse icon to move the remote mouse pointer.
 @param the points that mouse icon trajectory.
 @return result of this gesture.
 */
- (MobileRTCRemoteControlError)remoteControlSingleMove:(CGPoint)point;

/*!
 @brief This method is used to simulate a mouse left-click, such as long press on mouse icon.
 @param the point that the screen clicks on.
 @return result of this gesture.
 */
- (MobileRTCRemoteControlError)remoteControlMouseLeftDown:(CGPoint)point;

/*!
 @brief This method is used to simulate a mouse left-click up, such as long press up on mouse icon.
 @param the point that the screen clicks on.
 @return result of this gesture.
 */
- (MobileRTCRemoteControlError)remoteControlMouseLeftUp:(CGPoint)point;

/*!
 @brief This method is used to simulate a mouse left-click drag, such as long press up on mouse icon, then drag mouse icon.
 @param the points that mouse icon trajectory.
 @return result of this gesture.
 */
- (MobileRTCRemoteControlError)remoteControlMouseLeftDrag:(CGPoint)point;

/*!
 @brief This method is used to simulate keyboard input.
 @param the input string form keyboard.
 @return result of this gesture.
 */
- (MobileRTCRemoteControlError)remoteControlCharInput:(NSString*)str;

/*!
 @brief This method is used to simulate keyboard retrun key or delete key.
 @param enum value of MobileRTCRemoteControlInputType.
 @return result of this gesture.
 */
- (MobileRTCRemoteControlError)remoteControlKeyInput:(MobileRTCRemoteControlInputType)key;
@end

/*!
 @protocol MobileRTCRemoteControlDelegate
 */
@protocol MobileRTCRemoteControlDelegate <NSObject>

@optional
/*!
 @brief MobileRTCRemoteControlService will issue the following value when privilege changed.
 @param return result of myControl or not.
 */
- (void) remoteControlPrivilegeChanged:(BOOL) isMyControl;

/*!
 @brief MobileRTCRemoteControlService will issue the following value when start remote control.
 @param return result of a enum value of MobileRTCRemoteControlError.
 */
- (void) startRemoteControlCallBack:(MobileRTCRemoteControlError)resultValue;

@end

