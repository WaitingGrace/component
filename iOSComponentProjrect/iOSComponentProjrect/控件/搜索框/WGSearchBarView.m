//
//  WGSearchBarView.m
//
//  Created by 帅棋 on 2018/6/13.
//  Copyright © 2018年 xinyihua. All rights reserved.
//

#import "WGSearchBarView.h"
#import "Config.h"
#import "WGSearchBar.h"

@interface WGSearchBarView ()<UISearchBarDelegate>
@property (nonatomic ,strong) WGSearchBar * searchBar;
@end
@implementation WGSearchBarView

- (void)setSearchInfo:(NSString *)searchInfo{
    _searchInfo = searchInfo;
    _searchBar.placeholder = searchInfo;
}
- (void)setBackColor:(UIColor *)backColor{
    _backColor = backColor;
    self.searchBar.backColor = backColor;
}
- (void)setBorderColor:(UIColor *)borderColor{
    _borderColor = borderColor;
    self.searchBar.borderColor = borderColor;
}
- (WGSearchBar *)searchBar{
    if (_searchBar == nil) {
        _searchBar = [[WGSearchBar alloc]init];

        _searchBar.delegate = self;
    }
    return _searchBar;
}
- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        [self setInitView];
    }
    return self;
}
#pragma mark ---  视图设置
- (void)setInitView{
    self.searchBar.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    [self addSubview:self.searchBar];
    
}
#pragma mark --- UISearchBar deleagete
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES]; //动画显示取消按钮
    searchBar.placeholder = self.searchInfo;
    for (UIView *view in [[_searchBar.subviews lastObject] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *cancelBtn = (UIButton *)view;
            [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        }
    }
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    searchBar.placeholder = self.searchInfo;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    if (_cancleSearch) {
        _cancleSearch();
    }
    searchBar.text = nil;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [[self superview] resignFirstResponder];
    [searchBar setShowsCancelButton:YES animated:YES];
    if (_searchBlock) {
        _searchBlock(searchBar.text);
    }
    searchBar.text = nil;
}


@end
