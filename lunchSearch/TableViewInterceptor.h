//
//  TableViewInterceptor.h
//  lunchSearch
//
//  Created by Takuma Sugimoto on 2014/08/16.
//  Copyright (c) 2014年 dota.kobayashi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableViewInterceptor : NSObject

@property (nonatomic, readwrite, weak) id receiver;
@property (nonatomic, readwrite, weak) id middleMan;

@end
