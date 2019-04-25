//
//  WGEraseToolbar.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2018/11/30.
//  Copyright © 2018年 WG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import <objc/runtime.h>

@interface WGEraseToolbar : NSObject

+ (void)removeInputAccessoryViewFromWKWebView:(WKWebView *)webView;

@end
