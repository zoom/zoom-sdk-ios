//
//  MobileRTCRoomDevice.h
//  MobileRTC
//
//  Created by Robust Hu on 2017/2/27.
//  Copyright © 2017年 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @brief MobileRTCDeviceType An Enum for all of H.323/SIP type.
 */
typedef enum {
    ///H.323 Device
    MobileRTCDeviceType_H323  = 1,
    ///SIP Device
    MobileRTCDeviceType_SIP,
    ///Both
    MobileRTCDeviceType_Both,
}MobileRTCDeviceType;

/*!
 @brief MobileRTCDeviceEncryptType An Enum for H.323/SIP encrypt type.
 */
typedef enum {
    ///None
    MobileRTCDeviceEncryptType_None   = 0,
    ///Encrypt
    MobileRTCDeviceEncryptType_Encrypt,
    ///Auto
    MobileRTCDeviceEncryptType_Auto,
}MobileRTCDeviceEncryptType;

@interface MobileRTCRoomDevice : NSObject

@property (nonatomic, copy) NSString *deviceName;
@property (nonatomic, copy) NSString *ipAddress;
@property (nonatomic, copy) NSString *e164num;
@property (nonatomic, assign) MobileRTCDeviceType deviceType;
@property (nonatomic, assign) MobileRTCDeviceEncryptType encryptType;

@end
