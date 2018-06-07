//
//  MobileRTCMeetingChat.h
//  MobileRTC
//
//  Created by Robust Hu on 2017/9/15.
//  Copyright © 2017年 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @brief MobileRTCMeetingChat provides support for retrieve the meeting chat data.
 @warning This function is optional.
 */
@interface MobileRTCMeetingChat : NSObject

/*!
 @brief This property knows as chat ID.
 */
@property (nonatomic, retain, readwrite) NSString *chatId;
/*!
 @brief This property knows as sender ID.
 */
@property (nonatomic, retain, readwrite) NSString *senderId;
/*!
 @brief This property knows as sender name.
 */
@property (nonatomic, retain, readwrite) NSString *senderName;
/*!
 @brief This property knows as receiver ID.
 */
@property (nonatomic, retain, readwrite) NSString *receiverId;
/*!
 @brief This property knows as receiver name.
 */
@property (nonatomic, retain, readwrite) NSString *receiverName;
/*!
 @brief This property knows as chat content.
 */
@property (nonatomic, retain, readwrite) NSString *content;
/*!
 @brief This property knows as chat timestamp.
 */
@property (nonatomic, retain, readwrite) NSDate *date;
/*!
 @brief This property knows as myself message.
 */
@property (nonatomic, readwrite) BOOL isMyself;
/*!
 @brief This property knows as private chat.
 */
@property (nonatomic, readwrite) BOOL isPrivate;

@end
