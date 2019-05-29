//
//  WGPopMenuView.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/17.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGPopMenuView.h"
#import "WGPopMenuItem.h"


#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
#define kDuration 0.2
#define kBottomViewTag 10
#define kBottomViewHeight 50
#define kCancleViewWidth 28
#define kMaxPopMenuItemColumn 4
#define kPopMenuItemWidth Width/kMaxPopMenuItemColumn
#define kPopMenuItemHeight kPopMenuItemWidth
#define kBasePopMenuTag 200
#define kInterval (0.195 / _items.count)

@interface WGPopMenuView()

@property (nonatomic, strong) UIWindow * window;
@property (nonatomic, strong) UIImage * bulrImage;
@property (nonatomic, strong) UIView * blurView;
@property (nonatomic, strong) NSArray * items;
@property (nonatomic, strong) selectCompletionBlock block;
@property (nonatomic, strong) UIImageView * exitView;
@property (nonatomic, strong) UILabel * tipsLbl;
@property (nonatomic, strong) UIView * bottomView;

@end
@implementation WGPopMenuView

+ (void)createPopMenuItems:(NSArray *)items
            closeImageName:(NSString *)closeImageName
                   topView:(UIView *)topView
           completionBlock:(selectCompletionBlock)block {
    
    WGPopMenuView *menu = [[WGPopMenuView alloc]initWithItems:items];
    
    [menu setTopView:topView];
    
    [menu setSelectCompletionBlock:block];
    
    [menu setExitViewImage:closeImageName];
}

+ (void)createPopMenuItems:(NSArray *)items
            closeImageName:(NSString *)closeImageName
           completionBlock:(selectCompletionBlock)block {
    
    WGPopMenuView *menu = [[WGPopMenuView alloc]initWithItems:items];
    
    [menu setSelectCompletionBlock:block];
    
    [menu setExitViewImage:closeImageName];
}

+ (void)createPopmenuItems:(NSArray *)items
            closeImageName:(NSString *)closeImageName
        backgroundImageUrl:(NSString *)urlStr
                    tipStr:(NSString *)tipStr
           completionBlock:(selectCompletionBlock)block {
    
    WGPopMenuView *menu = [[WGPopMenuView alloc]initWithItems:items];
    
    [menu setSelectCompletionBlock:block];
    
    [menu setTipsLblByTipsStr:tipStr];
    
    [menu setExitViewImage:closeImageName];
}

+ (void)createPopmenuItems:(NSArray *)items
            closeImageName:(NSString *)closeImageName
       backgroundImageName:(NSString *)bgImageName
                    tipStr:(NSString *)tipStr
           completionBlock:(selectCompletionBlock)block {
    
    WGPopMenuView *menu = [[WGPopMenuView alloc]initWithItems:items];
    
    [menu setSelectCompletionBlock:block];
    
    [menu setTipsLblByTipsStr:tipStr];
    
    [menu setExitViewImage:closeImageName];
}

- (instancetype)initWithItems:(NSArray *)items {
    
    self = [super init];
    
    if (self) {
        _items = items;
        
        [self setFrame:CGRectMake(0, 0, Width, Height)];
        
        [self initUI];
        
        [self show];
        
        //初始化设置 退出小按钮
        [self addSubview:self.exitView];
        
        //动画旋转
        typeof(self) weakSelf = self;
        
        [UIView animateWithDuration:kDuration animations:^{
            
            weakSelf.exitView.transform = CGAffineTransformMakeRotation(M_PI_2);
            
        }];
    }
    return self;
}

#pragma mark - private

- (void)initUI {
    
    //添加模糊背景
    [self addSubview:self.blurView];
    
    self.alpha = 0.0;
    
    //提示文字
    [self addSubview:self.tipsLbl];
    
    //下边的按钮背景
    [self addSubview:self.bottomView];
    
    //添加所有的按钮
    [self calculatingItems];
}

/**
 *  计算按钮的位置
 */
- (void)calculatingItems {
    
    typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:kDuration animations:^{
        
        [weakSelf setAlpha:1];
        
    }];
    
    NSInteger index = 0;
    
    NSInteger count = _items.count;
    
    for (NSMutableDictionary *dict in _items) {
        CGFloat buttonX,buttonY;
        
        buttonX = (index % kMaxPopMenuItemColumn) * kPopMenuItemWidth;
        buttonY = ((index / kMaxPopMenuItemColumn) * (kPopMenuItemHeight + 10)) + (Height/1.7);
        
        if (count == 2) {
            buttonX = (index % kMaxPopMenuItemColumn) * kPopMenuItemWidth + (kPopMenuItemWidth / 3) * (index + 1);
            buttonY = CGRectGetMinY(_bottomView.frame) - (kPopMenuItemHeight + 10) * 2;
        }
        
        CGRect fromValue = CGRectMake(buttonX, CGRectGetMinY(_bottomView.frame), kPopMenuItemWidth, kPopMenuItemHeight);
        
        CGRect toValue = CGRectMake(buttonX, buttonY, kPopMenuItemWidth, kPopMenuItemHeight);
        
        if (index == 0) {
            _maxTopViewY = CGRectGetMinY(toValue);
        }
        
        WGPopMenuItem *button = [self allocButtonIndex:index With:fromValue];
        
        button.attrDic = dict;
        
        double delayInSeconds = index * kInterval;

        
        [self startTheAnimationFromValue:fromValue toValue:toValue delay:delayInSeconds object:button alpha:1 completionBlock:^(BOOL complete) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(dismiss)];
            [_blurView addGestureRecognizer:tap];
        } hideDisplay:false];
        
        index ++;
    }
}

