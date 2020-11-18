//
//  ManageLanInterpreTableViewCell.m
//  MobileRTCSample
//
//  Created by Zoom Video Communications on 2020/10/22.
//  Copyright © 2020 Zoom Video Communications, Inc. All rights reserved.
//

#import "ManageLanInterpreTableViewCell.h"

@implementation ManageLanInterpreTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _indexLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, (SCREEN_WIDTH-30-5)/2, 40)];
        _indexLabel.textAlignment = 0;
        _indexLabel.text = @"1111";
        _indexLabel.font = [UIFont systemFontOfSize:13.0];
        _indexLabel.textColor = RGBCOLOR(0x23, 0x23, 0x33);
        [self.contentView addSubview:_indexLabel];
        
        _deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_indexLabel.frame)+5, 5, (SCREEN_WIDTH-30-10)/2, 40)];
        _deleteButton.tag = kTagDeleteButton;
        [_deleteButton setTitle:@"delete" forState:UIControlStateNormal];
        [_deleteButton setTitleColor:RGBCOLOR(0x23, 0x23, 0x33) forState:0];
        _deleteButton.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
        _deleteButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_deleteButton addTarget: self action: @selector(onCellButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_deleteButton];
        
        _nameButton = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_indexLabel.frame)+5, SCREEN_WIDTH-30, 40)];
        _nameButton.tag = kTagNameButton;
        [_nameButton setTitle:@"" forState:UIControlStateNormal];
        [_nameButton setTitleColor:RGBCOLOR(0x23, 0x23, 0x33) forState:0];
        _nameButton.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
        _nameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_nameButton addTarget: self action: @selector(onCellButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_nameButton];
        
        _lan1Button = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_nameButton.frame)+5, (SCREEN_WIDTH-30-5)/2, 40)];
        _lan1Button.tag = kTagLan1Button;
        [_lan1Button setTitle:@"" forState:UIControlStateNormal];
        [_lan1Button setTitleColor:RGBCOLOR(0x23, 0x23, 0x33) forState:0];
        _lan1Button.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
        _lan1Button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_lan1Button addTarget: self action: @selector(onCellButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_lan1Button];
        
        _lan2Button = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_lan1Button.frame)+5, CGRectGetMaxY(_nameButton.frame)+5, (SCREEN_WIDTH-30-5)/2, 40)];
        _lan2Button.tag = kTagLan2Button;
        [_lan2Button setTitle:@"" forState:UIControlStateNormal];
        [_lan2Button setTitleColor:RGBCOLOR(0x23, 0x23, 0x33) forState:0];
        _lan2Button.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
        _lan2Button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_lan2Button addTarget: self action: @selector(onCellButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_lan2Button];
    }
    return self;
}

- (void)onCellButtonClicked:(UIButton *)sender
{
    if (_delegate) {
        [_delegate onCellButtonClicked:sender rowIndex:_rowIndex];
    }
}

@end
