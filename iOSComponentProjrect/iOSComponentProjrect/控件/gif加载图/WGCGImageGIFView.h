//
//  WGCGImageGIFView.h
//  LoadGIF
//
//  Created by 帅棋 on 2018/11/21.
//  Copyright © 2018年 WG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WGCGImageGIFView : UIView

@property (nonatomic,assign,readonly) BOOL isAnimating;

-(instancetype)initWithGIFPath:(NSString *)path;

-(void)startGIF;
-(void)stopGIF;

@end
