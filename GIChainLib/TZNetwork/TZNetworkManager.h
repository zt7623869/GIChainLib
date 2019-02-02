//
//  ZLNetworkManager.h
//  GIChainLib
//
//  Created by ZT on 2018/3/21.
//  Copyright © 2018年 ChuangShiZhiLian. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "TZNetworkTask.h"
#import "TZNetworkProtocol.h"

//网络请求超时时间
#define TimeOutInterval 10.0f


/** 网络请求管理类 */
@interface TZNetworkManager : NSObject

/** AFHTTPSessionManager */
@property (nonatomic,strong) AFHTTPSessionManager *sessionManager;
/** 请求任务队列 */
@property (nonatomic,strong) NSMutableDictionary *taskQueue;
/** 获取单例 */
+ (instancetype)sharedInstance;

/**
 创建网络请求
 @param method 请求方式 GET/POST
 @param url 请求地址
 @param paramDict 请求参数
 @param needCache 是否需要缓存（预留，暂时无用）
 @param delegate 代理
 @return 返回请求任务对象
 */
+ (TZNetworkTask *)createRequestWithMethod:(NSString *)method url:(NSString *)url param:(NSDictionary *)paramDict cache:(BOOL)needCache delegate:(id<TZNetworkManagerProtocol>)delegate;


/**
 创建网络请求
 @param sessionManager AFHTTPSessionManager
 @param method 请求方式 GET/POST
 @param url 请求地址
 @param paramDict 请求参数
 @param needCache 是否需要缓存（预留，暂时无用）
 @param delegate 代理
 @return 返回请求任务对象
 */
+ (TZNetworkTask *)createRequestWithManager:(AFHTTPSessionManager *)sessionManager method:(NSString *)method url:(NSString *)url param:(NSDictionary *)paramDict cache:(BOOL)needCache delegate:(id<TZNetworkManagerProtocol>)delegate;

/**
 根据url从queue中取出task
 @param url 请求地址
 @return 任务对象
 */
+ (TZNetworkTask *)getTaskWithUrl:(NSString *)url;

/**
 取消task

 @param task 任务对象
 */
+ (void)cancelTask:(TZNetworkTask *)task;

/**
 根据url取消queue中指定的task

 @param url 请求地址
 */
+ (void)cancelTaskWithUrl:(NSString *)url;

/**
 取消queue中所有的task
 */
+ (void)cancelAllTaskInQueue;

/**
 是否有未完成的任务

 */
+ (BOOL)hasTaskRunning;



#pragma mark - overwrite

/**
 子类重写方法，用于设置sessionManager

 @return 返回自定义的sessionManager，如不实现则使用默认配置
 */
- (AFHTTPSessionManager *)sessionManagerInit;

/**
 子类重写方法，用于设置sessionManager
 @param sessionManager sessionManager
 */
- (void)setupSessionManager:(AFHTTPSessionManager *)sessionManager __attribute__((deprecated("弃用，请使用sessionManagerInit")));

/**
 子类重写方法，用于添加额外cookie
 @return cookie键值对
 */
+ (NSDictionary *)additionalCookies;


/**
 子类重写方法，定义网络请求任务类型，必须是TZNetworkTask的子类
 @return TZNetworkTask的子类
 */
+ (TZNetworkTask *)instanceOfNetworkTask;

/**
 子类重写方法，用于定义解析方式
 @param response 网络请求响应对象
 @param responseObject 网络请求返回的未解析结果
 @param error 网络请求错误
 @param success 自定义请求是否成功，需在实现中判断并重新赋值，inout
 @return 解析后的对象，必须遵守TZNetworkResultDelegate协议
 */
+ (id)parseResponse:(NSURLResponse *)response result:(id)responseObject error:(NSError *)error success:(inout BOOL*)success;


@end




