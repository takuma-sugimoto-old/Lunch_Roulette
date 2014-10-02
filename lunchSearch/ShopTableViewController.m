//
//  ShopTableViewController.m
//  lunchSearch
//
//  Created by Takuma Sugimoto on 2014/08/17.
//  Copyright (c) 2014年 dota.kobayashi. All rights reserved.
//

#import "ShopTableViewController.h"
#import "WebViewViewController.h"

@implementation ShopTableViewController

//アラート画面のタグを宣言
static const NSInteger firstAlertTag = 1;
static const NSInteger secondAlertTag = 2;
NSTimer *myTimer;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // デリゲートメソッドをこのクラスで実装する
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // セルのタップイベントを無効化
    self.tableView.allowsSelection = NO;
    
    // カスタマイズしたセルをテーブルビューにセット
    UINib *nib = [UINib nibWithNibName:@"TableViewCustomCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"Cell"];
    [self.searchDisplayController.searchResultsTableView registerNib:nib forCellReuseIdentifier:@"Cell"];
    
}

/*
 *  cellの背景色を透明にする
 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    //オリジナルのcellのframeとっておく
    CGRect originFrame = cell.frame;
    //アニメーション前の状態を設定
    cell.backgroundColor = [UIColor clearColor];
    
    cell.alpha = 0.1f;
    //cell.transform = CGAffineTransformMakeScale(0.8, 0.8);
    cell.frame = CGRectMake(originFrame.origin.x + 30, originFrame.origin.y, originFrame.size.width, originFrame.size.height);
    //cell.transform = CGAffineTransformMakeScale(0.8, 0.8);
    //0.5秒かけて、もとの状態へアニメーション
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.alpha = 1.0f;
                         //cell.transform = CGAffineTransformIdentity;
                         cell.frame = originFrame;
                     } completion:^(BOOL finished) {
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.alpha = 0.1f;
                         //cell.transform = CGAffineTransformMakeScale(0.8, 0.8);
                         cell.frame = CGRectMake(originFrame.origin.x + 30, originFrame.origin.y, originFrame.size.width, originFrame.size.height);
                     } completion:nil];
     }];
     */
    CATransform3D rotation,reverseRotation;
    rotation =  CATransform3DMakeRotation( -(M_PI)/2, 0.0, 0.4, 0.7);
    rotation.m34 = 1.0/ 1000;
    
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    cell.layer.transform = rotation;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    reverseRotation = CATransform3DMakeRotation((M_PI)/2, 0.0, 0.4, 0.7);
    reverseRotation.m34 = 1.0/1000;
    
    /*
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.5];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
     */
    [UIView animateWithDuration:0.5
                          delay:0
                          options:UIViewAnimationOptionAllowUserInteraction
                          animations:^{
                          cell.layer.transform = CATransform3DIdentity;
                          cell.alpha = 1;
                          cell.layer.shadowOffset = CGSizeMake(0, 0);
                          }
                     completion:^(BOOL finished){
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                        animations:^{
                            cell.layer.transform = reverseRotation;
                            cell.alpha = 0;
                            cell.layer.shadowOffset = CGSizeMake(10, 10);
                        }completion:nil];
                     }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    if (_rouletteStart)
    {
        myTimer =
        [NSTimer scheduledTimerWithTimeInterval:0.1f //タイマーを発生させる間隔
                                         target:self //タイマー発生時に呼び出すメソッドがあるターゲット
                                       selector:@selector(timerCall:) //タイマー発生時に呼び出すメソッド
                                       userInfo:nil //selectorに渡す情報(NSDictionary)
                                        repeats:YES //リピート
         ];
        
    }

}

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == firstAlertTag)
    {
        [self otherButtonPushed];
    }
    else if (alertView.tag == secondAlertTag)
    {
        // 特になにもなし
    }
}

- (void)otherButtonPushed
{
    _rouletteStart = false;
    [myTimer invalidate];
    
    // 余韻を持たす
    CGPoint point = CGPointMake(0, self.tableView.contentOffset.y - 300);
    [self.tableView setContentOffset:point animated:YES];
    
    
    // 止まる位置の店を取得 現在のスクロール位置をセルの高さで割って対象のセルを取得する
    NSInteger idx = self.tableView.contentOffset.y / 80;
    
    NSDictionary* shopItem = self.dataShopList[idx];
    NSString *shopURL = [NSString stringWithFormat:@"%@", [shopItem objectForKey:@"url"]];
    NSRange range = [shopURL rangeOfString:@"http"];
    if (range.location == NSNotFound)
        return;
    
    WebViewViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"webView"];
    vc.shopURL = shopURL;
    [self presentViewController:vc animated:YES completion:nil];

