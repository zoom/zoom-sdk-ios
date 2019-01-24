//
//  SDKStartJoinMeetingPresenter+JoinMeetingOnly.h
//  MobileRTCSample
//
//  Created by Murray Li on 2018/11/20.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import "SDKStartJoinMeetingPresenter.h"

@interface SDKStartJoinMeetingPresenter (JoinMeetingOnly)

- (void)joinMeeting:(NSString*)meetingNo withPassword:(NSString*)pwd;

@end

