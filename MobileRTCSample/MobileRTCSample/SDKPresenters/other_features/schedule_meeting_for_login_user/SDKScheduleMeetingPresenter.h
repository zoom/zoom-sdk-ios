//
//  SDKScheduleMeetingPresenter.h
//  MobileRTCSample
//
//  Created by Murray Li on 2018/11/27.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDKScheduleMeetingPresenter : NSObject

- (BOOL)scheduleMeeting:(nonnull id<MobileRTCMeetingItem>)meetingItem WithScheduleFor:(nullable NSString *)userEmail;

- (BOOL)deleteMeeting:(id<MobileRTCMeetingItem>)meetingItem;

@end

