//
//  WGAddressModel.h
//  IMHJM
//
//  Created by 帅棋 on 2018/7/9.
//  Copyright © 2018年 xinyihua. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * kSite_Name = @"orgname";
static NSString * kSite_Id = @"orgid";
static NSString * kSite_Level = @"orglevel";
static NSString * kSite_Code = @"orgcode";
static NSString * kSite_seq = @"orgseq";

@interface WGAddressModel : NSObject
@property (nonatomic, copy) NSString * ID;       // id码
@property (nonatomic, copy) NSString * code;     // 地址码
@property (nonatomic, copy) NSString * name;     // 对应的名称（如：四川省、成都市、武侯区等）
@property (nonatomic, copy) NSString * level;    // 等级(1为省级、2为市级、3为区县级、4为乡镇级、5为街道<村>级)
@property (nonatomic, copy) NSString * seq;
@property (nonatomic, assign) BOOL  isSelected;

+ (instancetype)addressModelWithDictionary:(NSDictionary *)info;
- (instancetype)initWithDictionary:(NSDictionary *)info;
@end
