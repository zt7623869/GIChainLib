//
//  NSObject+Swizzle.m
//  GIChainLib
//
//  Created by ZT on 2018/5/16.
//  Copyright © 2018年 ChuangShiZhiLian. All rights reserved.
//

#import "NSObject+Swizzle.h"
#import <objc/runtime.h>

@implementation NSObject (Swizzle)

+ (void)switchMethod:(SEL)origin swizzled:(SEL)swizzled {
    
    Method originalMethod = class_getInstanceMethod(self
                                                    , origin);
    Method swizzledMethod = class_getInstanceMethod(self, swizzled);
    
    BOOL didAddMethod = class_addMethod(self,
                                        origin,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    
    if(didAddMethod){
        class_replaceMethod(self,
                            swizzled,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }else{
        method_exchangeImplementations(originalMethod,swizzledMethod);
    }
    
}

@end
