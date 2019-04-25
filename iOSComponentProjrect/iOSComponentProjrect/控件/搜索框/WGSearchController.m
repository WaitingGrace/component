//
//  WGSearchController.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/3/27.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGSearchController.h"

@interface WGSearchController ()

@end

@implementation WGSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dimsBackgroundDuringPresentation = NO;
}

- (instancetype)initWithSearchResultsController:(UIViewController *)searchResultsController searchBarFrame:(CGRect)searchBarFrame placeholder:(NSString *)placeholder text:(NSString *)text textFieldLeftView:(UIImageView *)leftView showCancelButton:(BOOL)showCancelButton barTintColor:(UIColor *)barTintColor{
    if (self = [super initWithSearchResultsController:searchResultsController]) {
        self.navSearchBar = [[WGNavSearchBar alloc] initWithFrame:searchBarFrame
                                                          placeholder:placeholder
                                                                 text:text
                                                    textFieldLeftView:leftView
                                                     showCancelButton:YES
                                                            tintColor:barTintColor
                                                            textColor:TitleColor
                                                                 font:FONT(iPhone4_5?14:(iPhone6?15:16))
                                                      backgroundColor:BackColor];
        
        UIButton *button = [self.navSearchBar valueForKey:@"cancelButton"];
        button.tintColor = BASEColor;
        [button setTitle:String(@"取消") forState:UIControlStateNormal];
        [self.navSearchBar setValue:button forKey:@"cancelButton"];
    }
    return self;
}

@end
