//
//  SDKStartJoinMeetingPresenter+Interpretation.m
//  MobileRTCSample
//
//  Created by Zoom Video Communications on 2020/10/28.
//  Copyright © 2020 Zoom Video Communications, Inc. All rights reserved.
//

#import "SDKStartJoinMeetingPresenter+Interpretation.h"

@implementation SDKStartJoinMeetingPresenter (Interpretation)

- (void)onInterpretationStart
{
    NSLog(@"Interpretation-->: onInterpretationStart");
}

- (void)onInterpretationStop
{
    NSLog(@"Interpretation-->: onInterpretationStop");
}

- (void)onInterpreterListChanged
{
    NSLog(@"Interpretation-->: onInterpreterListChanged");
}

- (void)onInterpreterRoleChanged:(NSUInteger)userID isInterpreter:(BOOL)isInterpreter
{
    NSLog(@"Interpretation-->: onInterpreterRoleChanged userID=%@ isInterpreter=%@",@(userID), @(isInterpreter));
}

- (void)onInterpreterActiveLanguageChanged:(NSInteger)userID activeLanguageId:(NSInteger)activeLanID
{
    NSLog(@"Interpretation-->: onInterpreterActiveLanguageChanged userID=%@ activeLanguageId=%@",@(userID), @(activeLanID));
}

- (void)onInterpreterLanguageChanged:(NSInteger)lanID1 andLanguage2:(NSInteger)lanID2
{
    NSLog(@"Interpretation-->: onInterpreterLanguageChanged Language1=%@ Language=%@",@(lanID1),@(lanID2));
}

- (void)onAvailableLanguageListUpdated:(NSArray <MobileRTCInterpretationLanguage *> *_Nullable)availableLanguageList
{
    NSLog(@"Interpretation-->: onAvailableLanguageListUpdated availableLanguageList=%@",availableLanguageList);
}

@end
