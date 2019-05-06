//
//  WGSeePhotosVC.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/4/1.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGSeePhotosVC.h"
#import "Config.h"
#import "WGImageItem.h"
#import "WGHeaderView.h"
#import "WGDorpView.h"

@interface WGSeePhotosVC ()
@property (nonatomic ,strong) UIView * urlIamgeView;
@property (nonatomic ,strong) UIView * imageView;
@property (nonatomic ,strong) NSArray * urlArray;
@property (nonatomic ,strong) WGHeaderView * headerView;
@property (nonatomic ,strong) WGDorpView *dropView;
@property (nonatomic ,strong) NSString * beginDate;
@property (nonatomic ,strong) NSString * endDate;
@property (nonatomic ,strong) NSString * adviceType;
@property (nonatomic ,assign) CGPoint point;
@property (nonatomic ,strong) NSArray * typeArray;

@end

@implementation WGSeePhotosVC

- (void)setupUrlIamgeView:(NSInteger)num{
    [self.urlIamgeView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat itemW = (ScreenWidth - (10*3+32))/4;
    CGFloat itemH = itemW;
    for (int i = 0; i < num; i++) {
        WGImageItem * item = [[WGImageItem alloc]init];
        item.imageUrl = self.urlArray[i];
        item.deleteImageStr = @"";
        item.tag = 10+i;
        @WeakObj(self)
        item.addImage = ^{
            [selfWeak showBrowserForSimpleCaseWithSource:selfWeak.urlArray Index:i];
        };
        [_urlIamgeView addSubview:item];
        CGFloat lineN = i/4;
        CGFloat cloumN = i%4 ;
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16+(itemW+10)*cloumN);
            make.top.mas_equalTo((10+itemH)*lineN+5);
            make.size.mas_equalTo(CGSizeMake(itemW, itemH));
        }];
    }
}

- (WGHeaderView *)headerView{
    if (_headerView == nil) {
        WGHeaderView * headerView = [[WGHeaderView alloc]init];
        headerView.startDate = self.beginDate;
        headerView.endDate = self.endDate;
        headerView.type = self.adviceType;
        @WeakObj(self)
        UIWindow *window =[UIApplication sharedApplication].windows.lastObject;
        CGPoint point = [window convertPoint:self.point fromView:self.view];
        self.dropView =[[WGDorpView alloc]initWithTitleArray:self.typeArray orignPoint:point listWidth:ScreenWidth/5 selectResult:^(NSInteger index) {
            selfWeak.adviceType = selfWeak.typeArray[index];
            selfWeak.headerView.type = selfWeak.adviceType;
            [selfWeak setupUrlIamgeView:index*2+2];
        }];
        headerView.selectionFilter = ^(NSInteger type) {
            if (type == 0) {
                [selfWeak chooseDateWithType:0];
            }
            if (type == 1) {
                [selfWeak chooseDateWithType:1];
            }
            if (type == 2) {
                [selfWeak.dropView show];
            }
        };
        _headerView = headerView;
        
    }
    return _headerView;
}

