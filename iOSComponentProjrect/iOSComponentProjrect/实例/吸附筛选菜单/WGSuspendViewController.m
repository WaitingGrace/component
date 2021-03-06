//
//  WGSuspendViewController.m
//
//
//  Created by 帅棋 on 17/10/26.
//  Copyright © 2017年 WaitingGrace. All rights reserved.
//

#import "WGSuspendViewController.h"
#import "WGDropMenu.h"
#import "WGSuspendHeader.h"
#import "WGSuspendItem.h"
#import "WGCollectionReusableView.h"
#import "WGDropMenuModel.h"
#import "NSArray+Bounds.h"

#define kHeaderHeight 400

@interface WGSuspendViewController ()<WGDropMenuDelegate,UITableViewDataSource,UITableViewDelegate,WGDropMenuDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic , strong) WGDropMenu *dropMenu;
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) NSArray *dataArray;
@property (nonatomic , strong) WGSuspendHeader *header;
@property (nonatomic , strong) UICollectionView *collectionView ;
@property (nonatomic , strong) UICollectionViewFlowLayout *flowLayout ;
@property (nonatomic , strong) UIButton *button;
@end

@implementation WGSuspendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.header;
    
    UIButton *button = [[UIButton alloc]init];
    [button addTarget:self action:@selector(change:)
     forControlEvents:UIControlEventTouchUpInside] ;
    [button setTitle:@"模拟本地数据" forState:UIControlStateNormal];
    [button setTitle:@"模拟网络数据" forState:UIControlStateSelected];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.button = button;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];

}
- (void)change: (UIButton *)button {
    button.selected = !button.selected;
    UITableViewHeaderFooterView *view = (UITableViewHeaderFooterView *)[self.tableView headerViewForSection:0];
    
    WGDropMenu *dropMenu = view.subviews.lastObject;
    [dropMenu resetMenuStatus];
}
- (void)refresh {
    [self.tableView reloadData];
}

