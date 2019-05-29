//
//  WGAFttpTool.h
//  IMHYS
//
//  Created by 帅棋 on 2018/6/5.
//  Copyright © 2018年 xinyihua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface AFHttpClient : AFHTTPSessionManager
+ (instancetype)sharedClient;
@end

typedef void (^HttpSuccessBlock) (id responseObject);
typedef void (^HttpFailureBlock) (NSError *error);
typedef void (^HttpFaultBlock) (id error);
typedef void (^HttpProgressBlock) (NSProgress * progress);
typedef void (^TheNetworkStatusBlock) (NSUInteger status);

@interface WGAFttpTool : NSObject
/**
 AFN post请求 -- 返回对象数据
 
 @param path URL地址
 @param params 请求参数 (NSDictionary)
 @param success 请求成功返回值（NSArray or NSDictionary）
 @param failure 请求失败值 (NSError)
 */
+ (void)POSTWithPath:(NSString *)path
              params:(NSDictionary *)params
             success:(HttpSuccessBlock)success
             failure:(HttpFailureBlock)failure;


/**
 AFN post请求 -- 返回xml数据
 
 @param path URL地址
 @param params 请求参数 (NSDictionary)
 @param success 请求成功返回值（xml）
 @param failure 请求失败值 (NSError)
 */
+ (void)postWithPath:(NSString *)path
              params:(NSDictionary *)params
             success:(HttpSuccessBlock)success
             failure:(HttpFailureBlock)failure;

/**
 AFN post请求 -- GCD队列请求

 @param type 请求类型-- POST GET
 @param urls URL地址-- 数组
 @param paras 请求参数 --数组
 @param success 请求成功返回值
 @param failure 请求失败值
 */
+ (void)runDispatchTestWithType:(NSString *)type
                          Paths:(NSArray *)urls
                           paras:(NSArray *)paras
                         success:(HttpSuccessBlock)success
                         failure:(HttpFaultBlock)failure;

/**
 AFN 不做处理的get请求
 
 @param path URL地址
 @param params 请求参数 (NSDictionary)
 @param success 请求成功返回值（NSArray or NSDictionary）
 @param failure 请求失败值 (NSError)
 */
+ (void)getCommentWithPath:(NSString *)path
                    params:(NSDictionary *)params
                   success:(HttpSuccessBlock)success
                   failure:(HttpFailureBlock)failure;

/**
 AFN get请求返回text／html
 
 @param path URL地址
 @param params 请求参数 (NSDictionary)
 @param success 请求成功返回值（NSArray or NSDictionary）
 @param failure 请求失败值 (NSError)
 */
+ (void)GETWithPath:(NSString *)path
             params:(NSDictionary *)params
            success:(HttpSuccessBlock)success
            failure:(HttpFailureBlock)failure;

/**
 取消网络请求
 */
+ (void)cancelAllRequest;

/**
 网络状态

 @param state 状态
 */
+ (void)NetworkMonitoringStatus:(TheNetworkStatusBlock)state;


#pragma mark ==== 没有提示框的AFN请求
+ (void)POSTNoPromptWithPath:(NSString *)path
                     params:(NSDictionary *)params
                    success:(HttpSuccessBlock)success
                    failure:(HttpFailureBlock)failure;
+ (void)GETNoPromptWithPath:(NSString *)path
                    params:(NSDictionary *)params
                   success:(HttpSuccessBlock)success
                   failure:(HttpFailureBlock)failure;


@end
