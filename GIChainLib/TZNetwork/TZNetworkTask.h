//
//  TZNetworkTask.h
//  ZLExchange
//
//  Created by ZT on 2018/5/17.
//  Copyright © 2018年 ChuangShiZhiLian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TZNetworkManager.h"
#import "TZNetworkProtocol.h"


/** 网络请求回调类型 */
typedef void(^completionBlock)(id<TZNetworkResultProtocol> requestResult);

/** 网络请求任务类 */
@interface TZNetworkTask : NSObject

/** 持有的原生网络请求task对象 */
@property (nonatomic,weak) NSURLSessionDataTask *sessionTask;
/** 请求地址 */
@property (nonatomic,copy) NSString *requestUrl;
/** 请求参数 */
@property (nonatomic,strong) NSDictionary *requestParam;
/** 是否需要保持请求（当取消队列中全部请求时保留） */
@property (nonatomic,assign) BOOL keepRequest;
/** 请求状态 */
@property (nonatomic,assign) NSURLSessionTaskState state;
/** 网络任务管理代理 */
@property (nonatomic,weak) id<TZNetworkManagerProtocol> delegate;
/** 成功回调 */
@property (nonatomic,copy) completionBlock success;
/** 失败回调 */
@property (nonatomic,copy) completionBlock failure;
/** 完成扩展回调 */
@property (nonatomic,copy) completionBlock extra;


/** 发送请求 */
- (TZNetworkTask *(^)(void))resume;
/** 取消请求 */
- (void)cancel;

/** 设置success,failure,extra */
- (TZNetworkTask *)resumeWithSuccess:(completionBlock)success failure:(completionBlock)failure extra:(completionBlock)extra;
/** 设置success,failure */
- (TZNetworkTask *)resumeWithSuccess:(completionBlock)success failure:(completionBlock)failure;
/** 设置success,extra */
- (TZNetworkTask *)resumeWithSuccess:(completionBlock)success extra:(completionBlock)extra;
/** 设置failure,extra */
- (TZNetworkTask *)resumeWithFailure:(completionBlock)failure extra:(completionBlock)extra;
/** 设置success */
- (TZNetworkTask *)resumeWithSuccess:(completionBlock)success;
/** 设置failure */
- (TZNetworkTask *)resumeWithFailure:(completionBlock)failure;
/** 设置extra */
- (TZNetworkTask *)resumeWithExtra:(completionBlock)extra;



/** 请求完成处理，由TZNetworkManager调用 */
- (void)requestCompletionHandler:(id<TZNetworkResultProtocol>)requestResult;

@end

