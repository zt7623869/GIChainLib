//
//  TZNetworkTask.m
//  ZLExchange
//
//  Created by ZT on 2018/5/17.
//  Copyright © 2018年 ChuangShiZhiLian. All rights reserved.
//

#import "TZNetworkTask.h"

@implementation TZNetworkTask

- (instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        self.keepRequest = NO;
    }
    
    return self;
}

- (TZNetworkTask *(^)(void))resume{
    
    return ^TZNetworkTask *() {
        
        //若请求状态不为running则发送请求
        if (self.sessionTask.state != NSURLSessionTaskStateRunning) {
            
            [self.sessionTask resume];
            
            //将请求添加进manager管理队列
            [[TZNetworkManager sharedInstance].taskQueue setObject:self forKey:[self memoryAddress]];

            //将请求添加进页面管理代理的队列，如果队列中有相同请求则将之前的请求先cancel
            if (self.delegate.requestQueue) {
                
                for (NSString * key in self.delegate.requestQueue) {
                    
                    if ([key isEqualToString:self.requestUrl]) {
                        
                        TZNetworkTask * request = [self.delegate.requestQueue objectForKey:self.requestUrl];
                        
                        if ([request isKindOfClass:[TZNetworkTask class]]) {
                            
                            [request cancel];
                        }
                    }
                }
                
                [self.delegate.requestQueue setObject:self forKey:self.requestUrl];
            }
        }
        
        return self;
    };
}

- (NSURLSessionTaskState)state{
    
    return self.sessionTask.state;
}

- (void)cancel{
    
    [self.sessionTask cancel];
    
    [self removeFromQueue];
}

//请求完成处理，由TZNetworkManager调用
- (void)requestCompletionHandler:(id<TZNetworkResultProtocol>)requestResult{
    
    if ([TZNetworkManager isRequestSuccess:requestResult.responseCode]) {
        //请求成功执行成功回调
        if (self.success) {
            
            self.success(requestResult);
        }
        
    }else{
        //请求失败，除撤销原因以外，都执行失败回调
        if (self.failure && requestResult.responseCode.integerValue != -999) {
            
            self.failure(requestResult);
        }
    }
    
    //额外执行扩展回调
    if (self.extra) {

        self.extra(requestResult);
    }
    
    [self removeFromQueue];
}

- (void)removeFromQueue{
    
    //将请求任务从manager的管理队列中移除
    if ([[[TZNetworkManager sharedInstance].taskQueue allKeys] containsObject:[self memoryAddress]]) {
        
        [[TZNetworkManager sharedInstance].taskQueue removeObjectForKey:[self memoryAddress]];
    }
}

//获取任务对象内存地址(用作在任务队列中的key)
- (NSString *)memoryAddress{
    
    return [NSString stringWithFormat:@"%p",self];
}

- (TZNetworkTask *)resumeWithSuccess:(completionBlock)success failure:(completionBlock)failure extra:(completionBlock)extra{
    
    self.success = success;
    self.failure = failure;
    self.extra = extra;
    
    return self.resume();
}

- (TZNetworkTask *)resumeWithSuccess:(completionBlock)success failure:(completionBlock)failure{
    
    return [self resumeWithSuccess:success failure:failure extra:nil];
}

- (TZNetworkTask *)resumeWithSuccess:(completionBlock)success extra:(completionBlock)extra{
    
    return [self resumeWithSuccess:success failure:nil extra:extra];
}

- (TZNetworkTask *)resumeWithFailure:(completionBlock)failure extra:(completionBlock)extra{
    
    return [self resumeWithSuccess:nil failure:failure extra:extra];
}

- (TZNetworkTask *)resumeWithSuccess:(completionBlock)success{
    
    return [self resumeWithSuccess:success failure:nil extra:nil];
}

- (TZNetworkTask *)resumeWithFailure:(completionBlock)failure{
    
    return [self resumeWithSuccess:nil failure:failure extra:nil];
}

- (TZNetworkTask *)resumeWithExtra:(completionBlock)extra{
    
    return [self resumeWithSuccess:nil failure:nil extra:extra];
}


-(void)dealloc{
    
//        DLog(@"task dealloc");
}

@end
