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

@interface WGSeePhotosVC ()
@property (nonatomic ,strong) UIView * urlIamgeView;
@property (nonatomic ,strong) UIView * imageView;
@property (nonatomic ,strong) NSArray * urlArray;
@end

@implementation WGSeePhotosVC

- (UIView *)urlIamgeView{
    if (_urlIamgeView == nil) {
        _urlIamgeView = [[UIView alloc]init];
        _urlIamgeView.backgroundColor = BaiSe;
        CGFloat itemW = (ScreenWidth - (10*3+32))/4;
        CGFloat itemH = itemW;
        for (int i = 0; i < self.urlArray.count; i++) {
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
    return _urlIamgeView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackColor;
    self.urlArray = @[@"https://b-ssl.duitang.com/uploads/item/201509/28/20150928210046_inFK8.thumb.700_0.jpeg",   @"https://b-ssl.duitang.com/uploads/item/201509/05/20150905171102_CtiFP.thumb.700_0.jpeg", @"https://b-ssl.duitang.com/uploads/item/201501/28/20150128185302_vsStm.jpeg", @"https://b-ssl.duitang.com/uploads/item/201212/08/20121208100105_BNeFR.jpeg", @"https://b-ssl.duitang.com/uploads/item/201407/23/20140723004156_cwjLY.png", @"https://b-ssl.duitang.com/uploads/item/201603/23/20160323130734_FLESm.jpeg", @"https://b-ssl.duitang.com/uploads/item/201605/14/20160514144257_BNrhx.thumb.700_0.jpeg", @"https://b-ssl.duitang.com/uploads/item/201410/16/20141016221043_SvUrz.thumb.700_0.jpeg"];
    [self.view addSubview:self.urlIamgeView];
    [self.urlIamgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(NavHeight);
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




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
