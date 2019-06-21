//
//  WGSphereMarkVC.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/29.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGSphereMarkVC.h"
#import "WGSphereView.h"

@interface WGSphereMarkVC ()
@property (nonatomic,strong) WGSphereView *sphereView;

@end

@implementation WGSphereMarkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"birthday_envelope_letter_paper"]];
    imageView.frame = self.view.frame;
    [self.view addSubview:imageView];
    
    CGFloat sphereViewW = self.view.frame.size.width - 30 * 2;
    CGFloat sphereViewH = sphereViewW;
    _sphereView = [[WGSphereView alloc] initWithFrame:CGRectMake(30, 200, sphereViewW, sphereViewH)];
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSInteger i = 0; i < 50; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:[NSString stringWithFormat:@"🍎👌%ld", i] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255. green:arc4random_uniform(255)/255. blue:arc4random_uniform(255)/255. alpha:1.];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:24.];
        btn.frame = CGRectMake(0, 0, 100, 40);
        btn.layer.cornerRadius = 3;
        btn.clipsToBounds = YES;
        [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [array addObject:btn];
        [_sphereView addSubview:btn];
    }
    [_sphereView setItems:array];
    [self.view addSubview:_sphereView];
    
}

- (void)buttonPressed:(UIButton *)btn
{
    [_sphereView timerStop];
    NSLog(@"%@",btn.titleLabel.text);
    
    [UIView animateWithDuration:0.3 animations:^{
        btn.transform = CGAffineTransformMakeScale(2., 2.);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            btn.transform = CGAffineTransformMakeScale(1., 1.);
        } completion:^(BOOL finished) {
            [self->_sphereView timerStart];
        }];
    }];
}


@end
