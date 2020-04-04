//
//  MobileRTCPremeetingService.h
//  MobileRTC
//
//  Created by Robust Hu on 16/8/3.
//  Copyright © 2019年 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MobileRTCConstants.h"
#import "MobileRTCDialinCountry.h"

@protocol MobileRTCMeetingItem;
@protocol MobileRTCPremeetingDelegate;

/*!
 @brief MeetingRepeat An Enumeration of meeting recurring types..
 */
typedef enum {
    ///Not recurring.
    MeetingRepeat_None = 0,
    ///Recurring daily.
    MeetingRepeat_EveryDay,
    ///Recurring weekly.
    MeetingRepeat_EveryWeek,
    ///Recurring biweekly.
    MeetingRepeat_Every2Weeks,
    ///Recurring monthly.
    MeetingRepeat_EveryMonth,
    ///Recurring annually.
    MeetingRepeat_EveryYear,
}MeetingRepeat;

/*!
 @brief PreMeetingError Pre-meeting Error codes.
 */
typedef enum {
    ///Unknown error.
    PreMeetingError_Unknown                         = -1,
    ///Calls API successfully.
    PreMeetingError_Success                         = 0,
    ///Incorrect domain.  
    PreMeetingError_ErrorDomain                     = 1,
    ///Service is wrong.    
    PreMeetingError_ErrorService                    = 2,
    ///The information input by user is incorrect. 
    PreMeetingError_ErrorInputValidation            = 300,
    ///The resource requested does not exist.  
    PreMeetingError_ErrorHttpResponse               = 404,
    ///No meeting number.
    PreMeetingError_ErrorNoMeetingNumber            = 3009,
    ///Timeout.
    PreMeetingError_ErrorTimeOut                    = 5003,
}PreMeetingError;

/*!
 @brief It provides support for scheduling/editing/deleting meeting once logged in MobileRTC with working email or with SSO.
 @warning User should login MobileRTC before calling the method.
 */
@interface MobileRTCPremeetingService : NSObject

/*!
 @brief Callback event of receiving the scheduled/edited/deleted meeting.
 */
@property (nullable, assign, nonatomic) id<MobileRTCPremeetingDelegate> delegate;

/*!
 @brief A meeting item is created to edit meeting.
 @return An object of id<MobileRTCMeetingItem>.
 @warning The created meeting item should be destroyed finally via destroyMeetingItem.
 */
- (nullable id<MobileRTCMeetingItem>)createMeetingItem;

/*!
 @brief A meeting item is created to clone meeting.
 @return An object of id<MobileRTCMeetingItem>.
 @warning The clonal meeting item should be destroyed finally via destroyMeetingItem.
 */
- (nullable id<MobileRTCMeetingItem>)cloneMeetingItem:(nonnull id<MobileRTCMeetingItem>)item;

/*!
 @brief Destroy a previously created meeting item.
 @param item The meeting item to be destroyed.
 */
- (void)destroyMeetingItem:(nonnull id<MobileRTCMeetingItem>)item;

/*!
 @brief Get a meeting item by a meeting number.
 @param meetingNumber The meeting number in unsigned integer.
 @return An object of id<MobileRTCMeetingItem>.
 */
- (nullable id<MobileRTCMeetingItem>)getMeetingItemByUniquedID:(unsigned long long)meetingUniquedID;

/*!
 @brief Schedule a meeting with meeting item.
 @param meetingItem The meeting item to schedule a meeting.
 @param useremail Set the email of user who will be the host of the scheduled meeting. If the meeting is scheduled for user himself, it will pass nil or the email of user himself.
 @return YES means that the method is called successfully, otherwise not.
 */
- (BOOL)scheduleMeeting:(nonnull id<MobileRTCMeetingItem>)meetingItem WithScheduleFor:(nullable NSString *)userEmail;

/*!
 @brief Edit a meeting with meeting item.
 @param meetingItem The meeting item to edit a meeting.
 @return YES means that the method is called successfully, otherwise not.
 @warning App needs to clone the meetingitem while editing the meeting, the clonal meeting item should be destroyed finally via destroyMeetingItem.
 */
