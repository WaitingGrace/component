//
//  WGBirthdayUserFriendsCollectionViewCell.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2018/11/21.
//  Copyright © 2018年 WG. All rights reserved.
//

#import "WGBirthdayUserFriendsCollectionViewCell.h"
#import "WGBirthdayFriendsItem.h"

@interface WGBirthdayUserFriendsCollectionViewCell ()

@property (nonatomic, strong) IBOutlet UIImageView *moreImageView;
@property (nonatomic, strong) IBOutlet UIImageView *headImageView;
@property (nonatomic, strong) IBOutlet UIView *containerView;
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;

@end

@implementation WGBirthdayUserFriendsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = 21;
    // Initialization code
}

- (void)setFriendsItem:(WGBirthdayFriendsItem *)friendsItem {
    _friendsItem = friendsItem;
    if (friendsItem.isMore) {
        self.containerView.hidden = YES;
        self.moreImageView.hidden = NO;
    } else {
        self.containerView.hidden = NO;
        self.moreImageView.hidden = YES;
        
//        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:friendsItem.imageUrl] placeholderImage:[UIImage imageNamed:@"defaultHeadPicture"]];
        self.nameLabel.text = friendsItem.title;
    }
}

@end
