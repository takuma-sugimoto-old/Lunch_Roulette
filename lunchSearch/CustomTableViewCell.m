//
//  CustomTableViewCell.m
//  lunchSearch
//
//  Created by Takuma Sugimoto on 2014/08/17.
//  Copyright (c) 2014年 dota.kobayashi. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    
    // Configure the view for the selected state
}

+ (CGFloat)rowHeight
{
    return 80.0f;
}

@end
