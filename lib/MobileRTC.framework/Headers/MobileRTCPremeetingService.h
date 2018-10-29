//
//  MobileRTCPremeetingService.h
//  MobileRTC
//
//  Created by Robust Hu on 16/8/3.
//  Copyright © 2016年 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MobileRTCConstants.h"

@protocol MobileRTCMeetingItem;
@protocol MobileRTCPremeetingDelegate;

/*!
 @brief MeetingFrequency An Enum which provide recurence meeting frequency type.
 */
typedef enum {
    ///None
    MeetingRepeat_None = 0,
    ///Every Day
    MeetingRepeat_EveryDay,
    ///Every Week
    MeetingRepeat_EveryWeek,
    ///Every 2 Weeks
    MeetingRepeat_Every2Weeks,
    ///Every Month
    MeetingRepeat_EveryMonth,
    ///Every Year
    MeetingRepeat_EveryYear,
}MeetingRepeat;

/*!
 @brief PreMeetingError An Enum which provide error code for Pre-meeting.
 */
typedef enum {
    ///Unknown
    PreMeetingError_Unknown                         = -1,
    ///Success
    PreMeetingError_Success                         = 0,
    ///Error Domain
    PreMeetingError_ErrorDomain                     = 1,
    ///Error Service
    PreMeetingError_ErrorService                    = 2,
    ///Input Validation Error
    PreMeetingError_ErrorInputValidation            = 300,
    ///Http Response Error
    PreMeetingError_ErrorHttpResponse               = 404,
    ///Error No Meeting Number
    PreMeetingError_ErrorNoMeetingNumber            = 3009,
    ///Error Time out
    PreMeetingError_ErrorTimeOut                    = 5003,
}PreMeetingError;

/*!
 @brief MobileRTCPremeetingService provides support for schedule/edit/delete meeting MobileRTC once login with work email or login with SSO.
 @warning Before using MobileRTCPremeetingService, the MobileRTC should be logged in.
 */
@interface MobileRTCPremeetingService : NSObject

/*!
 @brief The object that acts as the delegate of the receiving schedule/edit/delete meeting events.
 */
@property (nullable, assign, nonatomic) id<MobileRTCPremeetingDelegate> delegate;

/*!
 @brief Designated for creating a meeting item which is used to edit meeting.
 @return an object of id<MobileRTCMeetingItem>.
 @warning the created meeting item should be destroyed by method destroyMeetingItem finally.
 */
- (nullable id<MobileRTCMeetingItem>)createMeetingItem;

/*!
 @brief Designated for clone a meeting item which is used to clone meeting.
 @return an object of id<MobileRTCMeetingItem>.
 @warning the clone meeting item should be destroyed by method destroyMeetingItem finally.
 */
- (nullable id<MobileRTCMeetingItem>)cloneMeetingItem:(nonnull id<MobileRTCMeetingItem>)item;

/*!
 @brief Designated for deatroy a previous created meeting item.
 @param item the meeting item.
 */
- (void)destroyMeetingItem:(nonnull id<MobileRTCMeetingItem>)item;

/*!
 @brief Designated for get a meeting item by a meeting number.
 @param meetingNumber the meeting number in unsigned integer.
 @return an object of id<MobileRTCMeetingItem>.
 */
- (nullable id<MobileRTCMeetingItem>)getMeetingItemByUniquedID:(unsigned long long)meetingUniquedID;

/*!
 @brief Designated for schudle a meeting with meeting item.
 @param meetingItem the meeting item
 @param useremail: user's email thar meeting is scheduled for, if schedule for yourself, pass nil or yourself email.
 @return YES means call this method successfully.
 */
- (BOOL)scheduleMeeting:(nonnull id<MobileRTCMeetingItem>)meetingItem WithScheduleFor:(nullable NSString *)userEmail;

/*!
 @brief Designated for edit a meeting with meeting item.
 @param meetingItem the meeting item
 @return YES means call this method successfully.
 @warning App need to clone one meetingitem while edit the meeting, the clone meeting item should be destroyed by method destroyMeetingItem finally.
 */
- (BOOL)editMeeting:(nonnull id<MobileRTCMeetingItem>)meetingItem;

/*!
 @brief Designated for delete a meeting with meeting item.
 @param meetingItem the meeting item
 @return YES means call this method successfully.
 */
- (BOOL)deleteMeeting:(nonnull id<MobileRTCMeetingItem>)meetingItem;

/*!
 @brief Designated for list all of meetings which belong to the logged in user.
 @return YES means call this method successfully.
 */
- (BOOL)listMeeting;

@end

/*!
 @brief MobileRTCMeetingItem can be used to store the meeting information.
 */
@protocol MobileRTCMeetingItem <NSObject>

/*!
 @brief Get Meeting Uniqued ID.
 @return the meeting Uniqued ID in long long.
 */