/*
    NSDictionary* shopItem = self.dataShopList[idx];
    NSString *name = [self getShopName:shopItem];

    UIAlertView *secondAlert = [[UIAlertView alloc] initWithTitle:@"AlertView"
                                                          message:name
                                                         delegate:self
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil, nil];
    secondAlert.tag = secondAlertTag;
    [secondAlert show];
*/
}

-(void)timerCall:(NSTimer*)timer
{
    CGPoint point = CGPointMake(0, self.tableView.contentOffset.y - 300);
    [self.tableView setContentOffset:point animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataShopList.count;
}

/**
 テーブルに表示するセクション（区切り）の件数を返します。（オプション）
 
 @return NSInteger : セクションの数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/**
 *  テーブルに表示するセルを返します。
 *
 *  @param tableView テーブルビュー
 *  @param indexPath セクション番号・行番号の組み合わせ
 *
 *  @return セル
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSDictionary* shopItem = self.dataShopList[indexPath.row];
    //NSLog(@"index:%d", indexPath.row);
    
    cell.shopName.text = [self getShopName:shopItem];
    cell.shopURL = [shopItem objectForKey:@"url"];

    // Set backgroundView
    UIImageView *imageView;
    UIImage *image;
    int num = indexPath.row % 10;
    NSMutableString *imgName = [NSMutableString stringWithString:@"list"];
    [imgName appendFormat:@"%d", num];
    image = [UIImage imageNamed:imgName];
    imageView = [[UIImageView alloc] initWithImage:image];
    cell.backgroundView = imageView;
    
    return cell;
}

- (NSString *)getShopName:(NSDictionary*)shopItem
{
    NSString *shopName = [shopItem objectForKey:@"name"];
    NSArray *tmp = [shopName componentsSeparatedByString:@" "];
    shopName = @"";
    NSInteger loopCnt = 0;
    for (NSString *str in tmp)
    {
        shopName = [NSString stringWithFormat:@"%@ %@",shopName,str];
        loopCnt++;
        if (loopCnt > 1)
            break;
    }
    
    //NSLog(@"%@", shopName);
    return shopName;
}
/*
- (UIImage *)getShopImg:(NSDictionary*)shopItem
{
    // NSString型だと認識させる
    NSString *shopImgUrl = [NSString stringWithFormat:@"%@", [[shopItem objectForKey:@"image_url"] objectForKey:@"shop_image1"]];
    // shopImgUrlにhttpが含まれている場合、画像が存在する
    NSRange range = [shopImgUrl rangeOfString:@"http"];
    if (range.location == NSNotFound)
        // NoImage画像を表示する
        return [UIImage imageNamed:@"ios1-100x100"];
    else
    {
        NSLog(@"%@", [shopItem objectForKey:@"url"] );
        // URLから画像を表示する TODO:高速化
        NSData *dt = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://apicache.gnavi.co.jp//image//rest//index.php?img=g064207v.jpg&sid=g064207"]];
        return [[UIImage alloc] initWithData:dt];
    }
}
*/
#pragma mark - UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CustomTableViewCell rowHeight];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // totalRowで÷
    NSDictionary* shopItem = self.dataShopList[indexPath.row % 10];
    NSString *shopURL = [NSString stringWithFormat:@"%@", [shopItem objectForKey:@"url"]];
    NSRange range = [shopURL rangeOfString:@"http"];
    if (range.location == NSNotFound)
        return;

    WebViewViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"webView"];
    vc.shopURL = shopURL;
    [self presentViewController:vc animated:YES completion:nil];
    
/*
    // UIWebViewのインスタンス化
    CGRect rect = self.view.frame;
    UIWebView *webView = [[UIWebView alloc]initWithFrame:rect];
    
    // Webページの大きさを自動的に画面にフィットさせる
    webView.scalesPageToFit = YES;
    
    // デリゲートを指定
    webView.delegate = self;
    
    // URLを指定
    NSURL *url = [NSURL URLWithString:shopURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // リクエストを投げる
    [webView loadRequest:request];
    
    // UIWebViewのインスタンスをビューに追加
    [self.view addSubview:webView];
*/
}

- (IBAction)goBackbtn:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
-(IBAction)tapStopBtn:(id)sender {
    [self otherButtonPushed];
}
@end