- (BOOL)editMeeting:(nonnull id<MobileRTCMeetingItem>)meetingItem;

/*!
 @brief Delete a meeting with meeting item.
 @param meetingItem The meeting item to delete a meeting.
 @return YES means that the method is called successfully, otherwise not.
 */
- (BOOL)deleteMeeting:(nonnull id<MobileRTCMeetingItem>)meetingItem;

/*!
 @brief Designated for list all of meetings which belong to the logged in user.
 @return YES means call this method successfully.
 */
- (BOOL)listMeeting;

/*!
 @brief return available dial in country object before meeting item create, you can use the ‘allCountries’ for list all the availble country for user select.
 @return available means get success, otherwise will be nil.
 */
- (nullable MobileRTCDialinCountry *)getAvailableDialInCountry;

@end

/*!
 @brief Store meeting information.
 */
@protocol MobileRTCMeetingItem <NSObject>

/*!
 @brief Get Meeting Unique ID.
 @return The meeting Unique ID. 
 */
- (unsigned long long)getMeetingUniquedID;

/*!
 @brief Set the topic of the meeting.
 @param topic The topic of the meeting.
 */
- (void)setMeetingTopic:(nonnull NSString*)topic;

/*!
 @brief Get the topic of the meeting.
 @return The topic of the meeting.
 */
- (nullable NSString*)getMeetingTopic;

/*!
 @brief Set Meeting ID.
 @param mid The ID of the meeting.
 */
- (void)setMeetingID:(nonnull NSString*)mid;

/*!
 @brief Get Meeting ID.
 @return The ID of the meeting.
 */
- (nullable NSString*)getMeetingID;

/*!
 @brief Set Meeting Number.
 @param number The meeting number in unsigned integer.
 */
- (void)setMeetingNumber:(unsigned long long)number;

/*!
 @brief Get meeting number.
 @return The meeting number in unsigned integer
 */
- (unsigned long long)getMeetingNumber;

/*!
 @brief Set the meeting password.
 @param password The password of the meeting.
 */
- (void)setMeetingPassword:(nonnull NSString*)password;

/*!
 @brief Get the meeting password.
 @return The password of the meeting.
 */
- (nullable NSString*)getMeetingPassword;

/*!
 @brief Set Timezone ID.
 @param tzID The timezone ID.
 */
- (void)setTimeZoneID:(nonnull NSString*)tzID;

/*!
 @brief Get Timezone ID.
 @return The timezone ID.
 */
- (nullable NSString*)getTimeZoneID;

/*!
 @brief Set meeting start time.
 @param startTime The start time of meeting.
 */
- (void)setStartTime:(nonnull NSDate*)startTime;

/*!
 @brief Get meeting start time.
 @return The meeting start time.
 */
- (nullable NSDate*)getStartTime;

/*!
 @brief Set the meeting duration, calculated in minutes.
 @param duration The duration of meeting.
 */
- (void)setDurationInMinutes:(NSUInteger)duration;

/*!
 @brief Get the meeting duration, calculated in minutes.
 @return The duration of meeting.
 */
- (NSUInteger)getDurationInMinutes;

/*!
 @brief Query if the meeting is a recurring one. 
 @return YES means recurring, otherwise not.
 */
- (BOOL)isRecurringMeeting;

/*!
 @brief Set meeting recurring types.
 @param repeat Meeting recurring types.
 */
- (void)setMeetingRepeat:(MeetingRepeat)repeat;

/*!
 @brief Get meeting recurring types.
 @return The recurring type of meeting.
 */
- (MeetingRepeat)getMeetingRepeat;

/*!
 @brief Set the end date of the recurring meeting.
 @param endDate The end date. It should be later than the meeting Start Time.
 @warning If it is not set, the meeting will recurring forever.
 */
- (void)setRepeatEndDate:(nonnull NSDate*)endDate;

/*!
 @brief Get the end time of the recurring meeting.
 @return The end date of the recurring meeting. 
 */
- (nullable NSDate*)getRepeatEndDate;

