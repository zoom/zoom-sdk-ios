//
//  MobileRTCRoomDevice.h
//  MobileRTC
//
//  Created by Robust Hu on 2017/2/27.
//  Copyright © 2017年 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MobileRTCDeviceType_H323  = 1,
    MobileRTCDeviceType_SIP,
    MobileRTCDeviceType_Both,
}MobileRTCDeviceType;

typedef enum {
    MobileRTCDeviceEncryptType_None   = 0,
    MobileRTCDeviceEncryptType_Encrypt,
    MobileRTCDeviceEncryptType_Auto,
}MobileRTCDeviceEncryptType;

@interface MobileRTCRoomDevice : NSObject

@property (nonatomic, copy) NSString *deviceName;
@property (nonatomic, copy) NSString *ipAddress;
@property (nonatomic, copy) NSString *e164num;
@property (nonatomic, assign) MobileRTCDeviceType deviceType;
@property (nonatomic, assign) MobileRTCDeviceEncryptType encryptType;

@end
