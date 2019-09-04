//
//  MobileRTCMeetingService+Webinar.h
//  MobileRTC
//
//  Created by chaobai admin on 07/08/2018.
//  Copyright © 2019 Zoom Video Communications, Inc. All rights reserved.
//

#import <MobileRTC/MobileRTC.h>

@interface MobileRTCMeetingService (Webinar)

/*!
 @brief Query if the user has the privilege to prompt or demote users in the webinar. 
 @return YES means that user owns the privilege, otherwise not.
 */
- (BOOL)hasPromptAndDePromptPrivilige;

/*!
 @brief Prompt Attendee to Panelist in Webinar.
 @return YES means that the method is called successfully, otherwise not.
 @warning Only meeting host/co-host can run the function.
 */
- (BOOL)promptAttendee2Panelist:(NSUInteger)userID;

/*!
 @brief Demote the panelist to attendee. 
 @return YES means that the method is called successfully, otherwise not.
 @warning Only meeting host/co-host can run the function.
 */
- (BOOL)dePromptPanelist2Attendee:(NSUInteger)userID;

/*!
 @brief Allow attendee to chat.
 @return YES means that the method is called successfully, otherwise not.
 @warning Only meeting host/co-host can run the function.
 */
- (BOOL)allowAttendeeChat:(MobileRTCChatAllowAttendeeChat)privilegeType;

/*!
 @brief Query if attendee is allowed to talk in Webinar Meeting.
 @param userId The ID of user to be allowed. 
 @return YES means allowed, otherwise not.
 @warning Only meeting host/co-host can run the function.
 */
- (BOOL)isAllowAttendeeTalk:(NSUInteger)userID;

/*!
 @brief Allow attendee to talk in webinar.
 @param userId The ID of user to be allowed
 @param enable Enable/Disable to talk
 @return YES means that the method is called successfully, otherwise not.
 @warning Only meeting host/co-host can run the function.
 */
- (BOOL)allowAttenddeTalk:(NSUInteger)userID allow:(BOOL)enable;

/*!
 @brief Query if Panelist can start video in Webinar Meeting.
 @return YES means able, otherwise not.
 */
- (BOOL)isAllowPanelistStartVideo;


#pragma mark Q&A relate Action in Webinar Meeting
/*!
 @brief Allow Panelist to start video in Webinar.
 @param enable Enable/Disable Panelist to start video.
 @return YES means that the method is called successfully, otherwise not.
 @warning Only meeting host/co-host can run the function.
 */
- (BOOL)allowPanelistStartVideo:(BOOL)enable;

/*!
 @brief Query if it is allowed to ask question anonymously in webinar.
 @return YES means allowed, otherwise not.
 */
- (BOOL)isAllowAskQuestionAnonymously;

/*!
 @brief Set if it is enabled to ask questions anonymously.
 @param Enable Enable/Disable to ask questions anonymously.
 @return YES means that the method is called successfully, otherwise not.
 @warning Only meeting host/co-host can run this function.
 */
- (BOOL)allowAskQuestionAnonymously:(BOOL)enable;

/*!
 @brief Query if attendee is allowed to view all question.
 @return YES means allowed, otherwise not.
 */
- (BOOL)isAllowAttendeeViewAllQuestion;

/*!
 @brief Allow attendee to view all question.
 @param Enable Enable/Disable attendee to view all questions.
 @return YES means that the method is called successfully, otherwise not.
 @warning Only meeting host/co-host can run this function.
 */
- (BOOL)allowAttendeeViewAllQuestion:(BOOL)enable;

/*!
 @brief Query if attendee is allowed to submit questions. 
 @return YES means allowed, otherwise not.
 */
- (BOOL)isAllowAttendeeUpVoteQuestion;

/*!
 @brief Allow attendee to submit questions.
 @param Enable Allow/Disallow attendee to submit question.
 @return YES means that the method is called successfully, otherwise not.
 @warning Only meeting host/co-host can run the function.
 */
- (BOOL)allowAttendeeUpVoteQuestion:(BOOL)enable;

/*!
 @brief Query if attendee is allowed to answer questions.
 @return YES means allowed, otherwise not.
 */
- (BOOL)isAllowAttendeeAnswerQuestion;

/*!
 @brief Allow attendee to answer question.
 @param Enable Allow/Disallow attendee to answer question.
 @return YES means that the method is called successfully, otherwise not.
 @warning Only meeting host/co-host can run the function.
 */
- (BOOL)allowAttendeeAnswerQuestion:(BOOL)enable;
@end