/**
 *  隐藏方法
 */
-(void)dismiss{
    [_bottomView setUserInteractionEnabled:false];
    
    [self setUserInteractionEnabled:false];
    
    __weak __typeof(self)weakSelf = self;
    
    [self dismissCompletionBlock:^(BOOL complete) {
        [weakSelf removeFromSuperview];
    }];
}

/**
 *  隐藏动画
 *
 *  @param completionBlock 完成回调
 */
-(void)dismissCompletionBlock:(void(^) (BOOL complete)) completionBlock{
    
    //动画旋转
    typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.38 animations:^{
        weakSelf.exitView.transform = CGAffineTransformMakeRotation(M_PI_2/2);
    }];
    
    NSInteger index = 0;
    
    NSInteger count = _items.count;
    
    for (NSMutableDictionary *dic in _items) {
        WGPopMenuItem *button = (WGPopMenuItem *)[self viewWithTag:(index + 1) + kBasePopMenuTag];
        button.attrDic = dic;
        
        CGFloat buttonX,buttonY;
        buttonX = (index % kMaxPopMenuItemColumn) * kPopMenuItemWidth;
        buttonY = ((index / kMaxPopMenuItemColumn) * (kPopMenuItemHeight +10)) + (Height/2.9);
        
        if (count == 2) {
            buttonX = (index % kMaxPopMenuItemColumn) * kPopMenuItemWidth + (kPopMenuItemWidth / 3) * (index + 1);
            buttonY = CGRectGetMinY(_bottomView.frame) - (kPopMenuItemHeight + 10) * 2;
        }
        
        CGRect toValue = CGRectMake(buttonX, Height, kPopMenuItemWidth, kPopMenuItemHeight);
        CGRect fromValue = CGRectMake(buttonX, buttonY, kPopMenuItemWidth, kPopMenuItemHeight);
        double delayInSeconds = (_items.count - index) * kInterval;
        
        [UIView animateWithDuration:0.2 animations:^{
            [_bottomView setBackgroundColor:[UIColor clearColor]];
        }];
        
        [self startTheAnimationFromValue:fromValue toValue:toValue delay:delayInSeconds object:button alpha:0 completionBlock:^(BOOL complete) {
            
        } hideDisplay:true];
        index ++;
    }
    [self hideDelay:0.38f completionBlock:^(BOOL completion) {
        
    }];
}


/**
 *  开始弹出动画
 *
 *  @param fromValue       起始位置
 *  @param toValue         结束位置
 *  @param delay           延迟
 *  @param btn             执行动画对象
 *  @param completionBlock 完成回调
 *  @param hideDisplay     hideDisplay YES or NO
 */
-(void)startTheAnimationFromValue:(CGRect)fromValue
                          toValue:(CGRect)toValue
                            delay:(float)delay
                           object:(WGPopMenuItem *)btn
                            alpha:(float)alpha
                  completionBlock:(void(^) (BOOL complete))completionBlock
                      hideDisplay:(BOOL)hideDisplay{
    
    //设置初始位置
    [UIView animateWithDuration:.16 delay:delay options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        btn.frame = CGRectMake(toValue.origin.x, toValue.origin.y - 8, toValue.size.width, toValue.size.height);
        btn.alpha = alpha;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.2 animations:^{
            btn.frame = CGRectMake(toValue.origin.x, toValue.origin.y + 4, toValue.size.width, toValue.size.height);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:.1 animations:^{
                btn.frame = CGRectMake(toValue.origin.x, toValue.origin.y, toValue.size.width, toValue.size.height);
                completionBlock(YES);
            }];
        }];
    }];
}

/**
 *  生成MenuItem
 *
 *  @param index 下标
 *
 *  @return PopMenuItem
 */
