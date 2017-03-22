//
//  MobileRTCInviteHelper.h
//  MobileRTC
//
//  Created by Robust Hu on 7/29/15.
//  Copyright (c) 2015 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * MobileRTCInviteHelper is class which used to get/set some settings in meeting.
 */
@interface MobileRTCInviteHelper : NSObject

/**
 * To get the ongoing meeting number
 */
@property (retain, nonatomic, readonly) NSString *meetingID;

/**
 * To get the join URL of ongoing meeting
 */
@property (retain, nonatomic, readonly) NSString *joinMeetingURL;

/**
 * To get the meeting password
 */
@property (retain, nonatomic, readonly) NSString *meetingPassword;

/**
 * To get the raw meeting password
 */
@property (retain, nonatomic, readonly) NSString *rawMeetingPassword;

/**
 * To get phone number of toll call in
 */
@property (retain, nonatomic, readonly) NSString *tollCallInNumber;

/**
 * To get phone number of toll free call in
 */
@property (retain, nonatomic, readonly) NSString *tollFreeCallInNumber;

/**
 * To enable Invite by Message
 *
 * *Note*: If set disableInviteSMS to YES, the "Invite by Message" menu will not be displayed in Invite item; if set to NO, partner can customize the content of Invite by Message.
 */
@property (assign, nonatomic) BOOL disableInviteSMS;

/**
 * To customize the content of invite SMS
 */
@property (retain, nonatomic) NSString *inviteSMS;

/**
 * To enable Copy URL
 *
 * *Note*: If set disableCopyURL to YES, the "Copy URL" menu will not be displayed in Invite item; if set to NO, partner can customize the content of Copy URL.
 */
@property (assign, nonatomic) BOOL disableCopyURL;

/**
 * To customize the content of Copy URL
 */
@property (retain, nonatomic) NSString *inviteCopyURL;

/**
 * To enable Invite by email
 *
 * *Note*: If set disableEmailInvite to YES, the "Invite by Email" menu will not be displayed in Invite item; if set to NO, partner can customize the content of Email by property inviteEmailSubject and inviteEmailContent.
 */
@property (assign, nonatomic) BOOL disableInviteEmail;

/**
 * To customize the subject of Invite by Email
 */
@property (retain, nonatomic) NSString *inviteEmailSubject;

/**
 * To customize the content of Invite by Email
 */
@property (retain, nonatomic) NSString *inviteEmailContent;

/**
 * Returns the instance of MobileRTCInviteHelper
 */
+ (MobileRTCInviteHelper*)sharedInstance;

@end
