//
//  ZLNetworkManager.m
//  GIChainLib
//
//  Created by ZT on 2018/5/17.
//  Copyright © 2018年 ChuangShiZhiLian. All rights reserved.
//

#import "ZLNetworkManager.h"

@implementation ZLNetworkManager


+(TZNetworkTask *)createRequestWithMethod:(NSString *)method url:(NSString *)url param:(NSDictionary *)paramDict cache:(BOOL)needCache delegate:(id<TZNetworkManagerProtocol>)delegate{
    
    NSString *urlstring = [@"https://test.6x.com/app/api/" stringByAppendingPathComponent:url];
    
    return [super createRequestWithMethod:method url:urlstring param:paramDict cache:needCache delegate:delegate];
}


+ (NSDictionary *)additionalCookies{

    return @{@"Language":@"zh_CN"};
}


+ (NSString *)noticeForError:(NSInteger)errorCode{
    
    NSString *msg;
    
    if (errorCode == 9999) {
        
        msg = @"解析错误";
        
    }else if (errorCode == -1001) {
        
        msg = @"网络超时";
        
    }else if(errorCode == -1009){
        
        msg = @"无网络连接";
        
    }else{
        
        msg = [NSString stringWithFormat:@"%@ %ld",@"网络错误",(long)errorCode];
    }
    
    return msg;
}

+ (id<TZNetworkResultProtocol>)parseRequestResult:(id)responseObject{
    
    return responseObject;
}

@end
