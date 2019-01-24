//
//  SDKAuthPresenter+PremeetingDelegate.m
//  MobileRTCSample
//
//  Created by Murray Li on 2018/12/19.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import "SDKAuthPresenter+PremeetingDelegate.h"

@implementation SDKAuthPresenter (PremeetingDelegate)

#pragma mark - Premeeting Delegate

- (void)sinkSchedultMeeting:(PreMeetingError)result MeetingUniquedID:(unsigned long long)UniquedID
{
    NSLog(@"sinkSchedultMeeting result: %d, UniquedID:%llu", result, UniquedID);
    MobileRTCPremeetingService *service = [[MobileRTC sharedRTC] getPreMeetingService];
    if (service)
    {
        id<MobileRTCMeetingItem> info = [service getMeetingItemByUniquedID:UniquedID];
        NSLog(@"sinkSchedultMeeting %@",[info getMeetingTopic]);
    }
}

- (void)sinkEditMeeting:(PreMeetingError)result MeetingUniquedID:(unsigned long long)UniquedID
{
    NSLog(@"sinkEditMeeting result: %d, UniquedID:%llu ", result,UniquedID);
    
    MobileRTCPremeetingService *service = [[MobileRTC sharedRTC] getPreMeetingService];
    if (service)
    {
        id<MobileRTCMeetingItem> item = [service getMeetingItemByUniquedID:UniquedID];
        NSLog(@"sinkEditMeeting %@",[item getMeetingTopic]);
    }
}

- (void)sinkDeleteMeeting:(PreMeetingError)result
{
    NSLog(@"sinkDeleteMeeting result: %d", result);
}

- (void)sinkListMeeting:(PreMeetingError)result withMeetingItems:(NSArray*)array
{
    NSLog(@"sinkListMeeting result: %d  items: %@", result, array);
    
#if 0
    for (id<MobileRTCMeetingItem> item in array)
    {
        MobileRTCPremeetingService *service = [[MobileRTC sharedRTC] getPreMeetingService];
        if (service)
        {
            if ([[item getMeetingTopic] isEqualToString:@"test"] )
            {
                id<MobileRTCMeetingItem> cloneitem = [service cloneMeetingItem:item];
                [cloneitem setUsePMIAsMeetingID:YES];
                [service editMeeting:cloneitem];
                [service destroyMeetingItem:cloneitem];
            }
        }
    }
#endif
}


@end
