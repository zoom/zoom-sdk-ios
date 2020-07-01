//
//  SDKActionPresenter.h
//  MobileRTCSample
//
//  Created by Zoom Video Communications on 2018/11/21.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDKActionPresenter : NSObject

- (BOOL)isMeetingHost;

- (void)leaveMeeting;

- (void)EndMeeting;

- (void)presentParticipantsViewController;

- (BOOL)lockMeeting;

- (BOOL)lockShare;
@end


