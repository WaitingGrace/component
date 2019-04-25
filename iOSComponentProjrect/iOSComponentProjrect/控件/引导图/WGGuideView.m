//
//  WGGuideView.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/4/4.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGGuideView.h"
#define     GUIDE_FLAGS    @"/guide"

@interface WGGuideView ()<UIScrollViewDelegate> {
    int screen_width;
    int screen_height;
}
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) NSArray *imageArray;

@end
@implementation WGGuideView

+ (void)showGudieView:(NSArray *)imageArray {
    if(imageArray && imageArray.count > 0) {
        NSFileManager *fmanager=[NSFileManager defaultManager];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docDir = [NSString stringWithFormat:@"%@/%@", [paths objectAtIndex:0], GUIDE_FLAGS];
        BOOL isHasFile = [fmanager fileExistsAtPath:docDir];
        if(!isHasFile) {
            WGGuideView *guideView = [[WGGuideView alloc] init:imageArray];
            [[UIApplication sharedApplication].delegate.window addSubview:guideView];
            [fmanager createFileAtPath:docDir contents:nil attributes:nil];
        }
    }
}

+ (void)skipGuide {
    NSFileManager *fmanager=[NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [NSString stringWithFormat:@"%@/%@", [paths objectAtIndex:0], GUIDE_FLAGS];
    [fmanager createFileAtPath:docDir contents:nil attributes:nil];
}
- (instancetype)init:(NSArray *)imageArray {
    self = [super init];
    if(self) [self initThisView:imageArray];
    return self;
}

- (void)initThisView:(NSArray *)imageArray {
    self.imageArray = imageArray;
    screen_width  = [UIScreen mainScreen].bounds.size.width;
    screen_height = [UIScreen mainScreen].bounds.size.height;
    self.frame = CGRectMake(0, 0, screen_width, screen_height);
    
    _scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    _scrollView.contentSize=CGSizeMake(screen_width * (_imageArray.count + 1), screen_height);
    _scrollView.pagingEnabled=YES;
    _scrollView.bounces = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.tag=7000;
    _scrollView.delegate = self;
    
    for (int i = 0; i < imageArray.count; i++) {
        CGRect frame = CGRectMake(i * screen_width, 20, screen_width, screen_height);
        UIImageView *img=[[UIImageView alloc] initWithFrame:frame];
        img.image=[UIImage imageNamed:imageArray[i]];
        [_scrollView addSubview:img];
        //skip
        CGRect skiprect = CGRectMake((i+1)*screen_width - 100, 33, 73, 30);
        UIButton *passbtn = [[UIButton alloc] initWithFrame:skiprect];
        [passbtn setTitle:@"跳过" forState:(UIControlStateNormal)];
        [passbtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        passbtn.layer.cornerRadius = 15.f;
        passbtn.clipsToBounds = YES;
        passbtn.layer.borderColor = [UIColor whiteColor].CGColor;
        passbtn.layer.borderWidth = 1.f;
    
        [passbtn addTarget:self action:@selector(dismissGuideView) forControlEvents:(UIControlEventTouchUpInside)];
        passbtn.backgroundColor = [UIColor clearColor];
        
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"guidebt0%d",i+1]];
        [passbtn setBackgroundImage:image forState:(UIControlStateNormal)];
        [_scrollView addSubview:passbtn];
    }
    [self addSubview:_scrollView];
}

#pragma mark scrollView的代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss:)];
    scrollView.userInteractionEnabled = YES;
    [scrollView addGestureRecognizer:singleTap];
    
    if (scrollView.contentOffset.x >= self.imageArray.count * screen_width) [self dismissGuideView];
}
- (void)dismiss:(UITapGestureRecognizer *)tap{
    if (_scrollView.contentOffset.x == (self.imageArray.count - 1) * screen_width) {        
        [self dismissGuideView];
    }
}
-(void)dismissGuideView {
    [UIView animateWithDuration:0.6f animations:^{
        self.transform = (CGAffineTransformMakeScale(1.5, 1.5));
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0; //让scrollview 渐变消失
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    } ];
    
    
}

@end
