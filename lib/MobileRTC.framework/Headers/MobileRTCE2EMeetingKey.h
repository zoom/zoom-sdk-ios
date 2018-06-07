//
//  MobileRTCE2EMeetingKey.h
//  MobileRTC
//
//  Created by Robust Hu on 2017/9/18.
//  Copyright © 2017年 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @brief MobileRTCE2EMeetingKey provides support for customize the E2E meeting session keys.
 @warning This function is optional.
 */
@interface MobileRTCE2EMeetingKey : NSObject

/*!
 @brief This property knows as component type.
 */
@property (nonatomic, assign, readwrite) MobileRTCComponentType type;
/*!
 @brief This property knows as meeting session key.
 */
@property (nonatomic, retain, readwrite) NSData *meetingKey;
/*!
 @brief This property knows as meeting session extra information.
 */
@property (nonatomic, retain, readwrite) NSData *meetingIv;

@end
