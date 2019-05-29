//
//  WGVideoPlayerVC.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/21.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGVideoPlayerVC.h"
#import "HcdCachePlayer.h"

@interface WGVideoPlayerVC ()
{
    
}
@property (nonatomic ,strong) HcdCacheVideoPlayer * play;
@end

@implementation WGVideoPlayerVC


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"123";
    self.view.backgroundColor = BackColor;
    _play = [HcdCacheVideoPlayer sharedInstance];
    UIView *videoView = [[UIView alloc]initWithFrame:CGRectMake(0, NavHeight, ScreenWidth, ScreenWidth * 0.5625)];
    [self.view addSubview:videoView];
    NSArray * videoUrls = @[ @"https://vdse.bdstatic.com//f11546e6b21bb6f60f025df3d5cb5735?authorization=bce-auth-v1/fb297a5cc0fb434c971b8fa103e8dd7b/2017-05-11T09:02:31Z/-1//560f50696b0d906271532cf3868d7a3baf6e4f7ffbe74e8dff982ed57f72c088.mp4", @"https://vdse.bdstatic.com//f11546e6b21bb6f60f025df3d5cb5735?authorization=bce-auth-v1/fb297a5cc0fb434c971b8fa103e8dd7b/2017-05-11T09:02:31Z/-1//560f50696b0d906271532cf3868d7a3baf6e4f7ffbe74e8dff982ed57f72c088.mp4",
                             @"http://www.crowncake.cn:18080/wav/no.9.mp4",
                             @"http://www.crowncake.cn:18080/wav/day_by_day.mp4",
                             @"http://www.crowncake.cn:18080/wav/Lovey_Dovey.mp4"];
    NSInteger idx = arc4random()%5;
    [_play playWithUrl:[NSURL URLWithString:videoUrls[idx]]
              showView:videoView
          andSuperView:self.view
             withCache:YES];

    
    NSLog(@"%f", [HcdCacheVideoPlayer allVideoCacheSize]);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_play stop];
}
/**
 *  取得本地文件路径
 *
 *  @return 文件路径
 */
- (NSURL *)getFileUrl{
    NSString *urlStr=[[NSBundle mainBundle] pathForResource:@"2.mp4" ofType:nil];
    NSURL *url=[NSURL fileURLWithPath:urlStr];
    return url;
}

@end
