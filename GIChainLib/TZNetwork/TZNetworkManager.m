//
//  ZLNetworkManager.h
//  GIChainLib
//
//  Created by ZT on 2018/3/21.
//  Copyright © 2018年 ChuangShiZhiLian. All rights reserved.
//

#import "TZNetworkManager.h"
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>

//网络请求超时时间
#define TimeOutInterval 10.0f

static TZNetworkManager *_defaultNetworkManager;

@implementation TZNetworkManager

+ (TZNetworkManager *)sharedInstance
{
    static dispatch_once_t onceDispathToken;
    
    dispatch_once(&onceDispathToken, ^{
        
        _defaultNetworkManager = [[TZNetworkManager alloc] init];
        
    });
    
    return _defaultNetworkManager;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        //开启状态栏的 NetworkActivityIndicator
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        
        _taskQueue = [[NSMutableDictionary alloc] initWithCapacity:0];
        
    }
    return self;
}

- (AFHTTPSessionManager *)sessionManager
{
    
    if (!_sessionManager) {
        
        AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
        
        [sessionManager.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
        
        //是否存储cookies
        [sessionManager.requestSerializer setHTTPShouldHandleCookies:YES];
        
        //超时时间
        sessionManager.requestSerializer.timeoutInterval = TimeOutInterval;
        
        //设置证书模式
        sessionManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        //        NSString * cerPath = [[NSBundle mainBundle] pathForResource:@"xxx" ofType:@"cer"];
        //        NSData * cerData = [NSData dataWithContentsOfFile:cerPath];
        //        sessionManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:[[NSSet alloc] initWithObjects:cerData, nil]];
        
        // 客户端是否信任非法证书
        sessionManager.securityPolicy.allowInvalidCertificates = YES;
        // 是否在证书域字段中验证域名
        [sessionManager.securityPolicy setValidatesDomainName:NO];
        
        [self setupSessionManager:sessionManager];
        
        _sessionManager = sessionManager;
    }
    
    return _sessionManager;
}


//设置请求cookies
+ (NSString *)requestCookies{
    
    // 用于存放新的cookie字符串
    NSMutableString *cookieValue = [NSMutableString stringWithFormat:@""];
    //获取现有cookie
    NSMutableDictionary *cookieDic = [NSMutableDictionary dictionary];
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
        [cookieDic setObject:cookie.value forKey:cookie.name];
    }
    
    //遍历现有cookie
    for (NSString *key in cookieDic) {
        
        NSString *appendString = @"";
        
        BOOL exist = NO;
        
        //遍历新增的附加cookie
        for (NSString *addkey in [self additionalCookies].allKeys) {
            
            if ([key isEqualToString:addkey]) {
                
                exist = YES;
                break;
            }
        }
        //现有cookie中与新增的key重复的丢弃，不重复的加入新cookie字符串中
        if (!exist) {
            
            appendString = [NSString stringWithFormat:@"%@=%@;", key, [cookieDic valueForKey:key]];
            [cookieValue appendString:appendString];
        }
    }
    
    //将所有新增的cookie加入字符串
    for (NSString *addkey in [self additionalCookies].allKeys) {
        
        [cookieValue appendString:[NSString stringWithFormat:@"%@=%@;", addkey, [[self additionalCookies] valueForKey:addkey]]];
    }

    return cookieValue;
}


+ (TZNetworkTask *)createRequestWithMethod:(NSString *)method url:(NSString *)url param:(NSDictionary *)paramDict cache:(BOOL)needCache delegate:(id<TZNetworkManagerProtocol>)delegate{
    
    AFHTTPSessionManager *sessionManager = [TZNetworkManager sharedInstance].sessionManager;
    ///配置cookie
    [sessionManager.requestSerializer setValue:[self requestCookies] forHTTPHeaderField:@"Cookie"];
    
    //创建NSMutableURLRequest
    NSMutableURLRequest * request;
    
    //根据请求方法创建request
    if ([method isEqualToString:@"GET"]) {
        
        request = [sessionManager.requestSerializer requestWithMethod:method URLString:url parameters:paramDict error:nil];
        
    }else if([method isEqualToString:@"POST"]){
        
        request = [sessionManager.requestSerializer multipartFormRequestWithMethod:method URLString:url parameters:paramDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
        } error:nil];
    }
    
    //创建任务对象
    TZNetworkTask *networkTask = [self instanceOfNetworkTask];
    networkTask.requestUrl = url;
    networkTask.requestParam = paramDict;
    networkTask.delegate = delegate;
    //创建NSURLSessionDataTask
    networkTask.sessionTask = [sessionManager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        BOOL success = NO;
        
        id result = [self parseResponse:response result:responseObject error:error success:&success];
        
        [networkTask requestCompletionHandler:result success:success error:error];
    }];
    
    return networkTask;
}


//根据url从queue中取出task
+ (TZNetworkTask *)getTaskWithUrl:(NSString *)url{
    
    for (NSString * key in [[TZNetworkManager sharedInstance].taskQueue allKeys]) {
        
        TZNetworkTask * task = [[TZNetworkManager sharedInstance].taskQueue objectForKey:key];
        
        if ([task.requestUrl isEqual:url]) {
            
            return task;
        }
    }
    
    return nil;
}

//取消task
+ (void)cancelTask:(TZNetworkTask *)task
{
    [task cancel];
}

//根据url取消task
+ (void)cancelTaskWithUrl:(NSString *)url
{
    for (NSString *key in [[TZNetworkManager sharedInstance].taskQueue allKeys]) {
        
        TZNetworkTask *task = [[TZNetworkManager sharedInstance].taskQueue objectForKey:key];
        
        if ([task.requestUrl isEqual:url]) {
            
            [task cancel];
        }
    }
}

//取消queue中所有的task
+ (void)cancelAllTaskInQueue
{
    for (NSString *key in [[TZNetworkManager sharedInstance].taskQueue allKeys]) {
        
        TZNetworkTask *task = [[TZNetworkManager sharedInstance].taskQueue objectForKey:key];
        
        //如果需要一直保持的请求 需设置keepRequest
        if (!task.keepRequest) {
            
            [task cancel];
        }
    }
}

//是否有未完成的任务
+ (BOOL)hasTaskRunning{
    
    for (NSString *key in [[TZNetworkManager sharedInstance].taskQueue allKeys]) {
        
        TZNetworkTask *task = [[TZNetworkManager sharedInstance].taskQueue objectForKey:key];
        
        if (task.state == NSURLSessionTaskStateRunning) {
            
            return YES;
        }
    }
    
    return NO;
}

- (void)dealloc
{
    [TZNetworkManager cancelAllTaskInQueue];
}


#pragma mark - overwrite

- (void)setupSessionManager:(AFHTTPSessionManager *)sessionManager{
    
    
}

+ (NSDictionary *)additionalCookies{
    
    return nil;
}

+ (TZNetworkTask *)instanceOfNetworkTask{
    
    return [[TZNetworkTask alloc]init];
}

+ (id)parseResponse:(NSURLResponse *)response result:(id)responseObject error:(NSError *)error success:(inout BOOL*)success{
    
    return responseObject;
}

@end


