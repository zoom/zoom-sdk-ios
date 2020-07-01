//
//  MobileRTCInviteHelper.h
//  MobileRTC
//
//  Created by Zoom Video Communications on 7/29/15.
//  Copyright (c) 2019 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @class MobileRTCInviteHelper
 @brief Get/Set configurations in meeting.
 */
@interface MobileRTCInviteHelper : NSObject

/*!
 @brief Get current meeting number in format such as 123456789.
 @warning The method should be called during an ongoing meeting, otherwise the value is invalid.
 */
@property (retain, nonatomic, readonly) NSString * _Nonnull ongoingMeetingNumber;

/*!
 @brief Get unique ID of current meeting in format such as DVLObefSZizM0xQLhtrCQ==.
 @warning The method should be called during an ongoing meeting, otherwise the value is invalid.
 */
@property (retain, nonatomic, readonly) NSString * _Nonnull ongoingMeetingID;

/*!
 @brief Get the current meeting topic.
 @warning The method should be called during an ongoing meeting, otherwise the value is invalid.
 */
@property (retain, nonatomic, readonly) NSString * _Nonnull ongoingMeetingTopic;

/*!
 @brief Get the current meeting start time
 @warning The method should be called during an ongoing meeting, otherwise the value is invalid.
 */
@property (retain, nonatomic, readonly) NSDate * _Nonnull ongoingMeetingStartTime;

/*!
 @brief Query if the current meeting is a recurring meeting.
 @warning The method should be called during an ongoing meeting, otherwise the value is invalid.
 */
@property (assign, nonatomic, readonly) BOOL ongoingRecurringMeeting;

/*!
 @brief Get the join URL of current meeting
 */
@property (retain, nonatomic, readonly) NSString * _Nonnull joinMeetingURL;

/*!
 @brief Get the meeting password.
 */
@property (retain, nonatomic, readonly) NSString * _Nonnull meetingPassword;

/*!
 @brief Get the original meeting password.
 */
@property (retain, nonatomic, readonly) NSString * _Nonnull rawMeetingPassword;

/*!
 @brief Get the phone number of a toll call.
 */
@property (retain, nonatomic, readonly) NSString * _Nonnull tollCallInNumber;

/*!
 @brief Get the phone number of a toll free call.
 */
@property (retain, nonatomic, readonly) NSString * _Nonnull tollFreeCallInNumber;

/*!
 @brief Enable the invitation by message.
 @warning If set disableInviteSMS to YES, the "Invite by Message" button will not be displayed in Invite item; otherwise you can custom the invitation content.
 */
@property (assign, nonatomic) BOOL disableInviteSMS;

/*!
 @brief Custom the SMS invitation content.
 */
@property (retain, nonatomic) NSString * _Nonnull inviteSMS;

/*!
 @brief Enable Copy URL.
 @warning If set disableCopyURL to YES, the "Copy URL" button will not be displayed in Invite item; otherwise you can custom the Copy URL content.
 */
@property (assign, nonatomic) BOOL disableCopyURL;

/*!
 @brief Custom the content of Copy URL.
 */
@property (retain, nonatomic) NSString * _Nonnull inviteCopyURL;

/*!
 @brief Enable the invitation by Email.
 @warning If set disableEmailInvite to YES, the "Invite by Email" button will not be displayed in Invite item; otherwise you can custom the content of Email via inviteEmailSubject and inviteEmailContent.
 */
@property (assign, nonatomic) BOOL disableInviteEmail;

/*!
 @brief Custom the subject of the invitation by Email
 */
@property (retain, nonatomic) NSString * _Nonnull inviteEmailSubject;

/*!
 @brief Custom the content of the invitation by Email
 */
@property (retain, nonatomic) NSString * _Nonnull inviteEmailContent;

/*!
 @brief Get the instance of MobileRTCInviteHelper.
 */
+ (MobileRTCInviteHelper * _Nonnull)sharedInstance;

@end
