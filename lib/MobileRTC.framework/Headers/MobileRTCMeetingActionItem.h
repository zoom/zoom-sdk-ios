//
//  MobileRTCMeetingActionItem.h
//  MobileRTC
//
//  Created by chaobai on 16/03/2018.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @class MobileRTCMeetingInviteActionItem
 @brief MobileRTCMeetingInviteActionItem is used to add customized invite action item in meeting.
 */
typedef void (^MobileRTCMeetingInviteActionItemBlock)(void);

@interface MobileRTCMeetingInviteActionItem : NSObject

@property (nonatomic, retain, readwrite) NSString * actionTitle;

@property (nonatomic, copy, readwrite) MobileRTCMeetingInviteActionItemBlock actionHandler;

+(id)itemWithTitle:(NSString *)inTitle Action:(MobileRTCMeetingInviteActionItemBlock)actionHandler;

@end

/*!
 @class MobileRTCMeetingShareActionItem
 @brief MobileRTCMeetingShareActionItem is used to add customized share action item in meeting.
 */
@protocol MobileRTCMeetingShareActionItemDelegate <NSObject>
@required
- (void)onShareItemClicked:(NSUInteger)tag completion:(BOOL(^)(UIViewController * shareView))completion;
@end

@interface MobileRTCMeetingShareActionItem : NSObject

@property (nonatomic, retain, readwrite) NSString * actionTitle;

@property (nonatomic, assign, readwrite) NSUInteger tag;

@property (nonatomic, assign, readwrite) id<MobileRTCMeetingShareActionItemDelegate> delegate;

+(id)itemWithTitle:(NSString *)inTitle Tag:(NSUInteger)tag;
@end