- (void)dropMenu:(WGDropMenu *)dropMenu
   dropMenuModel:(WGDropMenuModel *)dropMenuModel
           index:(NSInteger)index {
    if (self.button.selected && index == 3) {
        NSMutableArray *temp = [NSMutableArray array];
        WGDropMenuModel *changeModel = [dropMenu.titles by_ObjectAtIndex:3];
        [temp addObject:[dropMenu.titles by_ObjectAtIndex:0]];
        [temp addObject:[dropMenu.titles by_ObjectAtIndex:1]];
        [temp addObject:[dropMenu.titles by_ObjectAtIndex:2]];

        WGDropMenuModel *changeNewModel = [[dropMenuModel creatRandomDropMenuData] by_ObjectAtIndex:3];
        changeNewModel.title = changeModel.title;
        [temp addObject:changeNewModel];
        dropMenu.recordSeleted = YES;
        dropMenuModel.titles = temp.copy;
        dropMenu.configuration = dropMenuModel;
    } else {

    }
}
- (void)back {
    [super back];
    /** 返回时候 需要将菜单收起 */
    UITableViewHeaderFooterView *view = (UITableViewHeaderFooterView *)[self.tableView headerViewForSection:0];
    WGDropMenu *dropMenu = view.subviews.lastObject;
    [dropMenu closeMenu];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGRect rectInTableView = [self.tableView rectForHeaderInSection:0];
    
    CGRect rect = [self.tableView convertRect:rectInTableView toView:[self.tableView superview]];
  
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    UITableViewHeaderFooterView *view = (UITableViewHeaderFooterView *)[self.tableView headerViewForSection:0];
 
    WGDropMenu *dropMenu = view.subviews.lastObject;
    
    dropMenu.tableY = rect.origin.y + rect.size.height;
    if (contentOffsetY >= kHeaderHeight) {
        dropMenu.tableY = SafeAreaTopHeight + 44;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(ScreenWidth, 44);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
  
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        WGCollectionReusableView *header  = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"WGCollectionReusableViewID" forIndexPath:indexPath];
        return header;
    } else {
        return [UICollectionReusableView new];
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WGSuspendItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GHSuspendItemID" forIndexPath:indexPath];
    cell.title.text = [NSString stringWithFormat:@"我是collectionView:%@",self.dataArray[indexPath.row]];

    cell.backgroundColor = indexPath.row % 2 == 0 ? [UIColor redColor]:[UIColor purpleColor];

    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击collectionView");
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
   
    WGDropMenuModel *configuration = [[WGDropMenuModel alloc]init];
    configuration.recordSeleted = YES;
    /** 设置数据源 */
    configuration.titles = [configuration creatNormalDropMenuData];
    /** 创建dropMenu 配置模型 && frame */
    WGDropMenu *dropMenu = [WGDropMenu creatDropMenuWithConfiguration:configuration frame:CGRectMake(0, 0,ScreenWidth, 44) dropMenuTitleBlock:^(WGDropMenuModel * _Nonnull dropMenuModel) {
    } dropMenuTagArrayBlock:^(NSArray * _Nonnull tagArray) {

    }];
    dropMenu.titleSeletedColor = [UIColor redColor];
    dropMenu.titleNormalColor = [UIColor orangeColor];
    dropMenu.titleSeletedImageName = @"up_normal";
    dropMenu.titleNormalImageName = @"down_normal";
    dropMenu.titleFont = [UIFont systemFontOfSize:11];
    dropMenu.optionFont = [UIFont systemFontOfSize:20];
    dropMenu.optionSeletedColor = [UIColor redColor];
    dropMenu.optionNormalColor = [UIColor blueColor];
    CGRect rectInTableView = [self.tableView rectForHeaderInSection:0];
    CGRect rect = [self.tableView convertRect:rectInTableView toView:[self.tableView superview]];
    dropMenu.tableY = rect.origin.y + rect.size.height;

    dropMenu.delegate = self;
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterViewID"];
    view.frame = CGRectMake(0, 0, ScreenWidth, 44);
    view.tintColor = [UIColor clearColor];
    view.contentView.backgroundColor = [UIColor clearColor];
  
    view.backgroundView = ({
        UIView * ssss = [[UIView alloc] initWithFrame:view.bounds];
        ssss.backgroundColor = [UIColor whiteColor];
        ssss;
    });
      
    [view addSubview: dropMenu];
    return view ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
    cell.textLabel.text = [NSString stringWithFormat:@"我是tableView:%@",self.dataArray[indexPath.row]];
    cell.backgroundColor = indexPath.row % 2 == 0 ? [UIColor yellowColor]:[UIColor brownColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击tableView");
}
#pragma mark - 代理方法

- (void)dropMenu:(WGDropMenu *)dropMenu dropMenuModel:(WGDropMenuModel *)dropMenuModel {
    
}
- (void)dropMenu:(WGDropMenu *)dropMenu dropMenuTitleModel:(WGDropMenuModel *)dropMenuTitleModel {
    self.navigationItem.title = [NSString stringWithFormat:@"%@第%ld列%ld行",dropMenuTitleModel.title,(long)dropMenuTitleModel.indexPath.section,(long)dropMenuTitleModel.indexPath.row];
}
- (void)dropMenu:(WGDropMenu *)dropMenu tagArray:(NSArray *)tagArray {
    [self getStrWith:tagArray];
}

- (void)getStrWith: (NSArray *)tagArray {
    NSMutableString *string = [NSMutableString string];
    if (tagArray.count) {
        for (WGDropMenuModel *dropMenuTagModel in tagArray) {
            if (dropMenuTagModel.tagSeleted) {
                if (dropMenuTagModel.tagName.length) {
                    [string appendFormat:@"%@",dropMenuTagModel.tagName];
                }
            }
            if (dropMenuTagModel.maxPrice.length) {
                [string appendFormat:@"最大价格%@",dropMenuTagModel.maxPrice];
            }
            if (dropMenuTagModel.minPrice.length) {
                [string appendFormat:@"最小价格%@",dropMenuTagModel.minPrice];
            }
        }
    }
    self.navigationItem.title = [NSString stringWithFormat:@"筛选结果: %@",string];
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _flowLayout.itemSize = CGSizeMake(ScreenWidth, 44);
        _flowLayout.minimumLineSpacing = 0.01f;
        _flowLayout.minimumInteritemSpacing = 0.01f;

    }
    return _flowLayout;
}
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0 + SafeAreaTopHeight, ScreenWidth, ScreenHeight - SafeAreaTopHeight) collectionViewLayout:self.flowLayout];
        _collectionView.contentInset = UIEdgeInsetsMake(kHeaderHeight, 0, 0, 0);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[WGSuspendItem class] forCellWithReuseIdentifier:@"GHSuspendItemID"];
    }
    return _collectionView;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0 + SafeAreaTopHeight, ScreenWidth, ScreenHeight - SafeAreaTopHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCellID"];
        [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"UITableViewHeaderFooterViewID"];
    }
    return _tableView;
}

- (NSArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSArray arrayWithObjects:@"学习iOS",@"一定要",@"眼高手低",@"纸上谈兵",@"不思进取",@"多学少练",@"开开心心",@"惠而不倦",@"2019",@"行尸走",
                      @"金蝉脱壳",
                      @"百里挑一",
                      @"金玉满堂",
                      @"背水一战",
                      @"霸王别姬",
                      @"天上人间",
                      @"不吐不快",
                      @"海阔天空",
                      @"情非得已",
                      @"满腹经纶",
                      @"兵临城下" ,nil];
    }
    return _dataArray;
}

- (WGSuspendHeader *)header {
    if (_header == nil) {
        _header = [[WGSuspendHeader alloc]init];
        _header.frame = CGRectMake(0, SafeAreaTopHeight, ScreenWidth, kHeaderHeight);
    }
    return _header;
}
- (void)dealloc {
}
@end
