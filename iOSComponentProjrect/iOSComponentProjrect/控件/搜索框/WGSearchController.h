//
//  WGSearchController.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/3/27.
//  Copyright © 2019 WG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WGNavSearchBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface WGSearchController : UISearchController
@property (nonatomic, strong) WGNavSearchBar * navSearchBar;

- (instancetype)initWithSearchResultsController:(UIViewController *)searchResultsController searchBarFrame:(CGRect)frame placeholder:(NSString *)placeholder text:(NSString *)text textFieldLeftView:(UIImageView *)leftView showCancelButton:(BOOL)showCancelButton barTintColor:(UIColor *)barTintColor;
@end

NS_ASSUME_NONNULL_END
