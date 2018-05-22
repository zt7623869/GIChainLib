//
//  TZRequestFailureResult.h
//  ZLExchange
//
//  Created by ZT on 2018/5/18.
//  Copyright © 2018年 ChuangShiZhiLian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TZNetworkProtocol.h"

@interface TZRequestFailureResult : NSObject <TZNetworkResultProtocol>

@property (nonatomic,copy) NSString *message;
@property (nonatomic, strong)NSError *error;
@property (nonatomic,strong) NSNumber *responseCode;
@property (nonatomic,strong) id data;
@property (nonatomic,assign) BOOL success;

@end