- (unsigned long long)getMeetingUniquedID;

/*!
 @brief Set Meeting Topic.
 @param topic the meeting topic
 */
- (void)setMeetingTopic:(nonnull NSString*)topic;

/*!
 @brief Get Meeting Topic.
 @return the meeting topic
 */
- (nullable NSString*)getMeetingTopic;

/*!
 @brief Set Meeting ID.
 @param mid the meeting ID
 */
- (void)setMeetingID:(nonnull NSString*)mid;

/*!
 @brief Get Meeting ID.
 @return the meeting ID
 */
- (nullable NSString*)getMeetingID;

/*!
 @brief Set Meeting Number.
 @param number the meeting number in unsigned integer.
 */
- (void)setMeetingNumber:(unsigned long long)number;

/*!
 @brief Get Meeting Number.
 @return the meeting number in unsigned integer.
 */
- (unsigned long long)getMeetingNumber;

/*!
 @brief Set Meeting Password.
 @param password meeting password
 */
- (void)setMeetingPassword:(nonnull NSString*)password;

/*!
 @brief Get Meeting Password.
 @return meeting password
 */
- (nullable NSString*)getMeetingPassword;

/*!
 @brief Set Timezone ID.
 @param tzID the timezone ID.
 */
- (void)setTimeZoneID:(nonnull NSString*)tzID;

/*!
 @brief Get Timezone ID.
 @return the timezone ID.
 */
- (nullable NSString*)getTimeZoneID;

/*!
 @brief Set Meeting Start Time.
 @param startTime the start time of meeting
 */
- (void)setStartTime:(nonnull NSDate*)startTime;

/*!
 @brief Get Meeting Start Time.
 @return the start time of meeting
 */
- (nullable NSDate*)getStartTime;

/*!
 @brief Set Meeting Duration in minutes.
 @param duration the duration of meeting
 */
- (void)setDurationInMinutes:(NSUInteger)duration;

/*!
 @brief Get Meeting Duration in minutes.
 @return the duration of meeting
 */
- (NSUInteger)getDurationInMinutes;

/*!
 @brief Get Recurring Meeting.
 @return YES means recurring
 */
- (BOOL)isRecurringMeeting;

/*!
 @brief Set Recurring Meeting Repeat.
 @param repeat the type of recurring Repeat
 */
- (void)setMeetingRepeat:(MeetingRepeat)repeat;

/*!
 @brief Get Recurring Meeting Repeat.
 @return the type of recurring Repeat
 */
- (MeetingRepeat)getMeetingRepeat;

/*!
 @brief Set Recurring Meeting Repeat End Date.
 @param endDate, the end date should be later the meeting start time.
 @warning If not set this method, the recurring meeting can be repeated for ever.
 */
- (void)setRepeatEndDate:(nonnull NSDate*)endDate;

/*!
 @brief Get Recurring Meeting Repeat End Date.
 @return the date of ending recurring Repeat
 */
- (nullable NSDate*)getRepeatEndDate;

/*!
 @brief Set Turn off host video.
 @param turnOff YES means turn off host's video
 */
- (void)turnOffVideoForHost:(BOOL)turnOff;

/*!
 @brief Get Turn off host video.
 @return YES means turn off host's video
 */
- (BOOL)isHostVideoOff;

/*!
 @brief Set Turn off attendee video while joining meeting.
 @param turnOff YES means turn off attendee's video
 */
- (void)turnOffVideoForAttendee:(BOOL)turnOff;

/*!
 @brief Get Turn off attendee video while joining meeting.
 @return YES means turn off attendee's video
 */
- (BOOL)isAttendeeVideoOff;

/*!
 @brief Set Allow to join a meeting before host.
 @param allow YES means allow
 */
- (void)setAllowJoinBeforeHost:(BOOL)allow;

/*!
 @brief Get Allow to join a meeting before host.
 @return YES means allow
 */
- (BOOL)canJoinBeforeHost;

/*!
 @brief Set Use Personal Meeting ID.
 @param usePMI YES means use PMI
 */
- (void)setUsePMIAsMeetingID:(BOOL)usePMI;

/*!
 @brief Get Use Personal Meeting ID.
 @return YES means use PMI
 */
- (BOOL)isUsePMIAsMeetingID;

