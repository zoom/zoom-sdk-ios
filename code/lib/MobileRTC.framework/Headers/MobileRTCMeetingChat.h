//
//  MobileRTCMeetingChat.h
//  MobileRTC
//
//  Created by Robust Hu on 2017/9/15.
//  Copyright © 2019年 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @brief Retrieve the meeting chat data.
 @warning The function is optional.
 */
@interface MobileRTCMeetingChat : NSObject

/*!
 @brief The message ID.
 */
@property (nonatomic, retain, readwrite) NSString *chatId;
/*!
 @brief The ID of user who sends message.
 */
@property (nonatomic, retain, readwrite) NSString *senderId;
/*!
 @brief The screen name of user who sends message.
 */
@property (nonatomic, retain, readwrite) NSString *senderName;
/*!
 @brief The ID of user who receives message.
 */
@property (nonatomic, retain, readwrite) NSString *receiverId;
/*!
 @brief The screen name of user who receives message.
 */
@property (nonatomic, retain, readwrite) NSString *receiverName;
/*!
 @brief The message content.
 */
@property (nonatomic, retain, readwrite) NSString *content;
/*!
 @brief The message timestamps.
 */
@property (nonatomic, retain, readwrite) NSDate *date;
/*!
 @brief Whether the message is sent by the user himself or not.
 */
@property (nonatomic, readwrite) BOOL isMyself;
/*!
 @brief Whether the message is private or not.
 */
@property (nonatomic, readwrite) BOOL isPrivate;

@end
