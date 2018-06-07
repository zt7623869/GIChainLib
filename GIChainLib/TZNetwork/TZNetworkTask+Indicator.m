//
//  TZNetworkTask+Indicator.m
//  GIChainLib
//
//  Created by ZT on 2018/5/18.
//  Copyright © 2018年 ChuangShiZhiLian. All rights reserved.
//

#import "TZNetworkTask+Indicator.h"
#import "NSObject+Swizzle.h"
#import <objc/runtime.h>

static char *showIndicatorKey = "showIndicatorKey";
static char *showNoticeKey = "showNoticeKey";

@implementation TZNetworkTask (Indicator)

+(void)load{
    
    [self switchMethod:@selector(init) swizzled:@selector(hud_init)];
    [self switchMethod:@selector(resume) swizzled:@selector(hud_resume)];
    [self switchMethod:@selector(failure) swizzled:@selector(hud_failure)];
    [self switchMethod:@selector(finish) swizzled:@selector(hud_finish)];
}

- (instancetype)hud_init{
    
    TZNetworkTask *task = [self hud_init];
    
    if (task) {
        
        task.showIndicator = YES;
        task.showNotice = YES;
    }
    
    return self;
}

-(BOOL)showIndicator{
    
    return [objc_getAssociatedObject(self, showIndicatorKey) boolValue];
}

-(void)setShowIndicator:(BOOL)showIndicator{
    
    objc_setAssociatedObject(self, showIndicatorKey, @(showIndicator), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (TZNetworkTask *(^)(BOOL))indicator{
    
    return ^TZNetworkTask *(BOOL indicator) {
        
        self.showIndicator = indicator;
        return self;
    };
}

-(BOOL)showNotice{
    
    return [objc_getAssociatedObject(self, showNoticeKey) boolValue];
}

-(void)setShowNotice:(BOOL)showNotice{
    
    objc_setAssociatedObject(self, showNoticeKey, @(showNotice), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (TZNetworkTask *(^)(BOOL))notice{
    
    return ^TZNetworkTask *(BOOL notice) {
        
        self.showNotice = notice;
        return self;
    };
}


-(TZNetworkTask *(^)(void))hud_resume{
    
    return ^TZNetworkTask *() {
        
        if (self.showIndicator) {
            
            if (self.delegate && [self.delegate conformsToProtocol:@protocol(TZNetworkIndicateDelegate)] && [self.delegate respondsToSelector:@selector(showNetWorkIndicator:)]) {
                
                [(id<TZNetworkIndicateDelegate>)self.delegate showNetWorkIndicator:self];
            }
        }
        
        return self.hud_resume();
    };
}

-(completionBlock)hud_failure{
    
    return ^(id<TZNetworkResultProtocol> requestResult) {
        
        if (self.showNotice) {
            
            if (self.delegate && [self.delegate conformsToProtocol:@protocol(TZNetworkIndicateDelegate)] && [self.delegate respondsToSelector:@selector(showNetWorkFailureNotice:)]) {
                
                [(id<TZNetworkIndicateDelegate>)self.delegate showNetWorkFailureNotice:requestResult];
            }
        }
        
        if (self.hud_failure) {
            
            self.hud_failure(requestResult);
        }
    };
}

-(completionBlock)hud_finish{
    
    return ^(id<TZNetworkResultProtocol> requestResult) {
        
        if (self.delegate && [self.delegate conformsToProtocol:@protocol(TZNetworkIndicateDelegate)] && [self.delegate respondsToSelector:@selector(hideNetWorkIndicator:)]) {
            
            [(id<TZNetworkIndicateDelegate>)self.delegate hideNetWorkIndicator:self];
        }
        
        if (self.hud_finish) {
            
            self.hud_finish(requestResult);
        }
    };
}

@end
