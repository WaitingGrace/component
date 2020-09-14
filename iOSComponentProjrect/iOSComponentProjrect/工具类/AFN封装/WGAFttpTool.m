//
//  WGAFttpTool.m
//  IMHYS
//
//  Created by 帅棋 on 2018/6/5.
//  Copyright © 2018年 xinyihua. All rights reserved.
//

#import "WGAFttpTool.h"
#import "NSString+WGExpand.h"
#import "MBProgressHUD+WG.h"

@implementation AFHttpClient
+ (instancetype)sharedClient {
    static AFHttpClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFHttpClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/html",@"text/javascript",@"application/x-javascript",@"text/plain",@"image/png", nil];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    return _sharedClient;
}

@end
@implementation WGAFttpTool

#pragma mark - AFN网络请求
#pragma mark POST请求 返回text/html数据
+ (void)POSTWithPath:(NSString *)path
              params:(NSDictionary *)params
             success:(HttpSuccessBlock)success
             failure:(HttpFailureBlock)failure {
    AFHttpClient * manager = [AFHttpClient sharedClient];
    NSSet *set = [NSSet setWithObject:@"text/html"];
    [manager.responseSerializer setAcceptableContentTypes:set];
    [manager POST:path parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success == nil) return;
        NSHTTPURLResponse * response = (NSHTTPURLResponse *)task.response;
        if (response.statusCode == 200){
            NSDictionary * dataDic = (NSDictionary *)responseObject;
            if (dataDic && success) {
                success(dataDic);
            }

        }else{
            [MBProgressHUD showError:[NSString stringWithFormat:@"%ld",(long)response.statusCode]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (![NSString stringIsNULL:[self returnErrorWithError:error].localizedDescription]) {
            ERRORWith([self returnErrorWithError:error].localizedDescription)
        }
        if (failure && error) {
            failure([self returnErrorWithError:error]);
        }
    }];
}

#pragma mark - AFN网络请求
#pragma mark POST请求 返回xml数据
+ (void)postWithPath:(NSString *)path
              params:(NSDictionary *)params
             success:(HttpSuccessBlock)success
             failure:(HttpFailureBlock)failure {
    AFHttpClient * manager = [AFHttpClient sharedClient];
    manager.requestSerializer.timeoutInterval = 30;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:path parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString * result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if (success && result) {
            success(result);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (![NSString stringIsNULL:[self returnErrorWithError:error].localizedDescription]) {
            ERRORWith([self returnErrorWithError:error].localizedDescription)
        }
        if (failure && error) {
            failure([self returnErrorWithError:error]);
        }
    }];
}
#pragma mark -
#pragma mark - 取消网络请求
+ (void)cancelAllRequest {
    [[AFHttpClient sharedClient].operationQueue cancelAllOperations];
}

#pragma mark -
#pragma mark -- GCD队列请求
/*! 生成请求POST */
+ (NSURLSessionTask *)postTaskWithUrl:(NSString *)url  parameters:(NSDictionary *)parameters completion:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionBlock {
    NSError* error = NULL;
    NSMutableURLRequest * request  = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:parameters error:&error];
    AFHttpClient * manager = [[AFHttpClient alloc] init];
    NSSet *set = [NSSet setWithObject:@"text/html"];
    [manager.responseSerializer setAcceptableContentTypes:set];
    NSURLSessionTask * postTask = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:completionBlock];
    return postTask;
}
/*! 生成请求GET */
+ (NSURLSessionTask *)getTaskWithUrl:(NSString *)url completion:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionBlock {
    NSError* error = NULL;
    NSMutableURLRequest * request  = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:url parameters:nil error:&error];
    AFHttpClient * manager = [[AFHttpClient alloc] init];
    NSSet *set = [NSSet setWithObject:@"text/html"];
    [manager.responseSerializer setAcceptableContentTypes:set];
    NSURLSessionTask * getTask = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:completionBlock];
    return getTask;
}

