//
//  NavigationView.m
//  YHWK
//
//  Created by 新益华 on 2017/5/9.
//  Copyright © 2017年 新益华. All rights reserved.
//

#import "NavigationView.h"
#import "NSString+WGFrame.h"

@interface NavigationView ()
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backItemH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backitemW;

@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentitemW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentItemH;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelW;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerY;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentBtnW;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *countW;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailImageW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailImageH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailBtnW;

@end
@implementation NavigationView


+ (instancetype)createdNavigationView{
    NSArray * views = [[NSBundle mainBundle]loadNibNamed:@"NavigationView" owner:self options:nil];
    NavigationView * view = (NavigationView *)views[0];
    if (iPhoneXAll) {
        view.centerY.constant = view.center.y-15;
    }
    return view;
}
- (void)setInitNavigationviewWith:(NSDictionary *)titleInfo
                         backItem:(NSDictionary *)backItemInfo
                      contentitem:(NSDictionary *)contentitemInfo
                         isHidden:(BOOL)isHidden{
     if (titleInfo != nil){
         if ([titleInfo objectForKey:@"title"]){
             _titleLabel.text = titleInfo[@"title"];
         }
         if ([titleInfo objectForKey:@"font"]){
             CGFloat font = [titleInfo[@"font"] integerValue];
             _titleLabel.font = BoldFONT(iPhone4_5?font-1.0:font);
         }
         if ([titleInfo objectForKey:@"color"]){
             _titleLabel.textColor = titleInfo[@"color"];
         }
     }else{
         _titleLabel.text = @" ";
     }
     if (backItemInfo != nil){
         if ([backItemInfo objectForKey:@"image"]){
             if([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.0) {
                 _backImageView.image = [[UIImage alloc]initWithCGImage:[UIImage imageNamed:backItemInfo[@"image"]].CGImage scale:2.0 orientation:UIImageOrientationUp];
             } else {
                 _backImageView.image = [UIImage imageNamed:backItemInfo[@"image"]];
             }
        }
         if ([backItemInfo objectForKey:@"height"]){
             _backItemH.constant = [backItemInfo[@"height"] floatValue];
         }
         if ([backItemInfo objectForKey:@"width"]){
             _backitemW.constant = [backItemInfo[@"width"] floatValue];
         }
         
     }else{
         self.backItem.hidden = isHidden;
         self.backImageView.hidden = isHidden;
     }
     if (contentitemInfo != nil){
         if ([contentitemInfo objectForKey:@"image"]){//图片按钮
             _contentImageView.hidden = NO;
             self.contentItem.hidden = NO;
             _contentImageView.image = [UIImage imageNamed:contentitemInfo[@"image"]];
         }
         if ([contentitemInfo objectForKey:@"height"]){
             _contentItemH.constant = [contentitemInfo[@"height"] floatValue];
         }
         if ([contentitemInfo objectForKey:@"width"]){
             _contentitemW.constant = [contentitemInfo[@"width"] floatValue];
         }
         if ([contentitemInfo objectForKey:@"btnWidth"]) {
             _contentBtnW.constant = [contentitemInfo[@"btnWidth"] floatValue];
         }
         if ([contentitemInfo objectForKey:@"title"]){//文字按钮
             _contentImageView.hidden = YES;
             _contentItem.hidden = NO;
             [_contentItem setTitle:contentitemInfo[@"title"] forState:(UIControlStateNormal)];
             if ([contentitemInfo objectForKey:@"btnWidth"]) {
                 _contentBtnW.constant = [contentitemInfo[@"btnWidth"] floatValue];
             }else{
                 if ([contentitemInfo objectForKey:@"font"]){
                     CGFloat font = [contentitemInfo[@"font"] floatValue];
                     _contentBtnW.constant = [contentitemInfo[@"title"] widthWithFont:FONT(font)]+16;
                 }else{
                     _contentBtnW.constant = [contentitemInfo[@"title"] widthWithFont:FONT(16)]+16;
                 }
             }
             if ([contentitemInfo objectForKey:@"font"]) {
                 CGFloat font = [contentitemInfo[@"font"] floatValue];
                 _contentItem.titleLabel.font = FONT(font);
             }
             if ([contentitemInfo objectForKey:@"color"]) {
                 UIColor * color = contentitemInfo[@"color"];;
                 [_contentItem setTitleColor:color forState:(UIControlStateNormal)];
             }
         }
         if ([contentitemInfo objectForKey:@"AttributedTitle"]) {//富文本
             _contentImageView.hidden = YES;
             _contentItem.hidden = NO;
             [_contentItem setAttributedTitle:contentitemInfo[@"AttributedTitle"] forState:(UIControlStateNormal)];
             if ([contentitemInfo objectForKey:@"btnWidth"]) {
                 _contentBtnW.constant = [contentitemInfo[@"btnWidth"] floatValue];
             }
         }
     }else{
         self.contentItem.hidden = isHidden;
         self.contentImageView.hidden = isHidden;
         self.countLabel.hidden = YES;
     }    
}

- (void)setInitNavigationviewWith:(NSDictionary *)titleInfo
                                 backItem:(NSDictionary *)backItemInfo
                      contentitem:(NSDictionary *)contentitemInfo detailItem:(NSDictionary *)detailItemInfo
                         isHidden:(BOOL)isHidden{
    
    if (titleInfo != nil){
        if ([titleInfo objectForKey:@"title"]){
            _titleLabel.text = titleInfo[@"title"];
        }
        if ([titleInfo objectForKey:@"font"]){
            CGFloat font = [titleInfo[@"font"] integerValue];
            _titleLabel.font = BoldFONT(iPhone4_5?font-1.0:font);
        }
        if ([titleInfo objectForKey:@"color"]){
            _titleLabel.textColor = titleInfo[@"color"];
        }
        
    }else{
        _titleLabel.text = @" ";
    }
    if (backItemInfo != nil){
        if ([backItemInfo objectForKey:@"image"]){
            if([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.0) {
                _backImageView.image = [[UIImage alloc]initWithCGImage:[UIImage imageNamed:backItemInfo[@"image"]].CGImage scale:2.0 orientation:UIImageOrientationUp];
            } else {
                _backImageView.image = [UIImage imageNamed:backItemInfo[@"image"]];
            }
        }
        if ([backItemInfo objectForKey:@"height"]){
            _backItemH.constant = [backItemInfo[@"height"] floatValue];
        }
        if ([backItemInfo objectForKey:@"width"]){
            _backitemW.constant = [backItemInfo[@"width"] floatValue];
        }
        
    }else{
        self.backItem.hidden = isHidden;
        self.backImageView.hidden = isHidden;
    }
    
    if (contentitemInfo != nil){
        if ([contentitemInfo objectForKey:@"image"]){//图片按钮
            _contentImageView.hidden = NO;
            self.contentItem.hidden = NO;
            _contentImageView.image = [UIImage imageNamed:contentitemInfo[@"image"]];
        }
        if ([contentitemInfo objectForKey:@"height"]){
            _contentItemH.constant = [contentitemInfo[@"height"] floatValue];
        }
        if ([contentitemInfo objectForKey:@"width"]){
            _contentitemW.constant = [contentitemInfo[@"width"] floatValue];
        }
        if ([contentitemInfo objectForKey:@"btnWidth"]) {
            _contentBtnW.constant = [contentitemInfo[@"btnWidth"] floatValue];
        }
        if ([contentitemInfo objectForKey:@"title"]){//文字按钮
            _contentImageView.hidden = YES;
            _contentItem.hidden = NO;
            [_contentItem setTitle:contentitemInfo[@"title"] forState:(UIControlStateNormal)];
            if ([contentitemInfo objectForKey:@"btnWidth"]) {
                _contentBtnW.constant = [contentitemInfo[@"btnWidth"] floatValue];
            }else{
                if ([contentitemInfo objectForKey:@"font"]){
                    CGFloat font = [contentitemInfo[@"font"] floatValue];
                    _contentBtnW.constant = [contentitemInfo[@"title"] widthWithFont:FONT(font)]+16;
                }else{
                    _contentBtnW.constant = [contentitemInfo[@"title"] widthWithFont:FONT(16)]+16;
                }
            }
            if ([contentitemInfo objectForKey:@"font"]) {
                CGFloat font = [contentitemInfo[@"font"] floatValue];
                _contentItem.titleLabel.font = FONT(font);
            }
            if ([contentitemInfo objectForKey:@"color"]) {
                UIColor * color = contentitemInfo[@"color"];;
                [_contentItem setTitleColor:color forState:(UIControlStateNormal)];
            }
        }
        if ([contentitemInfo objectForKey:@"AttributedTitle"]) {//富文本
            _contentImageView.hidden = YES;
            _contentItem.hidden = NO;
            [_contentItem setAttributedTitle:contentitemInfo[@"AttributedTitle"] forState:(UIControlStateNormal)];
            if ([contentitemInfo objectForKey:@"btnWidth"]) {
                _contentBtnW.constant = [contentitemInfo[@"btnWidth"] floatValue];
            }
        }
    }else{
        self.contentItem.hidden = isHidden;
        self.contentImageView.hidden = isHidden;
        self.countLabel.hidden = YES;
    }
    
    if (detailItemInfo != nil){
        if ([detailItemInfo objectForKey:@"image"]){//图片按钮
            _detailImageView.hidden = NO;
            self.contentItem.hidden = NO;
            _detailImageView.image = [UIImage imageNamed:detailItemInfo[@"image"]];
        }
        if ([detailItemInfo objectForKey:@"height"]){
            _detailImageH.constant = [contentitemInfo[@"height"] floatValue];
        }
        if ([detailItemInfo objectForKey:@"width"]){
            _detailImageW.constant = [contentitemInfo[@"width"] floatValue];
        }
        if ([detailItemInfo objectForKey:@"btnWidth"]) {
            _detailItem.hidden = NO;
            _detailBtnW.constant = [contentitemInfo[@"btnWidth"] floatValue];
        }
        
        if ([detailItemInfo objectForKey:@"title"]){//文字按钮
            _detailImageView.hidden = YES;
            _detailItem.hidden = NO;
            [_detailItem setTitle:detailItemInfo[@"title"] forState:(UIControlStateNormal)];
            if ([detailItemInfo objectForKey:@"btnWidth"]) {
                _detailBtnW.constant = [contentitemInfo[@"btnWidth"] floatValue];
            }else{
                if ([contentitemInfo objectForKey:@"font"]){
                    CGFloat font = [contentitemInfo[@"font"] floatValue];
                    _detailBtnW.constant = [contentitemInfo[@"title"] widthWithFont:FONT(font)]+16;
                }else{
                    _detailBtnW.constant = [contentitemInfo[@"title"] widthWithFont:FONT(16)]+16;
                }
            }
            if ([detailItemInfo objectForKey:@"font"]) {
                CGFloat font = [detailItemInfo[@"font"] floatValue];
                _detailItem.titleLabel.font = FONT(font);
            }
            if ([detailItemInfo objectForKey:@"color"]) {
                UIColor * color = detailItemInfo[@"color"];;
                [_detailItem setTitleColor:color forState:(UIControlStateNormal)];
            }
        }
        if ([detailItemInfo objectForKey:@"AttributedTitle"]) {//富文本
            _detailImageView.hidden = YES;
            _detailItem.hidden = NO;
            [_detailItem setAttributedTitle:detailItemInfo[@"AttributedTitle"] forState:(UIControlStateNormal)];
//            if ([detailItemInfo objectForKey:@"btnWidth"]) {
//                _contentBtnW.constant = [contentitemInfo[@"btnWidth"] floatValue];
//            }
        }
    }else{
        self.detailItem.hidden = isHidden;
        self.detailImageView.hidden = isHidden;
    }
}

- (void)setCounttitle:(NSString *)counttitle{
    _counttitle = counttitle;
    self.countLabel.hidden = NO;
    if ([counttitle integerValue] == 0) {
        self.countLabel.hidden = YES;
    }else{
        if ([counttitle integerValue] >= 9){
            if ([counttitle integerValue] > 99){
                self.countLabel.text = [NSString stringWithFormat:@"99+"];
                CGFloat tagW = [@"99+" widthWithFont:FONT(10)]+8;
                self.countW.constant = tagW;
                self.countLabel.layer.cornerRadius = tagW/2;
                self.countLabel.clipsToBounds = YES;
            }else{
                self.countLabel.text = counttitle;
                CGFloat tagW = [counttitle widthWithFont:FONT(10)]+10;
                self.countW.constant = tagW;
                self.countLabel.layer.cornerRadius = tagW/2;
                self.countLabel.clipsToBounds = YES;
            }
        }else{
            self.countLabel.text = counttitle;
            CGFloat tagW = [counttitle widthWithFont:FONT(10)]+10;
            self.countW.constant = tagW;
            self.countLabel.layer.cornerRadius = tagW/2;
            self.countLabel.clipsToBounds = YES;
        }
    }
}
- (void)setBackTitleInfo:(NSDictionary *)backTitleInfo{
    _backTitleInfo = backTitleInfo;
    if (backTitleInfo != nil) {
        self.closeBtn.titleLabel.font = FONT(iPhone4_5?14:(iPhone6?15:16));
        self.closeBtn.hidden = NO;
        if ([backTitleInfo objectForKey:@"title"]) {
            [self.closeBtn setTitle:backTitleInfo[@"title"] forState:(UIControlStateNormal)];
        }
        if ([backTitleInfo objectForKey:@"color"]) {
            [self.closeBtn setTitleColor:backTitleInfo[@"color"] forState:(UIControlStateNormal)];
        }
        if ([backTitleInfo objectForKey:@"font"]) {
            self.closeBtn.titleLabel.font = backTitleInfo[@"font"];
        }
    }else{
        self.closeBtn.hidden = YES;
    }
 }
- (void)setContentImage:(NSString *)contentImage{
    _contentImage = contentImage;
    self.contentImageView.image = [UIImage imageNamed:contentImage];
}
- (void)setBackImage:(NSString *)backImage{
    _backImage = backImage;
    self.backImageView.image = [UIImage imageNamed:backImage];
}
- (void)setTitleText:(NSString *)titleText{
    _titleText = titleText;
    self.titleLabel.text = titleText;
}
- (IBAction)webViewClose:(UIButton *)sender {
    if (self.webViewClose) {
        self.webViewClose();
    }
}

- (IBAction)backBtnClick:(UIButton *)sender {
    if (_backItemClick) {
        _backItemClick();
    }
}
- (IBAction)contentBtnClick:(UIButton *)sender {
    if (_contentItemClick) {
        _contentItemClick();
    }
}
- (IBAction)detailItemClick:(id)sender {
    if (_detailItemClick) {
        _detailItemClick();
    }
}

@end
