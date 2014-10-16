//
//  ViewController.h
//  lunchSearch
//
//  Created by Takuma Sugimoto on 2014/08/16.
//  Copyright (c) 2014年 dota.kobayashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "GNaviApi.h"

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface ViewController : UIViewController <CLLocationManagerDelegate,NSURLSessionDataDelegate>

// ロケーションマネージャ
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) GNaviApi *gNavi;


- (IBAction)btnSearch:(id)sender;
@end
