//
//  ZLNetworkManager.h
//  ZLExchange
//
//  Created by ZT on 2018/3/21.
//  Copyright © 2018年 ChuangShiZhiLian. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "TZNetworkTask.h"
#import "TZNetworkProtocol.h"

/** 网络请求管理类 */
@interface TZNetworkManager : NSObject

/** AFHTTPSessionManager */
@property (nonatomic,strong) AFHTTPSessionManager *sessionManager;
/** 请求任务队列 */
@property (nonatomic,strong) NSMutableDictionary *taskQueue;
/** 获取单例 */
+ (TZNetworkManager*)sharedInstance;

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
 子类重写方法，用于自定义请求成功code，默认为200

 @param responseCode 返回结果code
 @return 请求是否成功
 */
+ (BOOL)isRequestSuccess:(NSNumber *)responseCode;

/**
 子类重写方法，用于自定义解析方式

 @param responseObject 网络请求返回的未解析结果
 @return 解析后的对象，必须遵守TZNetworkResultDelegate协议
 */
+ (id<TZNetworkResultProtocol>)parseRequestResult:(id)responseObject;

/**
 子类重写方法，用于添加额外cookie

 @return cookie键值对
 */
+ (NSDictionary *)additionalCookies;


/**
 子类重写方法，用于自定义错误提示

 @param errorCode 错误代码 (9999为自定义返回码，在parseRequestResult:方法返回值未遵守TZNetworkResultProtocol协议时抛出)
 @return 错误提示文案
 */
+ (NSString *)noticeForError:(NSInteger)errorCode;


@end