/*!
 @brief Turn off host's video.
 @param turnOff YES means to turn off host's video, otherwise not.
 */
- (void)turnOffVideoForHost:(BOOL)turnOff;

/*!
 @brief Query if the host video is turned off.
 @return YES means the host's video is turned off, otherwise not.
 */
- (BOOL)isHostVideoOff;

/*!
 @brief Turn off attendee's video automatically when he joins the meeting.
 @param turnOff YES means to turn off the attendee's video, otherwise not.
 */
- (void)turnOffVideoForAttendee:(BOOL)turnOff;

/*!
 @brief Query if attendee's video is turned off when he joins the meeting.
 @return YES means the attendee's video is turned off, otherwise not.
 */
- (BOOL)isAttendeeVideoOff;

/*!
 @brief Enable to join meeting before host(JBH).
 @param allow YES means enabled, otherwise not.
 */
- (void)setAllowJoinBeforeHost:(BOOL)allow;

/*!
 @brief Query if attendee can join the meeting before host.
 @return YES means able, otherwise not.
 */
- (BOOL)canJoinBeforeHost;

/*!
 @brief Set to use personal meeting ID(PMI) to start meeting.
 @param usePMI YES means to use PMI to start meeting.
 */
- (void)setUsePMIAsMeetingID:(BOOL)usePMI;

/*!
 @brief Query if the user starts the meeting with personal meeting ID.
 @return YES means that user uses PMI as the meeting number.
 */
- (BOOL)isUsePMIAsMeetingID;

/*!
 @brief Set to enable waiting room.
 @param enable YES means to enable waiting room..
 */
- (void)enableWaitingRoom:(BOOL)enable;

/*!
 @brief Query if the user starts the meeting with enable waiting room.
 @return YES means that user enable waiting room.
 */
- (BOOL)isWaitingRoomEnabled;

/*!
 @brief Set to enable list in the public event list.
 @param enable YES means to enable list in the public event list.
 */
- (void)enableMeetingToPublic:(BOOL)enable;

/*!
 @brief Query if the user starts the meeting with list in the public event list.
 @return YES means that user list in the public event list.
 */
- (BOOL)isMeetingToPublicEnabled;

/*!
 @brief Set to enable language interpretation.
 @param enable YES means to enable language interpretation.
 @warning Only non-pmi meetings can be used.
 */
- (void)enableLanguageInterpretation:(BOOL)enable;

/*!
 @brief Query if the user starts the meeting with enable language interpretation.
 @return YES means that user enable language interpretation.
 */
- (BOOL)isLanguageInterpretationEnabled;

/*!
 @brief Set alternative host.
 @param hostList NSArray that contai MobileRTCAlternativeHostInfo object.
 */
- (void)setAlternativeHostList:(NSArray *_Nonnull)hostList;

/*!
 @brief Get alternative host list.
 @param enable YES means to enable language interpretation.
 */
- (NSArray *_Nullable)getAlternativeHostInfoList;

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
 @brief Set audio options in the meeting.
 @param MobileRTCMeetingItemAudioType The audio options in the meeting.
 @return YES means that the method is called successfully, otherwise not.
 */
- (BOOL)setAudioOption:(MobileRTCMeetingItemAudioType)audioOption;

/*!
 @brief Get audio options in the meeting.
 @return MobileRTCMeetingItemAudioType The audio options in the meeting.
 */
- (MobileRTCMeetingItemAudioType)getAduioOption;

/*!
 @brief Query if the meeting is a personal one.
 @return YES means that the meeting is personal, otherwise not.
 */
- (BOOL)isPersonalMeeting;

/*!
 @brief Query if the meeting is a Webinar.
 @return YES means that the meeting is a Webinar, otherwise not.
 */
- (BOOL)isWebinarMeeting;

/*!
 @brief Get the content of email invitation.
 @return The content of email invitation.
 */
- (nullable NSString*)getInviteEmailContent;

/*!
 @brief Set if enable the feature ONLY SINGED-IN USER CAN JOIN MEETING.
 @param off YES means enabled, otherwise not.
*/
- (BOOL)setOnlyAllowSignedInUserJoinMeeting:(BOOL)on;

