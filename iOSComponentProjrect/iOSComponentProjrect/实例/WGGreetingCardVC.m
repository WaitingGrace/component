//
//  WGGreetingCardVC.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/31.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGGreetingCardVC.h"
#import "Config.h"
#import "WGBirthdayMgr.h"
#import "WGBirthdayEnvelopeMgr.h"
#import "WGBirthdayModel.h"
#import "WGAudioPlayerMgr.h"

@interface WGGreetingCardVC ()

@property (nonatomic ,strong) NavigationView * navView;
@end

@implementation WGGreetingCardVC

#pragma mark --- 懒加载
- (NavigationView *)navView{
    if (_navView == nil) {
        NavigationView * navView = [NavigationView createdNavigationView];
        navView.backgroundColor = [UIColor whiteColor];
        NSDictionary * titileInfo = @{@"title":@"贺卡",@"font":iPad?@"22":(iPhone4_5?@"18":@"19")};
        [navView setInitNavigationviewWith:titileInfo backItem:@{} contentitem:nil isHidden:YES];
        _navView = navView;
        @WeakObj(self)
        _navView.backItemClick = ^{
            [selfWeak.navigationController popViewControllerAnimated:YES];
        };
    }
    return _navView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.navView];
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(NavHeight);
    }];
    
    UIImageView * bgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_normal.jpg"] highlightedImage:[UIImage imageNamed:@"bg_iPhoneX.jpg"]];
    bgView.highlighted = iPhoneXAll?YES:NO;
    [self.view addSubview:bgView];
    bgView.frame = CGRectMake(0, NavHeight, ScreenWidth, ScreenHeight);
    
    switch (self.birthdayType) {
        case 0:
        {
            [self showHeartBirthdayViewController];
        }
            break;
        case 1:
        {
            [self showEnvelopeBirthdayOneViewController];
        }
            break;
        default:
        {
            [self showEnvelopeBirthdayTwoViewController];
        }
            break;
    }
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [[WGAudioPlayerMgr sharedInstance] stopMusic:ykBirthdayMusicName];
}

// 心形生日快乐
- (void)showHeartBirthdayViewController {
    WGBirthdayItem *birthdayItem = [[WGBirthdayItem alloc] init];
    birthdayItem.birthdayTitle = @"亲爱的戎马天涯";
    birthdayItem.birthdaySubTitle = @"新益华精心为您准备了3000元医疗金";
    birthdayItem.birthdayDescriptionTitle = @"生日礼金，和一份特别惊喜！";
    [[WGBirthdayMgr shareInstance] showBirthdayViewInViewController:self birthdayItem:birthdayItem receiveBlock:^{
        NSLog(@"动画完成后做一些处理");
    }];
}

// 信封生日祝福
- (void)showEnvelopeBirthdayOneViewController {
    WGBirthdayModel *model = [[WGBirthdayModel alloc] init];
    model.birthdayLayerName = @"亲爱的天涯归人";
    model.birthdayLayerDesc = @"新益华精心为您准备了3000元生日礼金，赶快来领取吧";
    model.birthdayLayerType = WGBirthdayLayerTypeForA;
    [[WGBirthdayEnvelopeMgr shareInstance] showBirthdayViewController:self birthdayModel:model];
}

// 信封送好友生日祝福
- (void)showEnvelopeBirthdayTwoViewController {
    WGBirthdayModel *model = [[WGBirthdayModel alloc] init];
    model.birthdayLayerName = @"亲爱的戎马四季";
    model.birthdayLayerDesc = @"您的好友高圆圆小姐过生日啦，快去送祝福吧";
    model.birthdayLayerType = WGBirthdayLayerTypeForB;
    for (NSInteger i = 0; i < 1; ++i) {
        WGBirthdayFriendsItem *item = [WGBirthdayFriendsItem new];
        item.title = @"高小姐";
        item.isMore = i > 2;
        [model.friendsBirthdayInfo addObject:item];
    }
    [[WGBirthdayEnvelopeMgr shareInstance] showBirthdayViewController:self birthdayModel:model];
}

- (void)dealloc {
    NSLog(@"%@",[self class]);
}


@end
