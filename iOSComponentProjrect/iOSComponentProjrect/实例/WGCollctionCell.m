//
//  CollctionCell.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/28.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGCollctionCell.h"
#import "Config.h"
#import "NSString+WGFrame.h"

@interface WGCollctionCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *desc;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstaint;
@end
@implementation WGCollctionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setModel:(ShopModel *)model{
    self.titleLabel.text = model.title;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.icon_url] placeholderImage:[UIImage imageNamed:@"tear.PNG"]];
    CGFloat width = self.frame.size.width-16;
    self.desc.text = model.desc;
    self.heightConstaint.constant = [self.desc.text heightWithFont:[UIFont systemFontOfSize:14] withinWidth:width];
}
@end
