//
//  ManageLanInterpreTableViewCell.h
//  MobileRTCSample
//
//  Created by Zoom Video Communications on 2020/10/22.
//  Copyright © 2020 Zoom Video Communications, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTagDeleteButton       20007
#define kTagNameButton         (kTagDeleteButton+1)
#define kTagLan1Button         (kTagDeleteButton+2)
#define kTagLan2Button         (kTagDeleteButton+3)

@protocol onCellButtonClickedDelegate <NSObject>
- (void)onCellButtonClicked:(UIButton *)sender rowIndex:(NSInteger)rowIndex;
@end

@interface ManageLanInterpreTableViewCell : UITableViewCell
@property (assign, nonatomic) id<onCellButtonClickedDelegate> _Nullable delegate;
@property (nonatomic, strong) UILabel *indexLabel;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) UIButton *nameButton;
@property (nonatomic, strong) UIButton *lan1Button;
@property (nonatomic, strong) UIButton *lan2Button;

@property (nonatomic, assign) NSInteger rowIndex;
@end

