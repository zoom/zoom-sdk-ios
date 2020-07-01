//
//  MobileRTCCallCountryCode.h
//  MobileRTC
//
//  Created by Zoom Video Communications on 2019/7/3.
//  Copyright © 2019 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MobileRTCCallCountryCode : NSObject
/*!
 @brief the country Id.
 */
@property (nonatomic, retain) NSString *countryId;
/*!
 @brief the country name.
 */
@property (nonatomic, retain) NSString *countryName;
/*!
 @brief the country code.
 */
@property (nonatomic, retain) NSString *countryCode;
/*!
 @brief the country number.
 */
@property (nonatomic, retain) NSString *countryNumber;
/*!
 @brief Whether free.
 */
@property (nonatomic, assign) BOOL tollFree;

@end
