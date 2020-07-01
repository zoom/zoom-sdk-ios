//
//  SDKStartJoinMeetingPresenter+BOServiceDelegate.m
//  MobileRTCSample
//
//  Created by Jackie Chen on 2020/6/10.
//  Copyright © 2020 Zoom Video Communications, Inc. All rights reserved.
//

#import "SDKStartJoinMeetingPresenter+BOServiceDelegate.h"
#import "BOMeetingViewController.h"


@implementation SDKStartJoinMeetingPresenter (BOServiceDelegate)

- (void)onHasCreatorRightsNotification:(MobileRTCBOCreator *_Nonnull)creator
{
    NSLog(@"---BO--- Own Creator");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BO_Update" object:nil];
}

- (void)onHasAdminRightsNotification:(MobileRTCBOAdmin * _Nonnull)admin
{
    NSLog(@"---BO--- Own Admin");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BO_Update" object:nil];
}

- (void)onHasAssistantRightsNotification:(MobileRTCBOAssistant * _Nonnull)assistant
{
    NSLog(@"---BO--- Own Assistant");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BO_Update" object:nil];
}

- (void)onHasAttendeeRightsNotification:(MobileRTCBOAttendee * _Nonnull)attendee
{
    NSLog(@"---BO--- Own Attendee");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BO_Update" object:nil];
}

- (void)onHasDataHelperRightsNotification:(MobileRTCBOData * _Nonnull)dataHelper
{
    NSLog(@"---BO--- Own Data Helper");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BO_Update" object:nil];
}

- (void)onLostCreatorRightsNotification
{
    NSLog(@"---BO--- Lost Creator");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BO_Update" object:nil];
}

- (void)onLostAdminRightsNotification;
{
    NSLog(@"---BO--- Lost Admin");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BO_Update" object:nil];
}

- (void)onLostAssistantRightsNotification;
{
    NSLog(@"---BO--- Lost Assistant");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BO_Update" object:nil];
}

- (void)onLostAttendeeRightsNotification;
{
    NSLog(@"---BO--- Lost Attendee");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BO_Update" object:nil];
}

- (void)onLostDataHelperRightsNotification;
{
    NSLog(@"---BO--- Lost DataHelper");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BO_Update" object:nil];
}

@end
