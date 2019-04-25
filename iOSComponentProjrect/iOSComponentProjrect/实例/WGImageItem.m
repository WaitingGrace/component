//
//  WGHAskImageItem.m
//
//  Created by 帅棋 on 2018/8/22.
//  Copyright © 2018年 xinyihua. All rights reserved.
//

#import "WGImageItem.h"
#import "Config.h"

@interface WGImageItem ()
@property (nonatomic ,strong) UIButton * imageBtn;
@property (nonatomic ,strong) UIButton * deleteBtn;


@end
@implementation WGImageItem
- (UIButton *)imageBtn{
    if (_imageBtn == nil) {
        _imageBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_imageBtn setBackgroundColor:[UIColor clearColor]];
        [_imageBtn addTarget:self action:@selector(addImageClick) forControlEvents:(UIControlEventTouchUpInside)];
        _imageBtn.layer.cornerRadius = 4.f;
        _imageBtn.clipsToBounds = YES;
    }
    return _imageBtn;
}
- (UIButton *)deleteBtn{
    if (_deleteBtn == nil) {
        _deleteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_deleteBtn setBackgroundColor:[UIColor clearColor]];
        [_deleteBtn addTarget:self action:@selector(deleteImageClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _deleteBtn;
}

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setInitView];
    }
    return self;
}

- (void)setInitView{
    [self addSubview:self.imageBtn];
    [self addSubview:self.deleteBtn];
    [self.imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.bottom.right.mas_equalTo(0);
    }];
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.imageBtn.mas_right);
        make.top.mas_equalTo(self.imageBtn.mas_top).offset(0);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
}

- (void)setImage:(UIImage *)image{
    _image = image;
    [self.imageBtn setImage:image forState:(UIControlStateNormal)];
    self.imageBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
}
- (void)setImageStr:(NSString *)imageStr{
    _imageStr = imageStr;
    [self.imageBtn setImage:[UIImage imageNamed:imageStr] forState:(UIControlStateNormal)];
    self.imageBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
}
- (void)setImageUrl:(NSString *)imageUrl{
    _imageUrl = imageUrl;
    [self.imageBtn sd_setImageWithURL:[NSURL URLWithString:imageUrl] forState:(UIControlStateNormal)];
    self.imageBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)setDeleteImageStr:(NSString *)deleteImageStr{
    _deleteImageStr = deleteImageStr;
    if ([NSString stringIsNULL:deleteImageStr]) {
        self.deleteBtn.hidden = YES;
    }else{
        self.deleteBtn.hidden = NO;
        [self.deleteBtn setImage:[UIImage imageNamed:deleteImageStr] forState:(UIControlStateNormal)];
    }
}

- (void)addImageClick{
    if (self.addImage) {
        self.addImage();
    }
}
- (void)deleteImageClick{
    if (self.deleteImage) {
        self.deleteImage();
    }
}

@end
