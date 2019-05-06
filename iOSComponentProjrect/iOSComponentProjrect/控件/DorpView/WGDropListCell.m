//
//  WGDropListCell.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/6.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGDropListCell.h"



@interface WGDropListCell ()
@property (strong, nonatomic) UILabel *contentLabel;

@end
@implementation WGDropListCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentLabel = [[UILabel alloc]initWithFrame:self.contentView.frame];
        self.contentLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:self.contentLabel];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    frame.size.width = ScreenWidth/5;
    [super setFrame:frame];
}
- (void)setContentStr:(NSString *)contentStr{
    _contentStr = contentStr;
    self.contentLabel.text = contentStr;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
