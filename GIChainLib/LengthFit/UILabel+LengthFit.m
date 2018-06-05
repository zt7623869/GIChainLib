//
//  UILabel+LengthFit.m
//  ZLExchange
//
//  Created by ZT on 2018/3/21.
//  Copyright © 2018年 ChuangShiZhiLian. All rights reserved.
//

#import "UILabel+LengthFit.h"
#import <objc/runtime.h>
#import "LenthFit.h"

static void *useFontFitKey = &useFontFitKey;

@implementation UILabel (LengthFit)

- (BOOL)useFontFit{
    
    return [objc_getAssociatedObject(self, &useFontFitKey) boolValue];
}

-(void)setUseFontFit:(BOOL)useFontFit{
    
    if (useFontFit) {
        
        self.font = [UIFont fontWithName:self.font.fontName size:fontFit(self.font.pointSize)];
    }
    
    objc_setAssociatedObject(self, &useFontFitKey, @(useFontFit), OBJC_ASSOCIATION_ASSIGN);
}

@end
