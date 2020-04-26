//
//  UIColor+WGPickupColor.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2020/4/26.
//  Copyright © 2020 WG. All rights reserved.
//

#import "UIColor+WGPickupColor.h"


@implementation UIColor (WGPickupColor)
//获取图片特定区域的主色调

+ (UIColor*)mostColor:(UIImage*)image inRect:(CGRect)rect {

    //首先缩放一下图片变成W375、H113大小的图片
    UIImage * newImage = [self scaleToSize:image size:CGSizeMake(375.0,113.0)];
    
    if(newImage) {
     
        //截取左下角，大小为rect方块的图片
     
        UIImage * smallImage = [self imageFromImage:newImage inRect:rect];
     
        if(smallImage) {
     
            UIColor * color = [self mostColor:smallImage];
     
            return color;
     
        }
    
    }
    
    return nil;
}

/**
 *  缩放图片
 *  @paramimg  image
 *  @paramsize 缩放后的大小
 *  @returnimage
 */
+ (UIImage*)scaleToSize:(UIImage*)img size:(CGSize)size{

    // 创建一个bitmap的context
    CGFloat width =CGImageGetWidth(img.CGImage);
    CGFloat height =CGImageGetHeight(img.CGImage);
    CGFloat max = width >= height ? width:height;
    CGSize originSize;

    if(max <= 0) {

        return nil;

    }

    if(width >= height) {

        originSize =CGSizeMake(size.width, (size.width* height)/width);

    }else{

        originSize =CGSizeMake((size.height* width)/height, size.height);

    }

    // 并把它设置成为当前正在使用的context

    UIGraphicsBeginImageContext(size);

    // 绘制改变大小的图片

    [img drawInRect:CGRectMake((size.width- originSize.width)/2, (size.height- originSize.height)/2, originSize.width, originSize.height)];

    // 从当前context中创建一个改变大小后的图片

    UIImage * scaledImage = UIGraphicsGetImageFromCurrentImageContext();

    // 使当前的context出堆栈

    UIGraphicsEndImageContext();

    // 返回新的改变大小后的图片

    return scaledImage;
}

// 裁剪图片
+ (UIImage*)imageFromImage:(UIImage*)image inRect:(CGRect)rect {

    CGImageRef sourceImageRef = [image CGImage];

    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
 
    UIImage * newImage = [UIImage imageWithCGImage:newImageRef];

    CGImageRelease(newImageRef);

    return newImage;
}

//根据图片获取图片的主色调
+ (UIColor*)mostColor:(UIImage*)image{
 
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1

    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else

    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif

    //第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大

    CGSize thumbSize = CGSizeMake(image.size.width/2, image.size.height/2);

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
 
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 thumbSize.width,

                                                 thumbSize.height,

                                                 8,//bits per component

                                                 thumbSize.width*4,

                                                 colorSpace,

                                                 bitmapInfo);

    CGRect drawRect =CGRectMake(0,0, thumbSize.width, thumbSize.height);

    CGContextDrawImage(context, drawRect, image.CGImage);
 
    CGColorSpaceRelease(colorSpace);

    //第二步 取每个点的像素值

    unsigned char * data = CGBitmapContextGetData(context);

    if(data == NULL)return nil;

    NSCountedSet * cls = [NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];

    for(int x = 0; x<thumbSize.width; x++ ){

        for(int y = 0; y<thumbSize.height; y++){

            int offset = 4*(x*y);

            int red = data[offset];

            int green = data[offset+1];

            int blue = data[offset+2];

            int alpha = data[offset+3];

            if(alpha > 0) {//去除透明
    
            }
        
            if(red==255&&green==255&&blue==255) {//去除白色
            }else{
                NSArray*clr=@[@(red),@(green),@(blue),@(alpha)];
                [cls addObject:clr];
            }
        }

    }
    CGContextRelease(context);
        
    //第三步 找到出现次数最多的那个颜色
        
    NSEnumerator * enumerator = [cls objectEnumerator];

    NSArray * curColor = nil;
        
    NSArray * MaxColor = nil;
        
    NSUInteger MaxCount = 0;
        
    while ((curColor = [enumerator nextObject]) != nil) {
    
        NSUInteger tmpCount = [cls countForObject:curColor];
                
        if( tmpCount < MaxCount )continue;
           
        MaxCount = tmpCount;
               
        MaxColor = curColor;
       
    }
        
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
    
}
            
@end
