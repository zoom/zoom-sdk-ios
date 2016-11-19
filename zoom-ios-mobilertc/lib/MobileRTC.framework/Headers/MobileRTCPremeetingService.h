//
//  MobileRTCPremeetingService.h
//  MobileRTC
//
//  Created by Robust Hu on 16/8/3.
//  Copyright © 2016年 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MobileRTCMeetingItem;
@protocol MobileRTCPremeetingDelegate;

/**
 * This class provides support for schedule/edit/delete meeting MobileRTC once login with work email.
 *
 * **Note**: Before using MobileRTCPremeetingService, the MobileRTC should be logged in with work email.
 */
@interface MobileRTCPremeetingService : NSObject

/**
 * The object that acts as the delegate of the receiving schedule/edit/delete meeting events.
 */
@property (assign, nonatomic) id<MobileRTCPremeetingDelegate> delegate;

/**
 * Designated for creating a meeting item which is used to edit meeting.
 *
 * @return an object of id<MobileRTCMeetingItem>.
 *
 * *Note*: the created meeting item should be destroyed by method destroyMeetingItem finally.
 */
- (id<MobileRTCMeetingItem>)createMeetingItem;

/**
 * Designated for deatroy a previous created meeting item.
 */
- (void)destroyMeetingItem:(id<MobileRTCMeetingItem>)item;

/**
 * Designated for get a meeting item by a meeting number.
 *
 * @return an object of id<MobileRTCMeetingItem>.
 *
 */
- (id<MobileRTCMeetingItem>)getMeetingItemByNumber:(NSUInteger)meetingNumber;

/**
 * Designated for schudle a meeting with meeting item.
 */
- (BOOL)scheduleMeeting:(id<MobileRTCMeetingItem>)meetingItem;

/**
 * Designated for edit a meeting with meeting item.
 */
- (BOOL)editMeeting:(id<MobileRTCMeetingItem>)meetingItem;

/**
 * Designated for delete a meeting with meeting item.
 */
- (BOOL)deleteMeeting:(id<MobileRTCMeetingItem>)meetingItem;

/**
 * Designated for list all of meetings which belong to the logged in user.
 */
- (BOOL)listMeeting;

@end

/**
 * MobileRTCMeetingItem
 * which can be used to store the meeting information.
 */
@protocol MobileRTCMeetingItem <NSObject>

/**
 * Meeting Topic
 */
- (void)setMeetingTopic:(NSString*)topic;
- (NSString*)getMeetingTopic;

/**
 * Meeting ID
 */
- (void)setMeetingID:(NSString*)mid;
- (NSString*)getMeetingID;

/**
 * Meeting Number
 */
- (void)setMeetingNumber:(unsigned long long)number;
- (unsigned long long)getMeetingNumber;

/**
 * Original Meeting Number
 */
- (void)setOriginalMeetingNumber:(unsigned long long)number;
- (long long)getOriginalMeetingNumber;

/**
 * Meeting Password
 */
- (void)setMeetingPassword:(NSString*)password;
- (NSString*)getMeetingPassword;

/**
 * Timezone ID
 */
- (void)setTimeZoneID:(NSString*)tzID;
- (NSString*)getTimeZoneID;

/**
 * Start Time
 */
- (void)setStartTime:(NSDate*)startTime;
- (NSDate*)getStartTime;

/**
 * Meeting Duration in minutes
 */
- (void)setDurationInMinutes:(NSUInteger)duration;
- (NSUInteger)getDurationInMinutes;

/**
 * Recurring Meeting
 */
- (void)setAsRecurringMeeting:(BOOL)recurring;
- (BOOL)isRecurringMeeting;

/**
 * Turn off host video
 */
- (void)turnOffVideoForHost:(BOOL)turnOff;
- (BOOL)isHostVideoOff;

/**
 * Turn off attendee video while joining meeting
 */
- (void)turnOffVideoForAttendee:(BOOL)turnOff;
- (BOOL)isAttendeeVideoOff;

/**
 * Allow to join a meeting before host
 */
- (void)setAllowJoinBeforeHost:(BOOL)allow;
- (BOOL)canJoinBeforeHost;

/**
 * The Meeting ID use PMI
 */
- (void)setUsePMIAsMeetingID:(BOOL)usePMI;
- (BOOL)isUsePMIAsMeetingID;

/**
 * The meeting is a personal meeting
 */
- (BOOL)isPersonalMeeting;

/**
 * The meeting is a Webinar meeting
 */
- (BOOL)isWebinarMeeting;

@end

/**
 * MobileRTCPremeetingDelegate
 * which can be used to sink the event of schedule/edit/eidt/list meeting:
 */
@protocol MobileRTCPremeetingDelegate <NSObject>

/**
 * Designated for sink the event of schedule meeting.
 */
- (void)sinkSchedultMeeting:(NSInteger)result;

/**
 * Designated for sink the event of edit meeting.
 */
- (void)sinkEditMeeting:(NSInteger)result;

/**
 * Designated for sink the event of delete meeting.
 */
- (void)sinkDeleteMeeting:(NSInteger)result;

/**
 * Designated for sink the event of list meeting.
 */
- (void)sinkListMeeting:(NSInteger)result withMeetingItems:(NSArray*)array;

@end