//
//  BottomBarView.h
//
//  Created by Zoom Video Communications on 2019/5/29.
//  Copyright © 2019 Zoom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HorizontalTableView.h"

#define CALC_WIDTH ((SCREEN_WIDTH - 10.0) / 3.0)
#define kCellHeight (CALC_WIDTH > 135.0 ? 135.0 : CALC_WIDTH)

#define kTableHeight  (kCellHeight + 20.0)

@interface ViewItem : NSObject
@property (nonatomic, copy) NSString        *itemName;
@property (nonatomic, strong) UIView        *view;
@property (nonatomic, assign) NSUInteger    userId;
@property (nonatomic, assign) BOOL          isActive;
@property (nonatomic, strong) MobileRTCRenderer  *renderer;
@end

@interface LeftLabel : UILabel

@end

@protocol BottomBarViewDelegate <NSObject>

- (void)pinThumberViewItem:(ViewItem *)item;
- (void)stopThumbViewVideo;
- (void)startThumbViewVideo;

@end

@interface BottomBarView : UIView
@property (nonatomic, strong) NSMutableArray *viewArray;

@property (strong, nonatomic) HorizontalTableView       *thumbTableView;

- (instancetype)initWithDelegate:(id<BottomBarViewDelegate>)delegate;

- (void)addThumberViewItem:(ViewItem *)item;

- (void)updateItem:(ViewItem *)item withViewItem:(ViewItem *)newItem;

- (void)removeThumberViewItem:(ViewItem *)item;

- (void)removeThumberViewItemWithUserId:(NSUInteger)userId;

- (void)activeThumberViewItem:(NSUInteger)userId;

- (void)deactiveAllThumberView;

- (NSArray *)getThumberViewItems:(NSUInteger)userId;
@end

