//
//  WGTagButtonVC.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/3/27.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGTagButtonVC.h"
#import "Config.h"
#import "WGSearchController.h"
@interface WGTagButtonVC ()<UISearchBarDelegate>
@property (nonatomic ,strong) WGSearchController *searchController;
@property (nonatomic ,strong) WGTagView * tagView;

@end

@implementation WGTagButtonVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = BaiSe;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackColor;
    
    [self setInitTagView];
    
    UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_search"]];
    leftView.bounds = CGRectMake(0, 0, 13, 13);
    self.searchController = [[WGSearchController alloc] initWithSearchResultsController:self
                                                                          searchBarFrame:CGRectMake(0, 0, ScreenWidth, 44)
                                                                             placeholder:@"请输入搜索内容进行搜索"
                                                                                    text:@""
                                                                       textFieldLeftView:leftView
                                                                        showCancelButton:YES
                                                                            barTintColor:BASEColor];
    [self.searchController.navSearchBar becomeFirstResponder];
    self.searchController.navSearchBar.delegate = self;
    [self.searchController.navSearchBar setLeftPlaceholder];
    self.navigationItem.titleView = self.searchController.navSearchBar;
    self.navigationItem.hidesBackButton = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}
#pragma mark ----
#pragma mark ---- UISearchBarDelegate
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.hidesBottomBarWhenPushed = NO;
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.searchController.navSearchBar resignFirstResponder];
    // 让取消按钮一直处于激活状态
    UIButton *cancelBtn = [searchBar valueForKey:@"cancelButton"];
    self.hidesBottomBarWhenPushed = NO;
    [self.navigationController popViewControllerAnimated:NO];
    cancelBtn.enabled = YES;
  
}


/**
 设置标签视图
 */
- (void)setInitTagView{
    NSArray * array = @[@"巧克力",@"鲜花",@"披萨",@"牛排",@"沙拉",@"曲奇",@"草莓",@"哈根达斯",@"马卡龙",@"牛奶布丁",@"卡布奇诺"];
    self.tagView = [[WGTagView alloc]init];
    self.tagView.backgroundColor = [UIColor whiteColor];
    self.tagView.padding = UIEdgeInsetsMake(8, 8, 8, 8);
    self.tagView.lineSpacing = 10;
    self.tagView.interitemSpacing = 15;
    self.tagView.preferredMaxLayoutWidth = ScreenWidth - 40;
    self.tagView.didTapTagAtIndex = ^(NSUInteger index) {
        NSLog(@"%ld",index);
    };
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        WGTag * tag = [[WGTag alloc]initWithText:array[idx]];
        tag.padding = UIEdgeInsetsMake(2, 10, 2, 10);
        tag.font = FONT(iPhone4_5?12:13);
        tag.borderWidth = 1;
        tag.cornerRadius = 10.f;
        tag.bgColor = UIColorFromRGB(0xE7F0FF);
        tag.textColor = UIColorFromRGB(0x4D8DFC);
        tag.borderColor = UIColorFromRGB(0xE7F0FF);
        [self.tagView addTag:tag];
    }];
    CGFloat tagViewH = self.tagView.intrinsicContentSize.height;
    
    [self.view addSubview:self.tagView];
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(NavHeight);
        make.height.mas_equalTo(tagViewH );
    }];
}

@end
