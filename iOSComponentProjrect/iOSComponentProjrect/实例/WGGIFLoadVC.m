//
//  WGGIFLoadVC.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/30.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGGIFLoadVC.h"
#import "WGCGImageGIFView.h"
#import "WGCAKeyframeAnimationGIFView.h"
#import "WGCADisplayLineImageView.h"

@interface WGGIFLoadVC ()
{
    WGCGImageGIFView *gifView;
    WGCAKeyframeAnimationGIFView *otherGifView;
    WGCADisplayLineImageView *displayImageView;
}
@end

@implementation WGGIFLoadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSInteger idx = arc4random()%4;
    
    switch (idx) {
        case 0:
        {
            [self loadCADisplayLineImageView];
        }
            break;
        case 1:
        {
            [self loadGIFWithCGImage];
        }
            break;
        case 2:
        {
            [self loadCAKeyframeAnimation];
        }
            break;
        default:
        {
            [self loadCADisplayLineImageView];
        }
            break;
    }
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}


-(void)loadGIFWithWebView
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 350*2, 393)];
    [webView setCenter:self.view.center];
    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"timg-3" ofType:@"gif"]];
    webView.userInteractionEnabled = NO;
    [webView loadData:gif MIMEType:@"image/gif" textEncodingName:@"UTF-8" baseURL:[[NSURL alloc]init]];
    //设置webview背景透明，能看到gif的透明层
    webView.backgroundColor = [UIColor blackColor];
    webView.opaque = NO;
    [self.view addSubview:webView];
    
}
-(void)loadGIFWithCGImage
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"timg" ofType:@"gif"];
    gifView = [[WGCGImageGIFView alloc] initWithGIFPath:path];
    gifView.frame = CGRectMake(0, 0, 200, 200);
    [gifView setCenter:self.view.center];
    [self.view addSubview:gifView];
    [gifView startGIF];
}
-(void)loadCAKeyframeAnimation
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"timg-2" ofType:@"gif"];
    otherGifView = [[WGCAKeyframeAnimationGIFView alloc] initWithCAKeyframeAnimationWithPath:path];
    otherGifView.frame = CGRectMake(0, 0, 200, 200);
    otherGifView.center = self.view.center;
    [self.view addSubview:otherGifView];
    [otherGifView startGIF];
}
-(void)loadCADisplayLineImageView
{
    displayImageView = [[WGCADisplayLineImageView alloc] initWithFrame:CGRectMake(0, 0, 300,100)];
    [displayImageView setCenter:self.view.center];
    [self.view addSubview:displayImageView];
    [displayImageView setImage:[WGCADisplayLineImage imageNamed:@"timg-3.gif"]];
    
}


@end
