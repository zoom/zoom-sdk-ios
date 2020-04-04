//
//  MobileRTCBORole.h
//  MobileRTC
//
//  Created by Jackie Chen on 2020/2/11.
//  Copyright © 2020 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    BOUserStatusUnassigned  = 1, //User is in main conference, not assigned to BO
    BOUserStatusNotJoin     = 2, //User is assigned to BO, but not join
    BOUserStatusInBO        = 3, //User is already in BO
} MobileRTCBOUserStatus;


@interface MobileRTCBOUser : NSObject
/*!
@brief get bo meeting user id.
*/
- (NSString * _Nullable)getUserId;

/*!
@brief get bo meeting user name.
*/
- (NSString * _Nullable)getUserName;

/*!
@brief get bo meeting user status.
*/
- (MobileRTCBOUserStatus)getUserStatus;
@end

@interface MobileRTCBOMeeting : NSObject
/*!
@brief get bo meeting id.
*/
- (NSString * _Nullable)getBOMeetingId;

/*!
@brief get bo meeting name.
*/
- (NSString * _Nullable)getBOMeetingName;

/*!
@brief get bo meeting user array.
*/
- (NSArray * _Nullable)getBOMeetingUserList;
@end

/*
*    host in master conf     : creator + admin + assistant + dataHelper
*    host in bo conf         : admin + assistant + dataHelper
*    cohost in master conf   : attendee
*    cohost in bo conf       : assistant + dataHelper
*    attendee in master conf : attendee
*    attendee in bo conf     : attendee
*/

/*
*    1. Function:
*        1) add/delete/rename bo meeting
*        2) assgin/remove user to bo meeting
*    2. Remarks:
*        1) only host in master meeting, can get this role
*        2) host changed, createor will assign to new host
*/
@interface MobileRTCBOCreator : NSObject

/*!
@brief create a bo meeting.
@return bo meeting id.
*/
- (NSString * _Nullable)createBO:(NSString * _Nullable)boName;

/*!
@brief update bo meeting name with bo id.
@return update success or not.
*/
- (BOOL)updateBO:(NSString * _Nullable)boId name:(NSString * _Nullable)boName;

/*!
@brief remove a bo meeting.
@return remove bo meting success or not
*/
- (BOOL)removeBO:(NSString * _Nullable)boId;

/*!
@brief assign a user to a bo meeting.
@return assign success or not
*/
- (BOOL)assignUser:(NSString * _Nullable)boUserId toBO:(NSString * _Nullable)boId;

/*!
@brief remove a user from a bo meeting.
@return remove success or not
*/
- (BOOL)removeUser:(NSString * _Nullable)boUserId fromBO:(NSString * _Nullable)boId;

@end

/*
*    1. Function:
*        1) after bo started, assgin user to bo meeting,
*        2) after bo started, switch user from BO-A to BO-B
*        3) stop bo meeting
*        4) start bo meeting
*    2. Remarks:
*        1) host in master meeting or bo meeting, can get this role
*        2) can start bo meeting after bo meeting created by creator.
*/
@interface MobileRTCBOAdmin : NSObject
/*!
@brief start bo meeting which assigned.
@return start success or not
*/
- (BOOL)startBO;

/*!
@brief stop bo meeting which assigned.
@return stop success or not
*/
- (BOOL)stopBO;

/*!
@brief assign a bo user to a started bo meeting.
*/
- (BOOL)assignNewUser:(NSString * _Nullable)boUserId toRunningBO:(NSString * _Nullable)boId;

/*!
@brief switch a user to a new started bo meeting.
*/
- (BOOL)switchUser:(NSString * _Nullable)boUserId toRunningBO:(NSString * _Nullable)boId;

/*!
@brief indicate that the bo can be start or not.
*/
- (BOOL)canStartBO;
@end

/*
*    1. Function:
*        1) join bo meeting with bo id
*        2) leave bo meeting
*    2. Remarks:
*        1) host in master meeting or bo meeting, co-host in bo conf, can get this role
*/
@interface MobileRTCBOAssistant : NSObject

/*!
@brief join a bo meeting with bo id..
*/
- (BOOL)joinBO:(NSString * _Nullable)boId;

/*!
@brief leave joined bo meeting.
*/
- (BOOL)leaveBO;

@end


/*
*   1. Function:
*       1) only can join bo
*       2) leave bo
*       3) request help
*    2. Remarks:
*       1) if you are attendee, and are assigned to BO, you will get this role
*       2) if you are Co-Host, and are assigned to BO, you will get this role
*
*/
@interface MobileRTCBOAttendee : NSObject

/*!
@brief join to assined bo meeting.
*/
- (BOOL)joinBO;

/*!
@brief leave assined bo meeting.
*/
- (BOOL)leaveBO;

/*!
@brief get bo meeting name.
*/
- (NSString * _Nullable)getBOName;

@end

/*
*    1. Function:
*        1) get unassigned user list
*        2) get bo list
*    2. Remarks:
*        1) when host in master meeting or bo meeting, you will get this role
*        2) when CoHost in bo conf, you will get this role
*/
@interface MobileRTCBOData : NSObject

/*!
@brief get un assined user list.
*/
- (NSArray * _Nullable)getUnassignedUserList;

/*!
@brief get all bo meeting id list.
*/
- (NSArray * _Nullable)getBOMeetingIDList;

/*!
@brief get bo user object by bo user id
*/
- (MobileRTCBOUser * _Nullable)getBOUserByUserID:(NSString * _Nullable)userId;

/*!
@brief get bo meeting object by bo meeting id
*/
- (MobileRTCBOMeeting * _Nullable)getBOMeetingByID:(NSString * _Nullable)boId;

@end