+ (void)runDispatchTestWithType:(NSString *)type
                          Paths:(NSArray *)urls
                          paras:(NSArray *)paras
                        success:(HttpSuccessBlock)success
                        failure:(HttpFaultBlock)failure{
    // 准备保存结果的数组
    NSMutableArray * result = [NSMutableArray array];
    NSMutableArray * errors = [NSMutableArray array];
    for (int i = 0; i < urls.count; i++) {
        [result addObject:[NSNull null]];
        [errors addObject:[NSNull null]];
    }

    dispatch_group_t group = dispatch_group_create();
    for (NSInteger i = 0; i < urls.count; i++) {
        dispatch_group_enter(group);
        NSDictionary * para = paras[i];
        if ([type isEqualToString:@"POST"]) {
            NSURLSessionTask * task = [self postTaskWithUrl:urls[i] parameters:para completion:^(NSURLResponse *response, id responseObject, NSError *error) {
                if (error) {
                    @synchronized (errors) {
                        errors[i] = [self returnErrorWithError:error];
                    }
                    dispatch_group_leave(group);
                } else {
                    @synchronized (result) {
                        result[i] = responseObject;
                    }
                    dispatch_group_leave(group);
                }
            }];
            [task resume];
        }
        if ([type isEqualToString:@"GET"]) {
            NSURLSessionTask * task = [self getTaskWithUrl:urls[i] completion:^(NSURLResponse *response, id responseObject, NSError *error) {
                if (error) {
                    @synchronized (errors) {
                        errors[i] = error;
                    }
                    dispatch_group_leave(group);
                } else {
                    @synchronized (result) {
                        result[i] = responseObject;
                    }
                    dispatch_group_leave(group);
                }
            }];
            [task resume];
        }
        
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (failure && errors) {
            failure(errors);
        }
        if (success && result) {
            success(result);
        }

    });
}

