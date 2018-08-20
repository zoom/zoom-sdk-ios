//
//  MobileRTCMeetingService+Webinar.h
//  MobileRTC
//
//  Created by chaobai admin on 07/08/2018.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import <MobileRTC/MobileRTC.h>

@interface MobileRTCMeetingService (Webinar)

/*!
 @brief This method is used to check user has Prompt and DePrompt Privilige in Webinar Meeting.
 @return YES means user can Prompt and DePrompt user.
 */
- (BOOL)hasPromptAndDePromptPrivilige;

/*!
 @brief This method is used to prompt Attendee to Panelist in Webinar Meeting.
 @return YES means call this method successfully.
 @warning only meeting host/cohost can run this function.
 */
- (BOOL)promptAttendee2Panelist:(NSUInteger)userID;

/*!
 @brief This method is used to deprompt Panelist to attendee in Webinar Meeting.
 @return YES means call this method successfully.
 @warning only meeting host/cohost can run this function.
 */
- (BOOL)dePromptPanelist2Attendee:(NSUInteger)userID;

/*!
 @brief This method is used to set Attendee chat privilige in Webinar Meeting.
 @return YES means call this method successfully.
 @warning only meeting host/cohost can run this function.
 */
- (BOOL)allowAttendeeChat:(MobileRTCChatAllowAttendeeChat)privilegeType;

/*!
 @brief This method is used to check Attendee is allowed to talk in Webinar Meeting.
 @param userId user's ID in meeting.
 @return YES means attendee allowed to talk.
 @warning only meeting host/cohost can run this function.
 */
- (BOOL)isAllowAttendeeTalk:(NSUInteger)userID;

/*!
 @brief This method is used to allow Attendee talk in Webinar Meeting.
 @param userId user's ID in meeting.
 @param Enable enable/Disable User talk
 @return YES means call this method successfully.
 @warning only meeting host/cohost can run this function.
 */
- (BOOL)allowAttenddeTalk:(NSUInteger)userID allow:(BOOL)enable;

/*!
 @brief This method is used to check Panelist is allowed to start video in Webinar Meeting.
 @return YES means Panelist allowed to start video.
 */
- (BOOL)isAllowPanelistStartVideo;


#pragma mark Q&A relate Action in Webinar Meeting
/*!
 @brief This method is used to allow Panelist start video in Webinar Meeting.
 @param Enable enable/Disable Panelist start video.
 @return YES means call this method successfully.
 @warning only meeting host/cohost can run this function.
 */
- (BOOL)allowPanelistStartVideo:(BOOL)enable;

/*!
 @brief This method is used to check is allowed to ask question anonymously.
 @return YES means allowed to ask question anonymously.
 */
- (BOOL)isAllowAskQuestionAnonymously;

/*!
 @brief This method is used to allow ask question anonymously.
 @param Enable enable/Disable allow ask question anonymously.
 @return YES means call this method successfully.
 @warning only meeting host/cohost can run this function.
 */
- (BOOL)allowAskQuestionAnonymously:(BOOL)enable;

/*!
 @brief This method is used to check is allowed attendee to view all question.
 @return YES means allowed attendee to view all question.
 */
- (BOOL)isAllowAttendeeViewAllQuestion;

/*!
 @brief This method is used to allow attendee to view all question.
 @param Enable enable/Disable allow attendee to view all question.
 @return YES means call this method successfully.
 @warning only meeting host/cohost can run this function.
 */
- (BOOL)allowAttendeeViewAllQuestion:(BOOL)enable;

/*!
 @brief This method is used to check is allowed attendee to upVote question.
 @return YES means allowed attendee to UpVote question.
 */
- (BOOL)isAllowAttendeeUpVoteQuestion;

/*!
 @brief This method is used to allow attendee to upVote question.
 @param Enable enable/Disable allow attendee to upVote question.
 @return YES means call this method successfully.
 @warning only meeting host/cohost can run this function.
 */
- (BOOL)allowAttendeeUpVoteQuestion:(BOOL)enable;

/*!
 @brief This method is used to check is allowed attendee to answer question.
 @return YES means allowed attendee to answer question.
 */
- (BOOL)isAllowAttendeeAnswerQuestion;

/*!
 @brief This method is used to allow attendee to answer question.
 @param Enable enable/Disable allow attendee to answer question.
 @return YES means call this method successfully.
 @warning only meeting host/cohost can run this function.
 */
- (BOOL)allowAttendeeAnswerQuestion:(BOOL)enable;
@end