-(WGPopMenuItem *)allocButtonIndex:(NSInteger)index With:(CGRect)frame
{
    WGPopMenuItem *button = [[WGPopMenuItem alloc] initWithFrame:frame];
    [button setTag:(index + 1) + kBasePopMenuTag];
    [button setAlpha:0.0f];
    [button setTitleColor:[UIColor colorWithWhite:0.38 alpha:1] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(menuItemSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    return button;
}

/**
 *  选中了MenuItem后的响应事件
 *
 *  @param menuItem menuItem对象
 */
-(void)menuItemSelected:(WGPopMenuItem *)menuItem
{
    NSInteger tag = menuItem.tag - (kBasePopMenuTag + 1);
    
    __block WGPopMenuView *weakSelf = self;
    
    for (NSMutableDictionary *dict in _items) {
        NSInteger index = [_items indexOfObject:dict];
        WGPopMenuItem *buttons = (WGPopMenuItem *)[self viewWithTag:(index + 1) + kBasePopMenuTag];
        if (index == tag) {
            [menuItem playSelectAnimation];
        }else{
            [buttons playCancelAnimation];
        }
    }
    [self hideDelay:0.3f completionBlock:^(BOOL completion) {
        if (!weakSelf.block) {
            return ;
        }
        weakSelf.block(tag);
    }];
}

/**
 *  隐藏
 *
 *  @param delay 延时时间
 *  @param blcok 完成后回调block
 */
-(void)hideDelay:(NSTimeInterval)delay completionBlock:(void(^)(BOOL completion))blcok {
    
    [self setUserInteractionEnabled:false];
    
    typeof(self) weakSelf = self;
    
    [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        
        [_bottomView setBackgroundColor:[UIColor clearColor]];
        _tipsLbl.hidden = YES;
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateKeyframesWithDuration:kDuration delay:delay options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        
        [weakSelf setAlpha:0.0f];
        
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
        if (!blcok) {
            return ;
        }
        blcok(finished);
    }];
}

-(void)removeFromSuperview{
    [super removeFromSuperview];
}


-(void)dealloc
{
    NSArray *subViews = [_window subviews];
    for (id obj in subViews) {
        [obj removeFromSuperview];
    }
    [_window resignKeyWindow];
    [_window removeFromSuperview];
    _window = nil;
}

-(void)show{
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.windowLevel = UIWindowLevelNormal;
    _window.backgroundColor = [UIColor clearColor];
    _window.alpha = 1;
    _window.hidden = false;
    [_window addSubview:self];
}

#pragma mark - Setter

-(UIView *)blurView
{
    if (_blurView == nil)
    {
        float version = [[UIDevice currentDevice].systemVersion floatValue];
        
        if (version >= 8.0)
        {
            UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
            
            _blurView = [[UIVisualEffectView alloc]initWithEffect:blur];
            
            ((UIVisualEffectView *)_blurView).frame = self.bounds;
            
        } else if (version >= 7.0)
        {
            _blurView = [[UIToolbar alloc] initWithFrame:self.bounds];
            
            ((UIToolbar *)_blurView).barStyle = UIBarStyleDefault;
            
        } else
        {
            _blurView = [[UIView alloc] initWithFrame:self.bounds];
            
            [_blurView setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.9f]];
        }
        
        _blurView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin;
    }
    return _blurView;
}

-(UIView *)bottomView
{
    if (_bottomView == nil)
    {
        _bottomView = [[UIView alloc]init];
        
        CGFloat bottomY = Height - kBottomViewHeight;
        
        _bottomView.userInteractionEnabled = NO;
        
        [_bottomView setFrame:CGRectMake(0, bottomY, Width, kBottomViewHeight)];
        
        [_bottomView setBackgroundColor:[UIColor colorWithWhite:1.f alpha:0.90f]];
    }
    return _bottomView;
}

-(UILabel *)tipsLbl
{
    if (_tipsLbl == nil)
    {
        _tipsLbl = [[UILabel alloc]initWithFrame:CGRectMake(Width / 9, Height - kBottomViewHeight - kPopMenuItemHeight, Width * 7 / 9, kPopMenuItemHeight)];
        
        _tipsLbl.numberOfLines = 0;
        
        _tipsLbl.textColor = [UIColor grayColor];
        
        _tipsLbl.font = [UIFont systemFontOfSize:10];
        
        _tipsLbl.textAlignment = NSTextAlignmentCenter;
    }
    return _tipsLbl;
}

-(UIImageView *)exitView
{
    if (_exitView == nil)
    {
        _exitView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
        
        CGPoint center = CGPointMake(Width/2, Height - kBottomViewHeight);
        
        _exitView.center = center;
        
        _exitView.userInteractionEnabled = NO;
        
        _exitView.transform = CGAffineTransformMakeRotation(M_PI_2/2);
    }
    return _exitView;
}

-(void)setTopView:(UIView *)topView {
    
    if (![topView isKindOfClass:[NSNull class]] &&
        [topView isKindOfClass:[UIView class]]) {
        _topView = topView;
        [_blurView addSubview:topView];
    }
}

- (void)setTipsLblByTipsStr:(NSString *)tipsStr {
    if (_tipsLbl) {
        _tipsLbl.text = tipsStr;
    }
}

- (void)setExitViewImage:(NSString *)imageName {
    if (_exitView) {
        _exitView.image = [UIImage imageNamed:imageName];
    }
}

- (void)setSelectCompletionBlock:(selectCompletionBlock)block {
    _block = block;
}


@end
