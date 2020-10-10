//
//  SDKStartJoinMeetingPresenter+BOServiceDelegate.m
//  MobileRTCSample
//
//  Created by Zoom Video Communications on 2020/6/10.
//  Copyright © 2020 Zoom Video Communications, Inc. All rights reserved.
//

#import "SDKStartJoinMeetingPresenter+BOServiceDelegate.h"
#import "BOMeetingViewController.h"


@implementation SDKStartJoinMeetingPresenter (BOServiceDelegate)

- (void)onHasCreatorRightsNotification:(MobileRTCBOCreator *_Nonnull)creator
{
    NSLog(@"---BO--- Own Creator");
    [[NSNotificationCenter defaultCenter] postNotificationName:kBO_NOTIFICATION_DATA_UPDATE object:nil];
}

- (void)onHasAdminRightsNotification:(MobileRTCBOAdmin * _Nonnull)admin
{
    NSLog(@"---BO--- Own Admin");
    [[NSNotificationCenter defaultCenter] postNotificationName:kBO_NOTIFICATION_DATA_UPDATE object:nil];
}

- (void)onHasAssistantRightsNotification:(MobileRTCBOAssistant * _Nonnull)assistant
{
    NSLog(@"---BO--- Own Assistant");
    [[NSNotificationCenter defaultCenter] postNotificationName:kBO_NOTIFICATION_DATA_UPDATE object:nil];
}

- (void)onHasAttendeeRightsNotification:(MobileRTCBOAttendee * _Nonnull)attendee
{
    NSLog(@"---BO--- Own Attendee");
    [[NSNotificationCenter defaultCenter] postNotificationName:kBO_NOTIFICATION_DATA_UPDATE object:nil];
}

- (void)onHasDataHelperRightsNotification:(MobileRTCBOData * _Nonnull)dataHelper
{
    NSLog(@"---BO--- Own Data Helper");
    [[NSNotificationCenter defaultCenter] postNotificationName:kBO_NOTIFICATION_DATA_UPDATE object:nil];
}

- (void)onLostCreatorRightsNotification
{
    NSLog(@"---BO--- Lost Creator");
    [[NSNotificationCenter defaultCenter] postNotificationName:kBO_NOTIFICATION_DATA_UPDATE object:nil];
}

- (void)onLostAdminRightsNotification;
{
    NSLog(@"---BO--- Lost Admin");
    [[NSNotificationCenter defaultCenter] postNotificationName:kBO_NOTIFICATION_DATA_UPDATE object:nil];
}

- (void)onLostAssistantRightsNotification:(BOOL)isStopBO;
{
    NSLog(@"---BO--- Lost Assistant | stopBO:%@", @(isStopBO));
    if (isStopBO) {
        MobileRTCBOAssistant *assistant = [[[MobileRTC sharedRTC] getMeetingService] getAssistantHelper];
        if (assistant) [assistant leaveBO];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kBO_NOTIFICATION_DATA_UPDATE object:nil];
}

- (void)onLostAttendeeRightsNotification:(BOOL)isStopBO;
{
    NSLog(@"---BO--- Lost Attendee | stopBO:%@", @(isStopBO));
    if (isStopBO) {
        MobileRTCBOAttendee *attendee = [[[MobileRTC sharedRTC] getMeetingService] getAttedeeHelper];
        if (attendee) [attendee leaveBO];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kBO_NOTIFICATION_DATA_UPDATE object:nil];
}

- (void)onNewBroadcastMessageReceived:(NSString *_Nullable)broadcastMsg {
    NSLog(@"---BO--- Broadcast Message Received:%@", broadcastMsg);
    [[NSNotificationCenter defaultCenter] postNotificationName:kBO_NOTIFICATION_BRODCASET_RECEIVED object:broadcastMsg];
    
}

- (void)onLostDataHelperRightsNotification;
{
    NSLog(@"---BO--- Lost DataHelper");
    [[NSNotificationCenter defaultCenter] postNotificationName:kBO_NOTIFICATION_DATA_UPDATE object:nil];
}

- (void)onHelpRequestReceived:(NSString *_Nullable)strUserID {
    NSLog(@"---BO--- help request received from %@", strUserID);
    
    NSArray *boUIdList = [[NSUserDefaults standardUserDefaults] objectForKey:kBO_HELP_REQUESTER_IDS];
    if (![boUIdList isKindOfClass:NSArray.class]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kBO_HELP_REQUESTER_IDS];
        boUIdList = @[];
    }
    NSMutableArray *boUserList2Write = [NSMutableArray arrayWithArray:boUIdList];
    [boUserList2Write addObject:strUserID];
    [[NSUserDefaults standardUserDefaults] setObject:boUserList2Write forKey:kBO_HELP_REQUESTER_IDS];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kBO_NOTIFICATION_HELP_RECEIVED object:strUserID];
}

- (void)onHelpRequestHandleResultReceived:(MobileRTCBOHelpReply)eResult {
    NSString *replyStatus = @"";
    switch (eResult) {
        case MobileRTCBOHelpReply_Idle: {
            replyStatus = @"Idle";
        } break;
        case MobileRTCBOHelpReply_Busy: {
            replyStatus = @"Busy";
        } break;
        case MobileRTCBOHelpReply_Ignore: {
            replyStatus = @"Ignore";
        } break;
        case MobileRTCBOHelpReply_alreadyInBO: {
            replyStatus = @"alreadyInBO";
        } break;
        default: break;
    }
    NSLog(@"---BO--- help request replied: %@", replyStatus);
}

- (void)onHostJoinedThisBOMeeting {
    NSLog(@"---BO--- Host has joined this BO");
}

- (void)onHostLeaveThisBOMeeting {
    NSLog(@"---BO--- Host has left this BO");
}

@end
