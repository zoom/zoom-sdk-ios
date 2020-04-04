//
//  MobileRTCMeetingService+User.h
//  MobileRTC
//
//  Created by Chao Bai on 2018/6/6.
//  Copyright © 2019 Zoom Video Communications, Inc. All rights reserved.
//

#import <MobileRTC/MobileRTC.h>

@interface MobileRTCMeetingService (User)

/*!
 @brief Set to change user's screen name in meeting.
 @param inputName The screen name displayed in meeting.
 @param userId User ID.
 @return YES means that the method is called successfully, otherwise not.
 @warning Normal user can change his own screen name, while the host/co-host can change all attendees' names. 
 */
- (BOOL)changeName:(nonnull NSString*)inputName withUserID:(NSUInteger)userId;

/*!
 @brief Get all the users in the meeting.
 @return user id array, each user id is a NSNumber object.
 @warning For Webinar Meeting, returned list does not include Attendee User
 */
- (nullable NSArray*)getInMeetingUserList;

/*!
 @brief Get all the attendees in the webinar.
 @return user id array, each Attendee id is a NSNumber object.
 @warning Only webinar meeting host/co-host/panelist can run the function.
 */
- (nullable NSArray*)getWebinarAttendeeList;
/*!
 @brief Get user information in the meeting.
 @param userId In-meeting user ID.
 @return User information.
 */
- (nullable MobileRTCMeetingUserInfo*)userInfoByID:(NSUInteger)userId;

/*!
 @brief Get attendees' information in the webinar.
 @param userId attendee's ID in meeting.
 @return attendee info, a MobileRTCMeetingWebinarAttendeeInfo object.
 @warning Only webinar meeting host/co-host/panelist can run the function.
 */
- (nullable MobileRTCMeetingWebinarAttendeeInfo*)attendeeInfoByID:(NSUInteger)userId;

/*!
 @brief Assign a user as the host in meeting.
 @param userId The ID of user who is specified as host in meeting.
 @return YES means that the method is called successfully, otherwise not.
 @warning only meeting host can run this function, and userId should not be myself.
 */
- (BOOL)makeHost:(NSUInteger)userId;

/*!
 @brief Remove a user from the meeting.
 @param userId The ID of user to be removed from the meeting.
 @return YES means that the method is called successfully, otherwise not.
 @warning The method is available only for the host, and the host can not remove himself.
 */
- (BOOL)removeUser:(NSUInteger)userId;

/*!
 @brief Get the ID of the current user in the meeting.
 @return The ID of the current user.
 */
- (NSUInteger)myselfUserID;

/*!
 @brief Get the ID of the active user in the meeting.
 @return Active user ID.
 */
- (NSUInteger)activeUserID;

/*!
 @brief Get the ID of user who is sharing in the meeting.
 @return The ID of user who is sharing in the meeting.
 */
- (NSUInteger)activeShareUserID;

/*!
 @brief Judge if the two IDs from different sessions are of the same user.
 @param user1 One user ID in meeting
 @param user2 Another user ID in meeting
 @return YES means the same user.
 */
- (BOOL)isSameUser:(NSUInteger)user1 compareTo:(NSUInteger)user2;

/*!
 @brief Query if the user is host.
 @param userID The ID of user.
 @return YES means that the user is the host, otherwise not.
 */
- (BOOL)isHostUser:(NSUInteger)userID;

/*!
 @brief Query if the ID is the current user's.  
 @param userID The ID of user to be checked.
 @return TRUE means user himself. FALSE not.
 */
- (BOOL)isMyself:(NSUInteger)userID;

/*!
 @brief Raise hand of the current user.
 @return YES means that the method is called successfully, otherwise not.
 */
- (BOOL)raiseMyHand;
/*!
 @brief Put hands down of the current user.
 @return YES means that the method is called successfully, otherwise not.
 */
- (BOOL)lowerHand:(NSUInteger)userId;

/*!
 @brief Set to put all users' hands down.
 @return YES means that the method is called successfully, otherwise not.
 @warning Only meeting host can run the function.
 */
- (BOOL)lowerAllHand;

/*!
 @brief Set to claim to be a host by host key.
 @param hostKey Host key.
 @return YES means that the method is called successfully, otherwise not.
 */
- (BOOL)claimHostWithHostKey:(nonnull NSString*)hostKey;

/*!
 @brief Assign a user as co-host in meeting.
 @return YES means that the method is called successfully, otherwise not.
 @warning The co-host cannot be assigned as co-host by himself. And the user should have the power to assign the role.
 */
- (BOOL)assignCohost:(NSUInteger)userID;

/*!
 @brief Revoke co-host role of another user in meeting.
 @return YES means that the method is called successfully, otherwise not.
 @warning Only meeting host can run the function.
 */
- (BOOL)revokeCoHost:(NSUInteger)userID;

/*!
 @brief Query if the user can be assigned as co-host in meeting.
 @return YES means that the method is called successfully, otherwise not.
 */
- (BOOL)canBeCoHost:(NSUInteger)userID;
@end
