//
//  MobileRTCMeetingActionItem.h
//  MobileRTC
//
//  Created by chaobai on 16/03/2018.
//  Copyright © 2019 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @class MobileRTCMeetingInviteActionItem
 @brief Add custom invitation action items to the meeting.  
 */
typedef void (^MobileRTCMeetingInviteActionItemBlock)(void);

@interface MobileRTCMeetingInviteActionItem : NSObject
/*!
 @brief The title of the custom invitation items.
 */
@property (nonatomic, retain, readwrite) NSString * _Nonnull actionTitle;
/*!
 @brief Callback event of clicking the invitation item.
 */
@property (nonatomic, copy, readwrite) MobileRTCMeetingInviteActionItemBlock _Nonnull actionHandler;

+(id _Nonnull )itemWithTitle:(NSString * _Nonnull )inTitle Action:(MobileRTCMeetingInviteActionItemBlock _Nonnull )actionHandler;

@end

/*!
 @class MobileRTCMeetingShareActionItem
 @brief Add custom share action item to the meeting. 
 */
@protocol MobileRTCMeetingShareActionItemDelegate <NSObject>
@required
- (void)onShareItemClicked:(NSUInteger)tag completion:(BOOL(^_Nonnull)(UIViewController * _Nonnull shareView))completion;
@end

@interface MobileRTCMeetingShareActionItem : NSObject
/*!
 @brief The title of the custom content to share, like screen, application, photos, etc. 
 */ 
@property (nonatomic, retain, readwrite) NSString * _Nonnull actionTitle;

/*!
 @brief The tag of MobileRTCMeetingShareActionItem.
 */
@property (nonatomic, assign, readwrite) NSUInteger tag;
/*!
 @brief Enable the share via MobileRTCMeetingShareActionItemDelegate.
 */
@property (nonatomic, assign, readwrite) id<MobileRTCMeetingShareActionItemDelegate> _Nonnull delegate;

+(id _Nonnull )itemWithTitle:(NSString * _Nonnull)inTitle Tag:(NSUInteger)tag;
@end