///*!
// @brief Turn on or off Viop.
// @param off YES means disable Voip
// @waring - (void)turnOffVOIP:(BOOL)off has been deprecated, please use - (BOOL)setAudioOption:(MobileRTCMeetingItemAudioType)audioOption instead.
// */
//- (void)turnOffVOIP:(BOOL)off;
//
///*!
// @brief Get Voip is on or off.
// @return YES means Voip is off
// @waring - (BOOL)isVOIPOff has been deprecated, please use - (MobileRTCMeetingItemAudioType)getAduioOption instead.
// */
//- (BOOL)isVOIPOff;
//
///*!
// @brief Turn on or off Telephone.
// @param off YES means disable Telephone
// @waring - (void)turnOffTelephony:(BOOL)off has been deprecated, please use - (BOOL)setAudioOption:(MobileRTCMeetingItemAudioType)audioOption instead.
// */
//- (void)turnOffTelephony:(BOOL)off;
//
///*!
// @brief Get Telephone is on or off.
// @return YES means Telephone is off
// @waring - (BOOL)isTelephonyOff has been deprecated, please use - (MobileRTCMeetingItemAudioType)getAduioOption instead.
// */
//- (BOOL)isTelephonyOff;

/*!
 @brief Set Meeting Audio Option.
 @param MobileRTCMeetingItemAudioType audioOption
 @return YES means call this method successfully.
 */
- (BOOL)setAudioOption:(MobileRTCMeetingItemAudioType)audioOption;

/*!
 @brief Get Meeting Audio Option.
 @return MobileRTCMeetingItemAudioType audioOption
 */
- (MobileRTCMeetingItemAudioType)getAduioOption;

/*!
 @brief The meeting is a personal meeting.
 @return YES means Personal Meeting.
 */
- (BOOL)isPersonalMeeting;

/*!
 @brief The meeting is a Webinar meeting.
 @return YES means Webinar meeting.
 */
- (BOOL)isWebinarMeeting;

/*!
 @brief To get the content of invite email.
 @return the content of invite email.
 */
- (nullable NSString*)getInviteEmailContent;

/*!
 @brief Turn on or off only allow signed-in user join meeting.
 @param off YES means only allow signed-in user join meeting
*/
- (BOOL)setOnlyAllowSignedInUserJoinMeeting:(BOOL)on;

/*!
 @brief Get only allow signed-in user join meeting is on or off.
 @return YES means only allow signed-in user join meeting
*/
- (BOOL)isOnlyAllowSignedInUserJoinMeeting;

/*!
 @brief This method is set 3rd Party Audio Info.
 @param description 3rd Party Audio Info
 @return YES means call this method successfully.
 */
- (BOOL)set3rdPartyAudioInfo:(nonnull NSString *)description;

/*!
 @brief This method is get 3rd Party Audio Info.
 @return send 3rd Party Audio Info.
 */
- (nullable NSString *)get3rdPartyAudioInfo;

/*!
 @brief This method is get useremail of the meeting host.
 @return useremail of the meeting host.
 */
- (nullable NSString *)getScheduleForUserEmail;

/*!
 @brief Set Meeting record Option.
 @param automatic record the meeting.
 @param MobileRTCMeetingItemRecordType record type.
 @return YES means call this method successfully.
 */
- (BOOL)setRecordType:(MobileRTCMeetingItemRecordType)recordType;

/*!
 @brief  This method is get meeting record type.
 @return MobileRTCMeetingItemRecordType record type.
 */
- (MobileRTCMeetingItemRecordType)getRecordType;

/*!
 @brief  This method is set specified domain which user can join this meeting when they sign in.
 @param NSString type default Sepecified of domain array.
 @return YES means call this method successfully.
 */
- (BOOL)setSpecifiedDomain:(nullable NSArray*)domain;

/*!
 @brief  This method is get specified domain which user can join this meeting when they sign in.
 @return NSString type default Sepecified of domain array.
 */
- (nullable NSArray *)getSpecifiedDomain;
@end

/*!
 @protocol MobileRTCPremeetingDelegate
 @brief MobileRTCPremeetingDelegate can be used to sink the event of schedule/edit/eidt/list meeting.
 @discussion the result of the following methods means schedule/edit/delete/list meeting success or not.
 */
@protocol MobileRTCPremeetingDelegate <NSObject>

/*!
 @brief Designated for sink the event of schedule meeting.
 @param result the return result of schedule meeting, PreMeetingError_Success means success.
 */
- (void)sinkSchedultMeeting:(PreMeetingError)result MeetingUniquedID:(unsigned long long)uniquedID;

/*!
 @brief Designated for sink the event of edit meeting.
 @param result the return result of edit meeting, PreMeetingError_Success means success.
 */
- (void)sinkEditMeeting:(PreMeetingError)result MeetingUniquedID:(unsigned long long)uniquedID;

/*!
 @brief Designated for sink the event of delete meeting.
 @param result the return result of delete meeting, PreMeetingError_Success means success.
 */
- (void)sinkDeleteMeeting:(PreMeetingError)result;

/*!
 @brief Designated for sink the event of list meeting.
 @param result the return result of list meeting, PreMeetingError_Success means success
 @param array the array of meeting items.
 */
- (void)sinkListMeeting:(PreMeetingError)result withMeetingItems:(nonnull NSArray*)array;

@end
