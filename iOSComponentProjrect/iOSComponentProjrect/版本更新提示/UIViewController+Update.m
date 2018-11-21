//
//  UIViewController+Update.m
//
//  Created by WG on 2017/7/27.
//  Copyright © 2017年 WG. All rights reserved.
//

#import "UIViewController+Update.h"

@implementation UIViewController (Update)


/**
 从appstore获取app更新信息

 @param success 成功返回信息
 */
+ (void)getNewVersionSuccess:(GetNewVersionBlock)success{
    //获取本地软件的版本号
    NSString * localVersion = [[[NSBundle mainBundle]infoDictionary] valueForKey:@"CFBundleShortVersionString"];
    dispatch_queue_t mainQueue =dispatch_get_main_queue();
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    dispatch_async(globalQueue, ^{
        //获取app store 版本号
        NSString *newVersion;
        NSURL *url = [NSURL URLWithString:@"http://itunes.apple.com/cn/lookup?id=1432518361"];
        NSString *jsonResponseString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [jsonResponseString dataUsingEncoding:NSUTF8StringEncoding];
        id json;
        if (data != nil) {
            json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        }
        NSArray *array = json[@"results"];
        NSDictionary * versionDic = [array firstObject];
        newVersion = [versionDic valueForKey:@"version"];
        dispatch_async(mainQueue, ^{
            if ([localVersion isEqualToString:newVersion]) {
                success(NO,localVersion,newVersion);
            }else{
                if ([localVersion compare:newVersion options:NSNumericSearch] == NSOrderedDescending){
                    success(NO,localVersion,newVersion);
                }else{
                    success(YES,localVersion,newVersion);
                }
            }
        });
    });
}
- (void)detectionOfUpdateVersionWith:(BOOL)mandatory hint:(NSString *)hint Version:(NSString *)version{
    @WeakObj(self)
    [UIViewController getNewVersionSuccess:^(BOOL update, NSString *localVersion, NSString *freshVersion) {
        if (update) {
            if (mandatory) {
                [selfWeak versionHintMessage:hint];
            }else{
                [selfWeak versionReminderMessage:hint];
            }
        }
    }];
}
/*! 打开App Store(必须更新的) */
- (void)versionHintMessage:(NSString *)message{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"升级提示"message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"立即更新" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id1432518361?mt=8"]];
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:url options:@{UIApplicationOpenURLOptionsSourceApplicationKey:@YES} completionHandler:^(BOOL success) {
                if (success) {
                    //成功后回调
                }
            }];
        } else {
            [[UIApplication sharedApplication] openURL:url];
        }        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

/*! 应用内打开App Store */
- (void)versionReminderMessage:(NSString *)message{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"升级提示"message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"立即更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        SKStoreProductViewController * storeProductVC= [[SKStoreProductViewController alloc] init];
        storeProductVC.delegate = self;
        NSDictionary*dict = [NSDictionary dictionaryWithObject:@"1432518361" forKey:SKStoreProductParameterITunesItemIdentifier];
        [storeProductVC loadProductWithParameters:dict completionBlock:^(BOOL result,NSError*error) {
            if(result) {
                [self presentViewController:storeProductVC animated:YES completion:nil];
            }
        }];
    }];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"稍后更新" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) { }];
    [alert addAction:action];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}
#pragma mark - SKStoreProductViewController协议方法
- (void)productViewControllerDidFinish:(SKStoreProductViewController*)viewController{
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

@end
