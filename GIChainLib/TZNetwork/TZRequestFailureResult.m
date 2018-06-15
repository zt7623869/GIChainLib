//
//  TZRequestFailureResult.m
//  GIChainLib
//
//  Created by ZT on 2018/5/18.
//  Copyright © 2018年 ChuangShiZhiLian. All rights reserved.
//

#import "TZRequestFailureResult.h"

@implementation TZRequestFailureResult

+ (TZRequestFailureResult *)failed:(NSNumber *)rCode data:(id)data msg:(NSString *)msg error:(NSError *)error {
    
    TZRequestFailureResult *result = [TZRequestFailureResult new];
    
    result.responseCode = rCode;
    result.message = msg;
    result.data = data;
    result.error = error;
    return result;
}


- (NSInteger)do_code { 
    return self.responseCode.integerValue;
}

- (NSString *)do_message { 
    return self.message;
}

- (id)do_result { 
    return self.data;
}

- (BOOL)do_success { 
    return self.responseCode.integerValue == 200;
}

- (NSError *)do_error { 
    return self.error;
}

@end
