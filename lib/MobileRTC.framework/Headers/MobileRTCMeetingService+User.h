//
//  MobileRTCMeetingService+User.h
//  MobileRTC
//
//  Created by Chao Bai on 2018/6/6.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import <MobileRTC/MobileRTC.h>

@interface MobileRTCMeetingService (User)

/*!
 @brief This method is used to change user's display name in meeting.
 @param inputName the display name which will be used in meeting.
 @param userId user's ID in meeting.
 @return YES means call this method successfully.
 @warning Non-Host user can change self name, Host can change other attendee's name.
 */
- (BOOL)changeName:(nonnull NSString*)inputName withUserID:(NSUInteger)userId;

/*!
 @brief This method is used to get all the users in the meeting.
 @return user id array, each user id is a NSNumber object.
 @warning For Webinar Meeting, returned list does not include Attendee User
 */
- (nullable NSArray*)getInMeetingUserList;

/*!
 @brief This method is used to get all the attendee in the webinar meeting.
 @return user id array, each Attendee id is a NSNumber object.
 */
- (nullable NSArray*)getWebinarAttendeeList;
/*!
 @brief This method is used to get user info in the meeting.
 @param userId user's ID in meeting.
 @return user info, a MobileRTCMeetingUserInfo object.
 */
- (nullable MobileRTCMeetingUserInfo*)userInfoByID:(NSUInteger)userId;

/*!
 @brief This method is used to get attendee info in the webinar meeting.
 @param userId attendee's ID in meeting.
 @return attendee info, a MobileRTCMeetingWebinarAttendeeInfo object.
 */
- (nullable MobileRTCMeetingWebinarAttendeeInfo*)attendeeInfoByID:(NSUInteger)userId;

/*!
 @brief This method is used to assign host role to another user in the meeting.
 @param userId the user id in meeting.
 @return YES means call this method successfully.
 @warning only meeting host can run this function, and userId should not be myself.
 */
- (BOOL)makeHost:(NSUInteger)userId;

/*!
 @brief This method is used to remove a user in the meeting.
 @param userId the user id in meeting.
 @return YES means call this method successfully.
 @warning only meeting host can run this function, and userId should not be myself.
 */
- (BOOL)removeUser:(NSUInteger)userId;

/*!
 @brief This method is used to get my user id in the meeting.
 @return my user id.
 */
- (NSUInteger)myselfUserID;

/*!
 @brief This method is used to get active user id in the meeting.
 @return active user id.
 */
- (NSUInteger)activeUserID;

/*!
 @brief This method is used to get active share user id in the meeting.
 @return active share user id.
 */
- (NSUInteger)activeShareUserID;

/*!
 @brief This method is used to judge the same user.
 @param user1 the user id in meeting
 @param user2 the user id in meeting
 @return YES means the same user.
 */
- (BOOL)isSameUser:(NSUInteger)user1 compareTo:(NSUInteger)user2;

/*!
 @brief This method is used to check the user is host or not.
 @param userID the user id in meeting
 @return YES means host.
 */
- (BOOL)isHostUser:(NSUInteger)userID;

/*!
 @brief This method is used to check the user is myself or not.
 @param userID the user id in meeting
 @return YES means myself.
 */
- (BOOL)isMyself:(NSUInteger)userID;

/*!
 @brief This method is used to raise my hand.
 @return YES means call this method successfully.
 */
- (BOOL)raiseMyHand;
/*!
 @brief This method is used to lower user's hand.
 @return YES means call this method successfully.
 */
- (BOOL)lowerHand:(NSUInteger)userId;

/*!
 @brief This method is used to lower all users' hand.
 @return YES means call this method successfully.
 @warning only meeting host can run this function.
 */
- (BOOL)lowerAllHand;

/*!
 @brief This method is used to claim Host With Host Key.
 @param hostKey indicate host Key.
 @return YES means call this method successfully.
 */
- (BOOL)claimHostWithHostKey:(nonnull NSString*)hostKey;

/*!
 @brief This method is used to assign co-host.
 @return YES means call this method successfully.
 @warning only meeting host can run this function.
 */
- (BOOL)assignCohost:(NSUInteger)userID;

/*!
 @brief This method is used to revoke co-host.
 @return YES means call this method successfully.
 @warning only meeting host can run this function.
 */
- (BOOL)revokeCoHost:(NSUInteger)userID;

/*!
 @brief This method is used to check user can be co-host or not.
 @return YES means call this method successfully.
 */
- (BOOL)canBeCoHost:(NSUInteger)userID;
@end
