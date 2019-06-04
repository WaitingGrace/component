//
//  WGDraggableVC.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/30.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGDraggableVC.h"
#import "WGDraggableContainer.h"
#import "WGCustomCardView.h"
#import "Config.h"

@interface WGDraggableVC ()<WGDraggableContainerDataSource,WGDraggableContainerDelegate>

@property (nonatomic, strong) WGDraggableContainer *container;
@property (nonatomic, strong) NSMutableArray *dataSources;
@property (nonatomic, strong) UIButton *disLikeButton;
@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UIButton *detailBtn;

@end

@implementation WGDraggableVC

- (UIButton *)disLikeButton{
    if (_disLikeButton == nil) {
        _disLikeButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_disLikeButton setImage:[UIImage imageNamed:@"nope"] forState:(UIControlStateNormal)];
        [_disLikeButton addTarget:self action:@selector(dislikeEvent:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _disLikeButton;
}
- (UIButton *)likeButton{
    if (_likeButton == nil) {
        _likeButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_likeButton setImage:[UIImage imageNamed:@"liked"] forState:(UIControlStateNormal)];
        [_likeButton addTarget:self action:@selector(likeEvent:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _likeButton;
}
- (UIButton *)detailBtn{
    if (_detailBtn == nil) {
        _detailBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_detailBtn setImage:[UIImage imageNamed:@"ic_reload"] forState:(UIControlStateNormal)];
        [_detailBtn addTarget:self action:@selector(reloadDataEvent:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _detailBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackColor;
    
    
    [self loadData];
    [self loadUI];
}

- (void)loadUI {
    
    self.container = [[WGDraggableContainer alloc] initWithFrame:CGRectMake(0, NavHeight+40, ScreenWidth, ScreenWidth) style:WGDraggableStyleUpOverlay];
    self.container.delegate = self;
    self.container.dataSource = self;
    [self.view addSubview:self.container];
    [self.container reloadData];
    
    [self.view addSubview:self.likeButton];
    [self.view addSubview:self.detailBtn];
    [self.view addSubview:self.disLikeButton];
    CGFloat btnW = ScreenWidth/5;
    [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.container.mas_bottom).offset(30);
        make.right.mas_equalTo(-40);
        make.size.mas_equalTo(CGSizeMake(btnW, btnW));
    }];
    [self.detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.likeButton);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    [self.disLikeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.container.mas_bottom).offset(30);
        make.left.mas_equalTo(40);
        make.size.mas_equalTo(CGSizeMake(btnW, btnW));
    }];
    
}
- (void)loadData {
    _dataSources = [NSMutableArray array];
    for (int i = 0; i < 8; i++) {
        NSDictionary *dict = @{@"image" : [NSString stringWithFormat:@"image_%d.jpg",i + 1],
                               @"title" : [NSString stringWithFormat:@"Page %d",i + 1]};
        [_dataSources addObject:dict];
    }
}


- (void)reloadDataEvent:(id)sender {
    if (self.container) {
        [self.container reloadData];
    }
}
- (void)dislikeEvent:(id)sender {
    [self.container removeFormDirection:WGDraggableDirectionLeft];
}
- (void)likeEvent:(id)sender {
    [self.container removeFormDirection:WGDraggableDirectionRight];
}
#pragma mark - CCDraggableContainer DataSource

- (WGDraggableCardView *)draggableContainer:(WGDraggableContainer *)draggableContainer viewForIndex:(NSInteger)index {
    WGCustomCardView *cardView = [[WGCustomCardView alloc] initWithFrame:draggableContainer.bounds];
    [cardView installData:[_dataSources objectAtIndex:index]];
    return cardView;
}

- (NSInteger)numberOfIndexs {
    return _dataSources.count;
}

#pragma mark - CCDraggableContainer Delegate

- (void)draggableContainer:(WGDraggableContainer *)draggableContainer draggableDirection:(WGDraggableDirection)draggableDirection widthRatio:(CGFloat)widthRatio heightRatio:(CGFloat)heightRatio {
    CGFloat scale = 1 + ((kBoundaryRatio > fabs(widthRatio) ? fabs(widthRatio) : kBoundaryRatio)) / 4;
    if (draggableDirection == WGDraggableDirectionLeft) {
        self.disLikeButton.transform = CGAffineTransformMakeScale(scale, scale);
    }
    if (draggableDirection == WGDraggableDirectionRight) {
        self.likeButton.transform = CGAffineTransformMakeScale(scale, scale);
    }
}
- (void)draggableContainer:(WGDraggableContainer *)draggableContainer cardView:(WGDraggableCardView *)cardView didSelectIndex:(NSInteger)didSelectIndex {
    NSLog(@"点击了Tag为%ld的Card", (long)didSelectIndex);
}
- (void)draggableContainer:(WGDraggableContainer *)draggableContainer finishedDraggableLastCard:(BOOL)finishedDraggableLastCard {
    [draggableContainer reloadData];
}

@end
