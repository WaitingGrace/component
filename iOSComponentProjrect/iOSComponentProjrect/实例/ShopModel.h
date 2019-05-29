//
//  ShopModel.h
//  CustomWaterFlow
//
//  Created by DYS on 15/12/12.
//  Copyright © 2015年 DYS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ShopModel : NSObject
//高
@property (nonatomic, assign)CGFloat  h;
//宽
@property (nonatomic, assign)CGFloat  w;
//图片的URL
@property (nonatomic, copy) NSString *img;
//商品的价格
@property (nonatomic, copy) NSString *price;

@property(nonatomic,copy)NSString *ID;
@property (nonatomic,copy) NSString *comments;
@property (nonatomic,copy) NSNumber *cover_wh_ratios;
@property (nonatomic,copy) NSString *cover_url;
@property (nonatomic,copy) NSString *plays;
@property (nonatomic,copy) NSNumber *view_flag;
@property (nonatomic,copy) NSString *tags;
@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,copy) NSString *desc;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *nick;
@property (nonatomic,copy) NSString *icon_url;


- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)shopWithDict:(NSDictionary *)dict;
@end
