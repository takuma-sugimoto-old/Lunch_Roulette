//
//  WebViewViewController.h
//  lunchSearch
//
//  Created by Takuma Sugimoto on 2014/09/15.
//  Copyright (c) 2014年 dota.kobayashi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewViewController : UIViewController <UIWebViewDelegate>
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
@property (nonatomic, strong) NSString *shopURL;

@end
