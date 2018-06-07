//
//  TZNetworkProtocol.h
//  GIChainLib
//
//  Created by ZT on 2018/5/18.
//  Copyright © 2018年 ChuangShiZhiLian. All rights reserved.
//


@class TZNetworkTask;

/** 网络请求管理协议，由具体页面遵守 */
@protocol TZNetworkManagerProtocol <NSObject>

/** 网络请求弱引用队列 */
@property (nonatomic, strong)NSMapTable *requestQueue;

@end


/** 网络请求返回结果格式协议，由返回结果model遵守 */
@protocol TZNetworkResultProtocol <NSObject>

/** 请求结果信息 */
@property (nonatomic,copy) NSString *message;
/** 错误信息 */
@property (nonatomic, strong)NSError *error;
/** 请求状态码 */
@property (nonatomic,strong) NSNumber *responseCode;
/** 返回数据 */
@property (nonatomic,strong) id data;
/** 是否请求成功 */
@property (nonatomic,assign) BOOL success;

@end


@class TZNetworkTask;

/** 网络请求界面显示协议，由具体页面遵守 */
@protocol TZNetworkIndicateDelegate <NSObject>

/**
 网络请求开始，显示指示器

 @param task 请求任务对象
 */
- (void)showNetWorkIndicator:(TZNetworkTask *)task;
/**
 网络请求结束，隐藏指示器

 @param task 请求任务对象
 */
- (void)hideNetWorkIndicator:(TZNetworkTask *)task;
/**
 网络请求失败，显示错误提示

 @param requestResult 请求结果对象
 */
- (void)showNetWorkFailureNotice:(id<TZNetworkResultProtocol>)requestResult;

@end

