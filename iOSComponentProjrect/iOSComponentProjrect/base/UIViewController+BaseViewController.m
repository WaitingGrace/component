//
//  UIViewController+BaseViewController.m
//  YHWKYS
//
//  Created by 新益华 on 2018/3/8.
//  Copyright © 2018年 新益华. All rights reserved.
//


#import "UIViewController+BaseViewController.h"
#import "ViewController.h"
#import "WGMineViewController.h"
#import "WGTabbar.h"

@implementation UIViewController (BaseViewController)
/*! 设置tabbar */
+ (UITabBarController *)rootViewController{
    UINavigationController * homeNav = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    UINavigationController * meNav = [[UINavigationController alloc] initWithRootViewController:[[WGMineViewController alloc] init]];
    
    UITabBarController* tabBarController = [[UITabBarController alloc] init];
    tabBarController.view.backgroundColor = [UIColor whiteColor];
    NSArray* subControllers = @[homeNav,meNav];
    NSArray* titles = @[@"首页", @"其他"];
    NSArray* tabImageNames = @[ @"ic_home_home_normal",@"ic_home_circle_normal"];
    NSArray* tabSelectedImageNames = @[ @"ic_home_home_selected", @"ic_home_circle_selected"];
    
    //使用block块列举
    [subControllers enumerateObjectsUsingBlock:^(UIViewController* controller, NSUInteger idx, BOOL* stop) {
        [self setTabBarItem:controller.tabBarItem Title:titles[idx] withTitleSize:iPad?15.f:12.f andFoneName:@"PingFangSC-Medium" selectedImage:tabSelectedImageNames[idx] withTitleColor:BASEColor unselectedImage:tabImageNames[idx] withTitleColor:UIColorFromRGB(0x999999)];
    }];
    WGTabbar *tabBar = [[WGTabbar alloc] init];
    
    [tabBarController setValue:tabBar forKey:@"tabBar"];
    tabBarController.viewControllers = subControllers;
    tabBarController.selectedIndex = 0;
    return tabBarController;
}

+ (void)setTabBarItem:(UITabBarItem *)tabbarItem
                Title:(NSString *)title
        withTitleSize:(CGFloat)size
          andFoneName:(NSString *)foneName
        selectedImage:(NSString *)selectedImage
       withTitleColor:(UIColor *)selectColor
      unselectedImage:(NSString *)unselectedImage
       withTitleColor:(UIColor *)unselectColor{
    //设置图片
    tabbarItem = [tabbarItem initWithTitle:title image:[[UIImage imageNamed:unselectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //未选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:unselectColor,NSFontAttributeName:[UIFont fontWithName:foneName size:size]} forState:UIControlStateNormal];
    //选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:selectColor,NSFontAttributeName:[UIFont fontWithName:foneName size:size]} forState:UIControlStateSelected];
}



@end
