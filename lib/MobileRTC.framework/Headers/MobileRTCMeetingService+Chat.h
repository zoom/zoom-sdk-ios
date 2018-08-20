//
//  MobileRTCMeetingService+Chat.h
//  MobileRTC
//
//  Created by Chao Bai on 2018/6/6.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import <MobileRTC/MobileRTC.h>

typedef enum {
    ///All
    MobileRTCChatGroup_All                   = 0,
    ///Panelists
    MobileRTCChatGroup_Panelists              = 1,
}MobileRTCChatGroup;

@interface MobileRTCMeetingService (Chat)

/*!
 @brief This method is used to check chat is disabled in meeting or not.
 @return YES means that chat is disabled.
 */
- (BOOL)isChatDisabled;

/*!
 @brief This method is used to check private chat is disabled in meeting or not.
 @return YES means that chat is disabled.
 */
- (BOOL)isPrivateChatDisabled;

/*!
 @brief This method is used to get chat content in meeting.
 @param messageID the message ID in meeting chat
 @return an instance of meeting chat.
 @warning The method is optional.
 */
- (nullable MobileRTCMeetingChat*)meetingChatByID:(nonnull NSString*)messageID;

/*!
 @brief This method is used to send chat content to specified user in meeting.
 @param userID the userID ID in meeting.
 @param content the content to be sent.
 @return send chat result.
 */
- (MobileRTCSendChatError)sendChatToUser:(NSUInteger)userID WithContent:(nonnull NSString*)content;

/*!
 @brief This method is used to send chat content to group in meeting.
 @param group Group type in meeting.
 @param content the content to be sent.
 @return send chat result.
 */
- (MobileRTCSendChatError)sendChatToGroup:(MobileRTCChatGroup)group WithContent:(nonnull NSString*)content;

@end
