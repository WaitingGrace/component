//
//  IMHTopSegmetControl.m
//  IMHJM
//
//  Created by 帅棋 on 2018/6/13.
//  Copyright © 2018年 xinyihua. All rights reserved.
//

#import "IMHTopSegmetControl.h"
#import "Config.h"

@interface IMHTopSegmetControl ()
{
    CGFloat edgeNum;
}
@property (nonatomic, strong) UIButton * selecteBtn;//当前选中的按钮
@property (nonatomic, strong) UIButton * firstBTn;//第一个按钮
@property (nonatomic, strong) UIButton * secondBtn;//第二个按钮
@property (nonatomic, strong) UIView * indicatorView;//标记图（下划线）
@property (nonatomic ,assign) CGFloat centerX;//指示标的中心
@end
@implementation IMHTopSegmetControl
-(void)setTitlesArray:(NSArray *)titlesArray{
    _titlesArray = titlesArray;
    [self.firstBTn setTitle:titlesArray[0] forState:(UIControlStateNormal)];
    [self.secondBtn setTitle:titlesArray[1] forState:(UIControlStateNormal)];
}

+ (instancetype)createChooseView:(NSArray *)titlesArray selectedIndex:(NSInteger)index size:(CGSize)size{
    IMHTopSegmetControl * chooseView = [[IMHTopSegmetControl alloc]init];
    return [chooseView setupWith:titlesArray selectedIndex:index size:size];
}

- (UIButton *)firstBTn{
    if (_firstBTn == nil) {
        _firstBTn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_firstBTn setTitleColor:RGB(153, 153, 153) forState:(UIControlStateNormal)];
        [_firstBTn setTitleColor:BASEColor forState:(UIControlStateSelected)];
        _firstBTn.titleLabel.font = FONT(iPhone4_5?15:16);
        [_firstBTn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        _firstBTn.tag = 101;
    }
    return _firstBTn;
}

- (UIButton *)secondBtn{
    if (_secondBtn == nil) {
        _secondBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_secondBtn setTitleColor:RGB(153, 153, 153) forState:(UIControlStateNormal)];
        [_secondBtn setTitleColor:BASEColor forState:(UIControlStateSelected)];
        _secondBtn.titleLabel.font = FONT(iPhone4_5?15:16);
        [_secondBtn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        _secondBtn.tag = 102;
    }
    return _secondBtn;
}

-(UIView *)indicatorView{
    if (_indicatorView == nil) {
        _indicatorView = [[UIView alloc] init];
        _indicatorView.backgroundColor = BASEColor;
        _indicatorView.layer.cornerRadius = 1.5f;
        _indicatorView.clipsToBounds = YES;
    }
    return _indicatorView;
}

/**
 初始化选择视图
 
 @param titlesArray 按钮标题数组
 @param index 默认选中按钮的索引
 @param size 视图size
 @return 分段控制器视图
 */
-(instancetype)setupWith:(NSArray *)titlesArray selectedIndex:(NSInteger)index size:(CGSize)size{
    if (self == [super init]) {
        if (index == 101) {
            self.selecteBtn = self.firstBTn;
            self.firstBTn.selected = YES;
        }else{
            self.selecteBtn = self.secondBtn;
            self.secondBtn.selected = YES;
        }
        CGRect frame = self.frame;
        frame.size = size;
        edgeNum = size.width/2;
        NSLog(@"%g",edgeNum);
        self.frame = frame;
        [self.firstBTn setTitle:titlesArray[0] forState:(UIControlStateNormal)];
        [self.secondBtn setTitle:titlesArray[1] forState:(UIControlStateNormal)];
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.firstBTn];
        [self addSubview:self.secondBtn];
        [self addSubview:self.indicatorView];
        [self setConstrains];
    }
    return self;
}


//设置子视图的约束
-(void)setConstrains{
    [self.firstBTn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(44);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(self->edgeNum);
    }];
    [self.secondBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(44);
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(self->edgeNum);
    }];
    
    [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.selecteBtn);
        make.width.mas_equalTo(iPhonePlus_X?(self->edgeNum*2/7):(self->edgeNum*2/6));
        make.height.mas_equalTo(2);
        make.bottom.mas_equalTo(0);
    }];
}

-(void)setSelectedTagOfBtn:(NSInteger)selectedTagOfBtn{
    _selectedTagOfBtn = selectedTagOfBtn;
    UIButton * selectedButton = (UIButton *)[self viewWithTag:selectedTagOfBtn];
    if (self.selecteBtn != selectedButton) {
        selectedButton.selected = YES;
        self.selecteBtn.selected = NO;
        self.selecteBtn = selectedButton;
    }
    [self.indicatorView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(selectedButton);
        make.width.mas_equalTo(iPhonePlus_X?(self->edgeNum*2/7):(self->edgeNum*2/6));
        make.height.mas_equalTo(2);
        make.bottom.mas_equalTo(0);
    }];
    @WeakObj(self);
    [UIView animateWithDuration:0.1 animations:^{
        [selfWeak layoutIfNeeded];
    }];
    
}

- (void)btnClick:(UIButton *)sender{
    if (self.selecteBtn != sender) {
        sender.selected = YES;
        self.selecteBtn.selected = NO;
        self.selecteBtn = sender;
        if (_selectedBlock) {
            _selectedBlock(sender.tag);
        }
    }
}


@end
