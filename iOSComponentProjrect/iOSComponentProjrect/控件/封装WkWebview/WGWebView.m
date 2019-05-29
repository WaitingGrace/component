//
//  WGWebView.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/13.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGWebView.h"
#import "Config.h"
#import "WGEraseToolbar.h"


@interface WGWebView ()<WKNavigationDelegate ,WKUIDelegate>
@property (nonatomic ,strong) WKWebView * webView;
@property (nonatomic ,strong) UIProgressView * progressView;
@property (nonatomic ,strong) WKWebViewConfiguration *webConfig;
@property (nonatomic ,strong) WKUserScript *script;

@end
@implementation WGWebView

- (void)setLink:(NSString *)link{
    _link = link;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:link]]];
}
#pragma mark ---- 懒加载、初始化
/*! ***** 进度条  */
- (UIProgressView *)progressView{
    if (!_progressView){
        UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
        progressView.backgroundColor = [UIColor blueColor];
        progressView.tintColor = BASEColor;
        progressView.trackTintColor = BackColor;
        progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
        [self addSubview:progressView];
        self.progressView = progressView;
    }
    return _progressView;
}
- (WKWebViewConfiguration *)webConfig{
    if (!_webConfig) {
        _webConfig = [WKWebViewConfiguration new];
        WKUserContentController *userController = [WKUserContentController new];
        NSString *js = @" $('meta[name=description]').remove(); $('head').append( '<meta name=\"viewport\" content=\"width=device-width, initial-scale=1,user-scalable=no\">' );";
        WKUserScript *script = [[WKUserScript alloc] initWithSource:js injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];
        [userController addUserScript:script];
        _webConfig.userContentController = userController;
        
    }
    return _webConfig;
}

- (WKWebView *)webView{
    if (_webView == nil) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:self.webConfig];
        _webView.navigationDelegate = self;
        _webView.backgroundColor = [UIColor clearColor];
        _webView.opaque = NO;
        _webView.UIDelegate = self;
        _webView.allowsBackForwardNavigationGestures = YES;
        for (UIView *subView in [_webView subviews]){
            if ([subView isKindOfClass:[UIScrollView class]]){
                [(UIScrollView *)subView setShowsVerticalScrollIndicator:NO];
            }
        }
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
        
    }
    return _webView;
}

/**
 初始化
 */
- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setInitView];
    }
    return self;
}
/*! 试图设置 */
- (void)setInitView{
    [WGEraseToolbar removeInputAccessoryViewFromWKWebView:self.webView];
    [self addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(1);
        make.bottom.mas_equalTo(0);
    }];
}

#pragma mark 计算webView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        if (object == self.webView) {
            self.progressView.progress = self.webView.estimatedProgress;
            if (self.progressView.progress == 1) {
                __weak typeof (self)weakSelf = self;
                [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                    weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
                } completion:^(BOOL finished) {
                    weakSelf.progressView.hidden = YES;
                }];
            }
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }else if ([keyPath isEqualToString:@"title"]) {
        if (object == self.webView) {
            if (self.titleBlock) {
                self.titleBlock(self.webView.title);
            }
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    } else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark ----
#pragma mark ---- WKNavigationDelegate
//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    self.progressView.hidden = NO;
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    [self bringSubviewToFront:self.progressView];
}
//有内容返回
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{

    
}
//加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSString *js = @"function imgAutoFit() { \
    var imgs = document.getElementsByTagName('img'); \
    for (var i = 0; i < imgs.length; ++i) {\
    var img = imgs[i];   \
    img.style.maxWidth = %f;   \
    } \
    }";
    js = [NSString stringWithFormat:js, ScreenWidth-40];
    [webView evaluateJavaScript:js completionHandler:nil];
    [webView evaluateJavaScript:@"imgAutoFit();"completionHandler:nil];
    //    webview的背景
    [webView evaluateJavaScript:[NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.background='#%@'",@"FFFFFF"] completionHandler:nil];
    
    NSString *injectionJSString = @"var script = document.createElement('meta');"
    "script.name = 'viewport';"
    "script.content=\"width=device-width, initial-scale=1.0,maximum-scale=1.0, minimum-scale=1.0, user-scalable=no\";"
    "document.getElementsByTagName('head')[0].appendChild(script);";
    [webView evaluateJavaScript:injectionJSString completionHandler:nil];
    
    //清除WK缓存，否则H5界面跟新，这边不会更新
    if ([UIDevice currentDevice].systemVersion.floatValue>=9.0) {
        //    然而我们等到了iOS9！！！没错！WKWebView的缓存清除API出来了！代码如下：这是删除所有缓存和cookie的
        NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        //// Date from
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        //// Execute
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        }];
    }else{
        //iOS8清除缓存
        NSString * libraryPath =  NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
        NSString * cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:nil];
    }
    
    //    //获取网页的一个值
    //    @WeakObj(self)
    //    NSString *doc06 =@"document.getElementById('title').innerText";
    //    [webView evaluateJavaScript:doc06 completionHandler:^(id _Nullable htmlStr,  NSError * _Nullable error) {
    //         if (error) {
    //              NSLog(@"JSError:%@",error);
    //          }
    //          NSLog(@"获取网页的一个值--:%@",htmlStr);
    //    }] ;
}

//加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    ERRORWith(@"页面加载失败")
}

//! WKWeView在每次加载请求前会调用此方法来确认是否进行请求跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if ([navigationAction.request.URL.scheme caseInsensitiveCompare:@"自定义参数"] == NSOrderedSame) {

        decisionHandler(WKNavigationActionPolicyCancel);
    }else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}
//
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
}
//
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark ----
#pragma mark ---- WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    completionHandler();
}
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    completionHandler(NO);
}
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    completionHandler(@" ");
}




- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
    self.webView.UIDelegate = nil;
    self.webView.navigationDelegate = nil;
}


@end