#pragma mark== GET普通请求
+ (void)getCommentWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure{
    AFHttpClient *manager = [AFHttpClient sharedClient];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    [manager GET:path parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse * response = (NSHTTPURLResponse *)task.response;
        if (response.statusCode == 200){
            if (success ) {
                success(responseObject);
            }

        }else{
            [MBProgressHUD showError:[NSString stringWithFormat:@"%ld",(long)response.statusCode]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (![NSString stringIsNULL:[self returnErrorWithError:error].localizedDescription]) {
            ERRORWith([self returnErrorWithError:error].localizedDescription)
        }
        if (failure) {
            failure([self returnErrorWithError:error]);
        }
    }];

}

#pragma mark === GET请求 返回html
+ (void)GETWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure{
    AFHttpClient *manager = [AFHttpClient sharedClient];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:path parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        NSHTTPURLResponse * response = (NSHTTPURLResponse *)task.response;
        if (response.statusCode == 200){
            if (success ) {
                success(responseObject);
            }

        }else{
            [MBProgressHUD showError:[NSString stringWithFormat:@"%ld",(long)response.statusCode]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (![NSString stringIsNULL:[self returnErrorWithError:error].localizedDescription]) {
            ERRORWith([self returnErrorWithError:error].localizedDescription)
        }
        if (failure) {
            failure([self returnErrorWithError:error]);
        }
    }];
}

#pragma mark - AFN网络请求,没有提示框
#pragma mark POST请求
+ (void)POSTNoPromptWithPath:(NSString *)path
                     params:(NSDictionary *)params
                    success:(HttpSuccessBlock)success
                    failure:(HttpFailureBlock)failure {
    AFHttpClient * manager = [AFHttpClient sharedClient];
    NSSet *set = [NSSet setWithObject:@"text/html"];
    [manager.responseSerializer setAcceptableContentTypes:set];
    [manager POST:path parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)  {
        if (success == nil) return;
        NSHTTPURLResponse * response = (NSHTTPURLResponse *)task.response;
        if (response.statusCode == 200){
            NSDictionary * dataDic = (NSDictionary *)responseObject;
            if (dataDic && success) {
                success(dataDic);
            }
        }else{
            [MBProgressHUD showError:[NSString stringWithFormat:@"%ld",(long)response.statusCode]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (![NSString stringIsNULL:[self returnErrorWithError:error].localizedDescription]) {
            ERRORWith([self returnErrorWithError:error].localizedDescription)
        }
        if (failure && error) {
            failure([self returnErrorWithError:error]);
        }
    }];
}
#pragma mark GET请求
+ (void)GETNoPromptWithPath:(NSString *)path
                    params:(NSDictionary *)params
                   success:(HttpSuccessBlock)success
                   failure:(HttpFailureBlock)failure{
    AFHttpClient *manager = [AFHttpClient sharedClient];
    NSSet *set = [NSSet setWithObject:@"text/html"];
    [manager.responseSerializer setAcceptableContentTypes:set];
    [manager GET:path parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        NSHTTPURLResponse * response = (NSHTTPURLResponse *)task.response;
        if (response.statusCode == 200){
            if (success ) {
                success(responseObject);
            }
        }else{
            [MBProgressHUD showError:[NSString stringWithFormat:@"%ld",(long)response.statusCode]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (![NSString stringIsNULL:[self returnErrorWithError:error].localizedDescription]) {
            ERRORWith([self returnErrorWithError:error].localizedDescription)
        }
        if (failure) {
            failure([self returnErrorWithError:error]);
        }
    }];
}


#pragma mark -
#pragma mark - 网络状态
+ (void)NetworkMonitoringStatus:(TheNetworkStatusBlock)state{
    //1.创建网络状态监测管理者
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    //2.开启监听
    [manger startMonitoring];
    //3.监听网络状态的改变
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        state(status);
        switch (status) {
            case AFNetworkReachabilityStatusUnknown://未知 -1
                INFOWith(@"网络未知")
                break;
            case AFNetworkReachabilityStatusNotReachable://没有网络 0
                INFOWith(@"网络似乎断开了")
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN://移动网络 1
                INFOWith(@"当前是移动网络，请注意流量使用")
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi://WIFI 2
                INFOWith(@"当前是WI-FI")
                break;
            default:
                break;
        }
    }];
}



/**
 error转换中文

 @param error errpr
 @return 结果
 */
+ (NSError *)returnErrorWithError:(NSError *)error{
    NSString *errorMesg = @"";
    switch (error.code) {
        case -1://NSURLErrorUnknown
            errorMesg = @"未知错误";
            break;
        case -999://NSURLErrorCancelled
            errorMesg = @"无效的URL地址";
            break;
        case -1000://NSURLErrorBadURL
            errorMesg = @"无效的URL地址";
            break;
        case -1001://NSURLErrorTimedOut
            errorMesg = @"网络不给力，请稍后再试";
            break;
        case -1002://NSURLErrorUnsupportedURL
            errorMesg = @"不支持的URL地址";
            break;
        case -1003://NSURLErrorCannotFindHost
            errorMesg = @"找不到服务器";
            break;
        case -1004://NSURLErrorCannotConnectToHost
            errorMesg = @"连接不上服务器";
            break;
        case -1103://NSURLErrorDataLengthExceedsMaximum
            errorMesg = @"请求数据长度超出最大限度";
            break;
        case -1005://NSURLErrorNetworkConnectionLost
            errorMesg = @"网络连接异常";
            break;
        case -1006://NSURLErrorDNSLookupFailed
            errorMesg = @"DNS查询失败";
            break;
        case -1007://NSURLErrorHTTPTooManyRedirects
            errorMesg = @"HTTP请求重定向";
            break;
        case -1008://NSURLErrorResourceUnavailable
            errorMesg = @"资源不可用";
            break;
        case -1009://NSURLErrorNotConnectedToInternet
            errorMesg = @"无网络连接";
            break;
        case -1010://NSURLErrorRedirectToNonExistentLocation
            errorMesg = @"重定向到不存在的位置";
            break;
        case -1011://NSURLErrorBadServerResponse
            errorMesg = @"服务器响应异常";
            break;
        case -1012://NSURLErrorUserCancelledAuthentication
            errorMesg = @"用户取消授权";
            break;
        case -1013://NSURLErrorUserAuthenticationRequired
            errorMesg = @"需要用户授权";
            break;
        case -1014://NSURLErrorZeroByteResource
            errorMesg = @"零字节资源";
            break;
        case -1015://NSURLErrorCannotDecodeRawData
            errorMesg = @"无法解码原始数据";
            break;
        case -1016://NSURLErrorCannotDecodeContentData
            errorMesg = @"无法解码内容数据";
            break;
        case -1017://NSURLErrorCannotParseResponse
            errorMesg = @"无法解析响应";
            break;
        case -1018://NSURLErrorInternationalRoamingOff
            errorMesg = @"国际漫游关闭";
            break;
        case -1019://NSURLErrorCallIsActive
            errorMesg = @"被叫激活";
            break;
        case -1020://NSURLErrorDataNotAllowed
            errorMesg = @"数据不被允许";
            break;
        case -1021://NSURLErrorRequestBodyStreamExhausted
            errorMesg = @"请求体";
            break;
        case -1100://NSURLErrorFileDoesNotExist
            errorMesg = @"文件不存在";
            break;
        case -1101://NSURLErrorFileIsDirectory
            errorMesg = @"文件是个目录";
            break;
        case -1102://NSURLErrorNoPermissionsToReadFile
            errorMesg = @"无读取文件权限";
            break;
        case -1200://NSURLErrorSecureConnectionFailed
            errorMesg = @"安全连接失败";
            break;
        case -1201://NSURLErrorServerCertificateHasBadDate
            errorMesg = @"服务器证书失效";
            break;
        case -1202://NSURLErrorServerCertificateUntrusted
            errorMesg = @"不被信任的服务器证书";
            break;
        case -1203://NSURLErrorServerCertificateHasUnknownRoot
            errorMesg = @"未知Root的服务器证书";
            break;
        case -1204://NSURLErrorServerCertificateNotYetValid
            errorMesg = @"服务器证书未生效";
            break;
        case -1205://NSURLErrorClientCertificateRejected
            errorMesg = @"客户端证书被拒";
            break;
        case -1206://NSURLErrorClientCertificateRequired
            errorMesg = @"需要客户端证书";
            break;
        case -2000://NSURLErrorCannotLoadFromNetwork
            errorMesg = @"无法从网络获取";
            break;
        case -3000://NSURLErrorCannotCreateFile
            errorMesg = @"无法创建文件";
            break;
        case -3001:// NSURLErrorCannotOpenFile
            errorMesg = @"无法打开文件";
            break;
        case -3002://NSURLErrorCannotCloseFile
            errorMesg = @"无法关闭文件";
            break;
        case -3003://NSURLErrorCannotWriteToFile
            errorMesg = @"无法写入文件";
            break;
        case -3004://NSURLErrorCannotRemoveFile
            errorMesg = @"无法删除文件";
            break;
        case -3005://NSURLErrorCannotMoveFile
            errorMesg = @"无法移动文件";
            break;
        case -3006://NSURLErrorDownloadDecodingFailedMidStream
            errorMesg = @"下载解码数据失败";
            break;
        case -3007://NSURLErrorDownloadDecodingFailedToComplete
            errorMesg = @"下载解码数据失败";
            break;
    }
    // 重点： 根据错误的code码，替换AFN传入的error 中NSLocalizedDescriptionKey键值对，重新组装返回
    NSMutableDictionary *errorInfo = [[NSMutableDictionary alloc]initWithDictionary:error.userInfo];
    [errorInfo setObject:errorMesg forKey:NSLocalizedDescriptionKey];
    NSError *newError = [[NSError alloc] initWithDomain:NSCocoaErrorDomain code:4 userInfo:errorInfo];
    return newError;
}
@end
