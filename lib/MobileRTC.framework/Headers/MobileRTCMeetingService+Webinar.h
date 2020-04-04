//
//  MobileRTCMeetingService+Webinar.h
//  MobileRTC
//
//  Created by chaobai admin on 07/08/2018.
//  Copyright © 2019 Zoom Video Communications, Inc. All rights reserved.
//

#import <MobileRTC/MobileRTC.h>
#import "MobileRTCQAItem.h"

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
 @warning only webinar meeting can run the function.
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
 @brief Query if attendee is allowed to comment questions.
 @return YES means allowed, otherwise not.
 */
- (BOOL)isAllowAttendeeAnswerQuestion DEPRECATED_MSG_ATTRIBUTE("Had deprecated. Please use - (BOOL)isAllowCommentQuestion; instead");

/*!
 @brief Allow attendee to comment question.
 @param Enable Allow/Disallow attendee to comment question.
 @return YES means that the method is called successfully, otherwise not.
 @warning Only meeting host/co-host can run the function.
 */
- (BOOL)allowAttendeeAnswerQuestion:(BOOL)enable DEPRECATED_MSG_ATTRIBUTE("Had deprecated. Please use - (BOOL)allowCommentQuestion:(BOOL)enable; instead");

/*!
 @brief Query if attendee is allowed to comment questions.
 @return YES means allowed, otherwise not.
 */
- (BOOL)isAllowCommentQuestion;

/*!
 @brief Allow attendee to comment question.
 @param Enable Allow/Disallow attendee to comment question.
 @return YES means that the method is called successfully, otherwise not.
 @warning Only meeting host/co-host can run the function.
 */
- (BOOL)allowCommentQuestion:(BOOL)enable;

/*!
 @brief Get all questions.
 @return All questions list.
 */
- (nullable NSArray *)getAllQuestionList;

/*!
 @brief Get My questions.
 @return My questions list.
 @warning Only attendee can run the function.
 */
- (nullable NSArray *)getMyQuestionList;

/*!
 @brief Get Open questions.
 @return Open questions list.
 @warning Only meeting host/co-host/panelist can run the function.
 */
- (nullable NSArray *)getOpenQuestionList;

/*!
 @brief Get Dismissed questions.
 @return Dismissed questions list.
 @warning Only meeting host/co-host/panelist can run the function.
 */
- (nullable NSArray *)getDismissedQuestionList;

/*!
 @brief Get Answered questions.
 @return Answered questions list.
 @warning Only meeting host/co-host/panelist can run the function.
 */
- (nullable NSArray *)getAnsweredQuestionList;

/*!
 @brief Get the amount of all questions.
 @return Amount of all questions.
 */
- (int)getALLQuestionCount;

/*!
 @brief Get the amount of my questions.
 @return Amount of open-ended questions.
 */
- (int)getMyQuestionCount;

/*!
 @brief Get the amount of Open questions.
 @return Amount of open-ended questions.
 */
- (int)getOpenQuestionCount;

/*!
 @brief Get the amount of dissmissed questions.
 @return Amount of open-ended questions.
 */
- (int)getDismissedQuestionCount;

/*!
 @brief Get the amount of answered questions.
 @return Amount of open-ended questions.
 */
- (int)getAnsweredQuestionCount;

/*!
 @brief get question item by questionID.
 @param questionID question id.
 @return the question item.
 */
- (nullable MobileRTCQAItem *)getQuestion:(nonnull NSString *)questionID;

/*!
 @brief get answer item by questionID.
 @param answerID answer id.
 @return the answer item.
 */
- (nullable MobileRTCQAAnswerItem *)getAnswer:(nonnull NSString *)answerID;

/*!
 @brief Add Quesion.
 @param content question content.
 @param anonymous if true anonymously.
 @return successs or not.
 @warning Only attendee can run the function.
 */
- (BOOL)addQuestion:(nonnull NSString *)content anonymous:(BOOL)anonymous;

/*!
 @brief Answer quesion in private.
 @param questionID question id.
 @param content question content.
 @param destUserID destination userId.
 @return successs or not.
 @warning Only meeting host/co-host/panelist can run the function.
 */
- (BOOL)answerQuestionPrivate:(nonnull NSString *)questionID answerContent:(nonnull NSString *)answerContent;

/*!
 @brief Answer Quesion.
 @param questionID question id.
 @param content question content.
 @return successs or not.
 @warning Only meeting host/co-host/panelist can run the function.
 */
- (BOOL)answerQuestionPublic:(nonnull NSString *)questionID answerContent:(nonnull NSString *)answerContent;

/*!
 @brief Attendee comment Quesion.
 @param questionID question id.
 @param commentContent comment content.
 @return successs or not.
 @warning Only meeting attendee can run the function.
 */
- (BOOL)commentQuestion:(nonnull NSString *)questionID commentContent:(nonnull NSString *)commentContent;

/*!
 @brief Dismiss Quesion.
 @param questionID question id.
 @return successs or not.
 @warning Only meeting host/co-host/panelist can run the function.
 */
- (BOOL)dismissQuestion:(nonnull NSString *)questionID;

/*!
 @brief Reopen Quesion.
 @param questionID question id.
 @return successs or not.
 @warning Only meeting host/co-host/panelist can run the function.
 */
- (BOOL)reopenQuestion:(nonnull NSString *)questionID;

/*!
 @brief Vote up Quesion.
 @param questionID question id.
 @return successs or not.
 @warning Only meeting host/co-host/panelist can run the function.
 */
- (BOOL)voteupQuestion:(nonnull NSString *)questionID voteup:(BOOL)voteup;

/*!
 @brief startLiving Quesion.
 @param questionID question id.
 @return successs or not.
 @warning Only meeting host/co-host/panelist can run the function.
 */
- (BOOL)startLiving:(nonnull NSString *)questionID;

/*!
 @brief endLiving Quesion.
 @param questionID question id.
 @return successs or not.
 @warning Only meeting host/co-host/panelist can run the function.
 */
- (BOOL)endLiving:(nonnull NSString *)questionID;

@end