#pragma mark---
#pragma mark---
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackColor;

    self.typeArray = @[@"2张",@"4张",@"6张",@"8张",@"10张",@"12张"];
    self.beginDate = [NSString getCurrentTime];
    self.endDate = [NSString getDateWithYears:0 moths:0 days:4];
    self.adviceType = String(@"4张");
    self.point = CGPointMake(ScreenWidth-16-ScreenWidth/5, NavHeight-4);
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(NavHeight+1);
        make.height.mas_equalTo(40);
    }];
    
    self.urlArray = @[@"https://b-ssl.duitang.com/uploads/item/201509/28/20150928210046_inFK8.thumb.700_0.jpeg",   @"https://b-ssl.duitang.com/uploads/item/201509/05/20150905171102_CtiFP.thumb.700_0.jpeg", @"https://b-ssl.duitang.com/uploads/item/201501/28/20150128185302_vsStm.jpeg", @"https://b-ssl.duitang.com/uploads/item/201212/08/20121208100105_BNeFR.jpeg", @"https://b-ssl.duitang.com/uploads/item/201407/23/20140723004156_cwjLY.png", @"https://b-ssl.duitang.com/uploads/item/201603/23/20160323130734_FLESm.jpeg", @"https://b-ssl.duitang.com/uploads/item/201605/14/20160514144257_BNrhx.thumb.700_0.jpeg", @"https://b-ssl.duitang.com/uploads/item/201410/16/20141016221043_SvUrz.thumb.700_0.jpeg",
                      @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1557151384084&di=7fefdbfe0688b3251f5b437fe3e0aba7&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201506%2F10%2F20150610135129_XmwE5.jpeg",
                      @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1557151302116&di=c1bf43c0e9e1a1b80e4b618f2595ceac&imgtype=0&src=http%3A%2F%2Fh.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2Fac345982b2b7d0a26b8f368ac9ef76094b369a66.jpg",
                      @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1557151277535&di=46f10e19bd80f07c5d93d3f892ade15f&imgtype=0&src=http%3A%2F%2Fimg1.xiazaizhijia.com%2Fwalls%2F20160307%2Fmid_77279b645bf4ec3.jpg",
                      @"http://b-ssl.duitang.com/uploads/item/201610/15/20161015160708_aCdRc.jpeg"];
    self.urlIamgeView = [[UIView alloc]init];
    self.urlIamgeView.backgroundColor = BaiSe;
    [self setupUrlIamgeView:4];
    [self.view addSubview:self.urlIamgeView];
    [self.urlIamgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(NavHeight+42);
        make.height.mas_equalTo(ScreenHeight/3);
    }];
}

#pragma mark - Show 'YBImageBrowser'
- (void)showBrowserForSimpleCaseWithSource:(NSArray *)imagesArray Index:(NSInteger)index{
    NSMutableArray *browserDataArr = [NSMutableArray array];
    [imagesArray enumerateObjectsUsingBlock:^(NSString *_Nonnull urlStr, NSUInteger idx, BOOL * _Nonnull stop) {
        YBImageBrowseCellData *data = [YBImageBrowseCellData new];
        data.url = [NSURL URLWithString:urlStr];
        data.sourceObject = [self sourceObjAtIdx:idx];
        [browserDataArr addObject:data];
    }];
    
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = browserDataArr;
    browser.currentIndex = index;
    [browser show];
}
- (id)sourceObjAtIdx:(NSInteger)idx{
    UIButton * imageBtn = [self.urlIamgeView viewWithTag:idx+10];
    return imageBtn ? imageBtn : nil;
}

#pragma mark ---  按钮点击
/**
 时间选择
 */
- (void)chooseDateWithType:(NSInteger)type{
    @WeakObj(self)
    WGDatePickerView *datepicker = [[WGDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *startDate) {
        NSString * date = [startDate stringWithFormat:@"yyyy-MM-dd"];
        if (type == 0) {//开始
            if([[NSDate date:self.endDate WithFormat:@"yyyy-MM-dd"] compare:startDate] == NSOrderedDescending){
                selfWeak.beginDate = date;
                selfWeak.headerView.startDate = date;
            }else{
                [WGPromptBoxView popUpPromptBoxWithTitle:@"提示" message:@"所选开始时间大于结束时间，请确认后重新选择" action:@"确定"];
            }
            
        }
        if (type == 1) {//结束
            if([startDate compare:[NSDate date:self.beginDate WithFormat:@"yyyy-MM-dd"]] == NSOrderedDescending){
                selfWeak.endDate = date;
                selfWeak.headerView.endDate = date;
            }else{
                [WGPromptBoxView popUpPromptBoxWithTitle:@"提示" message:@"所选结束时间小于开始时间，请确认后重新选择" action:@"确定"];
            }
        }
    }];
    datepicker.doneButtonColor = BASEColor;
    if (type == 0) {//开始
        datepicker.currentDate = [NSDate date:self.beginDate WithFormat:@"yyyy-MM-dd"];
    }
    if (type == 1) {//结束
        datepicker.currentDate = [NSDate date:self.endDate WithFormat:@"yyyy-MM-dd"];
    }
    [datepicker show];
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
