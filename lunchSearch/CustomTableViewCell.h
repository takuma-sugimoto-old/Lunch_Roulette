//
//  CustomTableViewCell.h
//  lunchSearch
//
//  Created by Takuma Sugimoto on 2014/08/17.
//  Copyright (c) 2014年 dota.kobayashi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property NSString* shopURL;

+ (CGFloat)rowHeight;

@end
