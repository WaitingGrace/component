//
//  IDInfo.h
//
//  Created by 帅棋 on 2019/3/28.
//  Copyright © 2019 WG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IDInfo : NSObject

@property (nonatomic,assign) int type; //1:正面  2:反面
@property (nonatomic,copy) NSString *num; //身份证号
@property (nonatomic,copy) NSString *name; //姓名
@property (nonatomic,copy) NSString *gender; //性别
@property (nonatomic,copy) NSString *nation; //民族
@property (nonatomic,copy) NSString *address; //地址
@property (nonatomic,copy) NSString *issue; //签发机关
@property (nonatomic,copy) NSString *valid; //有效期
@property (nonatomic,copy) UIImage * image;

@end
