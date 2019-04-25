//
//  WGTagButton.h
//
//  Created by 帅棋 on 2019/3/27.
//  Copyright © 2019 WG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class WGTag;
@interface WGTagButton : UIButton
+ (nonnull instancetype)buttonWithTag: (nonnull WGTag *)tag;

@end

NS_ASSUME_NONNULL_END