/*!
 @brief Set available diain countries object.
 @param diain country object.
 @return YES means set success, otherwise the sign in status not right or diain object of dialinCountry not available.
 */
- (BOOL)setAvailableDialinCountry:(nonnull MobileRTCDialinCountry *)dialinCountry;

/*!
 @brief return meeting item's available dial in country object of Meeting item's, for check the schedule's meeting detail info.
        If you want to list all available country, please use the PreMeeting Service's getAvailableDialInCountry.
        PreMeeting Service's getAvailableDialInCountry -> hold the object. -> list all country to let user select. -> set the select countries to the object. -> set the object to meeting item.
 @return available means get success, otherwise will be nil.
 */
- (nullable MobileRTCDialinCountry *)getAvailableDialInCountry;

/*!
 @brief Query if the feature ONLY SINGED-IN USER CAN JOIN MEETING is enabled.
 @return YES means enabled, otherwise not.
*/
- (BOOL)isOnlyAllowSignedInUserJoinMeeting;

/*!
 @brief Set the 3rd Party Audio Information.
 @param description The 3rd Party Audio Information.
 @return YES means that the method is called successfully, otherwise not.
 */
- (BOOL)set3rdPartyAudioInfo:(nonnull NSString *)description;

/*!
 @brief Get 3rd Party Audio Information.
 @return The 3rd Party Audio Information.
 */
- (nullable NSString *)get3rdPartyAudioInfo;

/*!
 @brief Get the email of the meeting host.
 @return useremail The email of the meeting host.
 */
- (nullable NSString *)getScheduleForUserEmail;

/*!
 @brief Set meeting recording options.
 @param recordType Recording type.
 @return YES means that the method is called successfully, otherwise not.
 */
- (BOOL)setRecordType:(MobileRTCMeetingItemRecordType)recordType;

/*!
 @brief Get meeting recording type.
 @return Meeting recording type.
 */
- (MobileRTCMeetingItemRecordType)getRecordType;

/*!
 @brief Set specified domains in which users can join the current meeting once they signed in.
 @param domain NSString type of domain array. 
 @return YES means that the method is called successfully, otherwise not.
 */
- (BOOL)setSpecifiedDomain:(nullable NSArray*)domain;

/*!
 @brief Get specified domains in which users can join the current meeting once they signed in.
 @return The specified domains.
 */
- (nullable NSArray *)getSpecifiedDomain;
@end

/*!
 @brief MobileRTCAlternativeHostInfo, It's used to schedule meetings and add alternate hosts.
 */
@interface MobileRTCAlternativeHostInfo : NSObject

@property (nonatomic, retain) NSString * _Nullable email;

@end

/*!
 @protocol MobileRTCPremeetingDelegate
 @brief Sink the event of scheduling/editing/deleting/listing a meeting.
 @warning the result of the following methods means schedule/edit/delete/list meeting success or not.
 */
@protocol MobileRTCPremeetingDelegate <NSObject>

/*!
 @brief Sink the event of scheduling a meeting.
 @param result The result of scheduling a meeting. If the function succeeds, it will return PreMeetingError_Success.
 */
- (void)sinkSchedultMeeting:(PreMeetingError)result MeetingUniquedID:(unsigned long long)uniquedID;

/*!
 @brief Sink the event of editing a meeting.
 @param result The result of editing a meeting. If the function succeeds, it will return PreMeetingError_Success.
 */
- (void)sinkEditMeeting:(PreMeetingError)result MeetingUniquedID:(unsigned long long)uniquedID;

/*!
 @brief Sink the event of deleting a meeting.
 @param result The result of deleting a meeting. If the function succeeds, it will return PreMeetingError_Success.
 */
- (void)sinkDeleteMeeting:(PreMeetingError)result;

/*!
 @brief Sink the event of listing meetings.
 @param result The result of listing meetings. If the function succeeds, it will return PreMeetingError_Success.
 @param array The array of meeting items.
 */
- (void)sinkListMeeting:(PreMeetingError)result withMeetingItems:(nonnull NSArray*)array;
@end
