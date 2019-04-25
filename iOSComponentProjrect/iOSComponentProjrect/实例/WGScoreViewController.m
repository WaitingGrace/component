//
//  WGScoreViewController.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/3/25.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGScoreViewController.h"
#import "Config.h"
@interface WGScoreViewController ()<StarRatingViewDelegate>
@property (nonatomic ,strong) SYStarRatingView * starView;
@property (nonatomic ,strong) SYStarRatingView * accordingViaew;


@end

@implementation WGScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackColor;
    self.starView = [[SYStarRatingView alloc]initWithFrame:CGRectMake(100, 200, 200, 50) numberOfStar:5];
    self.starView.delegate = self;
    [self.starView registerForKVO];
    [self.starView setScore:0.2 withAnimation:NO];
    [self.view addSubview:self.starView];
    
    
    self.accordingViaew = [[SYStarRatingView alloc]initWithFrame:CGRectMake(100, 300, 200, 50) numberOfStar:5];
    self.accordingViaew.isIndicator = YES;
    [self.accordingViaew setScore:0.1 withAnimation:NO];
    [self.view addSubview:self.accordingViaew];
}


-(void)starRatingView:(SYStarRatingView *)view score:(float)score{
    [self.accordingViaew setScore:score withAnimation:NO];
}
- (void)dealloc{
    [self.starView unregisterFromKVO];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
