//
//  MobileRTCInviteHelper.h
//  MobileRTC
//
//  Created by Robust Hu on 7/29/15.
//  Copyright (c) 2015 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @class MobileRTCInviteHelper
 @brief MobileRTCInviteHelper is class which used to get/set some settings in meeting.
 */
@interface MobileRTCInviteHelper : NSObject

/*!
 @brief To get the ongoing meeting number, the format is just like 123456789
 @warning this method should be called during an ongoing meeting, or the value is invalid.
 */
@property (retain, nonatomic, readonly) NSString *ongoingMeetingNumber;

/*!
 @brief To get the ongoing meeting unique ID, the format is just like DVLObefSZizM0xQLhtrCQ==
 @warning this method should be called during an ongoing meeting, or the value is invalid.
 */
@property (retain, nonatomic, readonly) NSString *ongoingMeetingID;

/*!
 @brief To get the ongoing meeting topic
 @warning this method should be called during an ongoing meeting, or the value is invalid.
 */
@property (retain, nonatomic, readonly) NSString *ongoingMeetingTopic;

/*!
 @brief To get the ongoing meeting start time
 @warning this method should be called during an ongoing meeting, or the value is invalid.
 */
@property (retain, nonatomic, readonly) NSDate *ongoingMeetingStartTime;

/*!
 @brief To get the ongoing meeting whether is a recurring meeting or not.
 @warning this method should be called during an ongoing meeting, or the value is invalid.
 */
@property (assign, nonatomic, readonly) BOOL ongoingRecurringMeeting;

/*!
 @brief To get the join URL of ongoing meeting
 */
@property (retain, nonatomic, readonly) NSString *joinMeetingURL;

/*!
 @brief To get the meeting password
 */
@property (retain, nonatomic, readonly) NSString *meetingPassword;

/*!
 @brief To get the raw meeting password
 */
@property (retain, nonatomic, readonly) NSString *rawMeetingPassword;

/*!
 @brief To get phone number of toll call in
 */
@property (retain, nonatomic, readonly) NSString *tollCallInNumber;

/*!
 @brief To get phone number of toll free call in
 */
@property (retain, nonatomic, readonly) NSString *tollFreeCallInNumber;

/*!
 @brief To enable Invite by Message
 @warning If set disableInviteSMS to YES, the "Invite by Message" menu will not be displayed in Invite item; if set to NO, partner can customize the content of Invite by Message.
 */
@property (assign, nonatomic) BOOL disableInviteSMS;

/*!
 @brief To customize the content of invite SMS
 */
@property (retain, nonatomic) NSString *inviteSMS;

/*!
 @brief To enable Copy URL
 @warning If set disableCopyURL to YES, the "Copy URL" menu will not be displayed in Invite item; if set to NO, partner can customize the content of Copy URL.
 */
@property (assign, nonatomic) BOOL disableCopyURL;

/*!
 @brief To customize the content of Copy URL
 */
@property (retain, nonatomic) NSString *inviteCopyURL;

/*!
 @brief To enable Invite by email
 @warning If set disableEmailInvite to YES, the "Invite by Email" menu will not be displayed in Invite item; if set to NO, partner can customize the content of Email by property inviteEmailSubject and inviteEmailContent.
 */
@property (assign, nonatomic) BOOL disableInviteEmail;

/*!
 @brief To customize the subject of Invite by Email
 */
@property (retain, nonatomic) NSString *inviteEmailSubject;

/*!
 @brief To customize the content of Invite by Email
 */
@property (retain, nonatomic) NSString *inviteEmailContent;

/*!
 @brief the instance of MobileRTCInviteHelper
 */
+ (MobileRTCInviteHelper*)sharedInstance;

@end
