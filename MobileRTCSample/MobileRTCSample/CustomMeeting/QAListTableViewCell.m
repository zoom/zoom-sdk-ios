//
//  QAListTableViewCell.m
//  MobileRTCSample
//
//  Created by Zoom Video Communications on 2019/10/28.
//  Copyright © 2019 Zoom Video Communications, Inc. All rights reserved.
//

#import "QAListTableViewCell.h"

@implementation QAListTableViewCell

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
        
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-30, 230)];
        _contentLabel.textAlignment = 0;
        _contentLabel.text = @"";
        _contentLabel.font = [UIFont systemFontOfSize:12.0];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = RGBCOLOR(0x23, 0x23, 0x33);
        [self.contentView addSubview:_contentLabel];
        
    }
    return self;
}

@end
