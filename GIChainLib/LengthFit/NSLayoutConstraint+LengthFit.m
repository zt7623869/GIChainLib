//
//  NSLayoutConstraint+LengthFit.m
//  ZLExchange
//
//  Created by ZT on 2018/3/21.
//  Copyright © 2018年 ChuangShiZhiLian. All rights reserved.
//

#import "NSLayoutConstraint+LengthFit.h"
#import <objc/runtime.h>
#import "LenthFit.h"

static void *useLengthFitKey = &useLengthFitKey;

@implementation NSLayoutConstraint (LengthFit)

- (BOOL)useLengthFit{
    
    return [objc_getAssociatedObject(self, &useLengthFitKey) boolValue];
}

- (void)setUseLengthFit:(BOOL)useLengthFit{
    
    if (self.useLengthFit == useLengthFit) {
        
        return;
    }
    
    if (useLengthFit) {
        
        self.constant = lengthFit(self.constant);
    
    }
    
    objc_setAssociatedObject(self, &useLengthFitKey, @(useLengthFit), OBJC_ASSOCIATION_ASSIGN);
}


@end
