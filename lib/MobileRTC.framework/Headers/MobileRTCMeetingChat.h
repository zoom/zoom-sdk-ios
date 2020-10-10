//
//  MobileRTCMeetingChat.h
//  MobileRTC
//
//  Created by Zoom Video Communications on 2017/9/15.
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
@property (nonatomic, retain, readwrite) NSString * _Nullable chatId;
/*!
 @brief The ID of user who sends message.
 */
@property (nonatomic, retain, readwrite) NSString * _Nullable senderId;
/*!
 @brief The screen name of user who sends message.
 */
@property (nonatomic, retain, readwrite) NSString * _Nullable senderName;
/*!
 @brief The ID of user who receives message.
 */
@property (nonatomic, retain, readwrite) NSString * _Nullable receiverId;
/*!
 @brief The screen name of user who receives message.
 */
@property (nonatomic, retain, readwrite) NSString * _Nullable receiverName;
/*!
 @brief The message content.
 */
@property (nonatomic, retain, readwrite) NSString * _Nullable content;
/*!
 @brief The message timestamps.
 */
@property (nonatomic, retain, readwrite) NSDate *_Nullable date;

/*!
 @brief The Chat message type.
 */
@property (nonatomic, readwrite) MobileRTCChatMessageType chatMessageType;

/*!
 @brief Whether the message is sent by the user himself or not.
 */
@property (nonatomic, readwrite) BOOL isMyself;
/*!
 @brief Whether the message is private or not.
 */
@property (nonatomic, readwrite) BOOL isPrivate;
/*!
 @brief Whether the message is send to all or not.
 */
@property (nonatomic, readwrite) BOOL isChatToAll;
/*!
 @brief Whether the message is send to all panelist or not.
 */
@property (nonatomic, readwrite) BOOL isChatToAllPanelist;
/*!
 @brief Whether the message is send to waiting room or not.
 */
@property (nonatomic, readwrite) BOOL isChatToWaitingroom;
@end
