//
//  WGCADisplayLineImage.h
//  LoadGIF
//
//  Created by 帅棋 on 2018/11/21.
//  Copyright © 2018年 WG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WGCADisplayLineImage : UIImage

@property (nonatomic,readonly) NSTimeInterval *frameDurations;
@property (nonatomic,readonly) NSUInteger loopCount;
@property (nonatomic,readonly) NSTimeInterval totalDuratoin;

-(UIImage *)getFrameWithIndex:(NSUInteger)idx;

@end
