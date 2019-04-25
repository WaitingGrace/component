//
//  WGAskImageItem.h
//
//  Created by 帅棋 on 2018/8/22.
//  Copyright © 2018年 xinyihua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AddAskImageBlock) (void);
typedef void (^DeleteAskImageBlock) (void);
@interface WGImageItem : UIView

@property (nonatomic ,strong) UIImage * image;
@property (nonatomic ,strong) NSString * imageStr;
@property (nonatomic ,strong) NSString * imageUrl;
@property (nonatomic ,strong) NSString * deleteImageStr;
@property (nonatomic ,strong) AddAskImageBlock addImage;
@property (nonatomic ,strong) DeleteAskImageBlock deleteImage;


@end
