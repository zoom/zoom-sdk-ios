//
//  MobileRTCMeetingService+Interpretation.h
//  MobileRTC
//
//  Created by Zoom Video Communications on 2020/10/15.
//  Copyright © 2020 Zoom Video Communications, Inc. All rights reserved.
//


#import <MobileRTC/MobileRTC.h>

/*!
@brief The information of interpretation language.
*/
@interface MobileRTCInterpretationLanguage : NSObject
- (NSInteger)getLanguageID;
- (NSString * _Nullable)getLanguageAbbreviations;
- (NSString * _Nullable)getLanguageName;
@end

/*!
@brief The information of interpreter.
*/
@interface MobileRTCMeetingInterpreter : NSObject
- (NSInteger)getUserID;
- (NSInteger)getLanguageID1;
- (NSInteger)getLanguageID2;
- (BOOL)isAvailable;

@end

@interface MobileRTCMeetingService (Interpretation)

//Common (for all)

/*!
 @brief Determine if interpretation feature is enabled in the meeting.
*/
- (BOOL)isInterpretationEnabled;

/*!
 @brief Determine if interpretation has been started by host.
*/
- (BOOL)isInterpretationStarted;

/*!
 @brief Determine if myself is interpreter.
*/
- (BOOL)isInterpreter;

/*!
 @brief Get the interpretation language object of specified language ID.
 @param lanID Specify the language ID for which you want to get the information.
 @return If the function succeeds, the return value is a pointer to the MobileRTCInterpretationLanguage, Otherwise failed, the return value is nil.
*/
- (MobileRTCInterpretationLanguage * _Nullable)getInterpretationLanguageByID:(NSInteger)lanID;

//Admin (only for host)

/*!
 @brief Get the all interpretation language list.
 @return If the function succeeds, the return value is a pointer to the NSArray <MobileRTCInterpretationLanguage *>, Otherwise failed, the return value is nil.
*/
- (NSArray <MobileRTCInterpretationLanguage *> * _Nullable)getAllLanguageList;

/*!
 @brief Get the interpreters list.
 @return If the function succeeds, the return value is a pointer to the NSArray <MobileRTCMeetingInterpreter *>, Otherwise failed, the return value is nil.
*/
- (NSArray <MobileRTCMeetingInterpreter *> * _Nullable)getInterpreterList;

/*!
 @brief Add someone as a interpreter.
 @param userID Specify the user.
 @param lanID1 Specify the language1.
 @param lanID2 Specify the language2.
 @return The result of the function.
*/
- (BOOL)addInterpreter:(NSUInteger)userID lan1:(NSInteger)lanID1 andLan2:(NSInteger)lanID2;

/*!
 @brief Remove some interpreter.
 @param userID Specify the interpreter.
 @return The result of the function.
*/
- (BOOL)removeInterpreter:(NSUInteger)userID;

/*!
 @brief modify the language of some interpreter.
 @param userID Specify the interpreter.
 @param lanID1 Specify the new language1.
 @param lanID2 Specify the new language2.
 @return The result of the function.
*/
- (BOOL)modifyInterpreter:(NSUInteger)userID lan1:(NSInteger)lanID1 andLan2:(NSInteger)lanID2;

/*!
 @brief Start interpretation.
 @return The result of the function.
*/
- (BOOL)startInterpretation;

/*!
 @brief Stop interpretation.
 @return The result of the function.
*/
- (BOOL)stopInterpretation;

//Listener (for non interpreter)

/*!
 @brief Get the available interpretation language list.
 @return If the function succeeds, the return value is a pointer to the NSArray <MobileRTCInterpretationLanguage *>, Otherwise failed, the return value is nil.
*/
- (NSArray <MobileRTCInterpretationLanguage *> * _Nullable)getAvailableLanguageList;

/*!
 @brief Join some language channel.
 @param lanID Specify the language channel.
 @return The result of the function.
*/
- (BOOL)joinLanguageChannel:(NSInteger)lanID;

/*!
 @brief Get the language ID which myself is in.
 @return The LanguageID.
*/
- (NSInteger)getJoinedLanguageID;

/*!
 @brief Turn off the major audio, if you are in some interpreter language channel.
 @return The result of the function.
*/
- (BOOL)turnOffMajorAudio;

/*!
 @brief Turn on the major audio, if you are in some interpreter language channel.
 @return The result of the function.
*/
- (BOOL)turnOnMajorAudio;

/*!
 @brief Determine if the major audio is off.
 @return The result of the function.
*/
- (BOOL)isMajorAudioTurnOff;

//interpreter (only for interpreter)

/*!
 @brief Get languages if myself is a interpreter.
 @return If the function succeeds, the return value is a pointer to the NSArray NSArray <MobileRTCInterpretationLanguage *>, Otherwise failed, the return value is nil.
*/
- (NSArray <MobileRTCInterpretationLanguage *> * _Nullable)getInterpreterLans;

/*!
 @brief Set a language channel which myself will be in, if myself is a interpreter.
 @param activeLanID Specify the active language.
 @return The result of the function.
*/
- (BOOL)setInterpreterActiveLan:(NSInteger)activeLanID;

/*!
 @brief Get the active language ID, if myself is a interpreter.
 @return The Active LanguageID..
*/
- (NSInteger)getInterpreterActiveLan;

@end
