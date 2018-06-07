//
//  UILabel+Ext.m
//  GIChainLib
//
//  Created by ZT on 2018/3/21.
//  Copyright © 2018年 ChuangShiZhiLian. All rights reserved.
//

#import "UILabel+Ext.h"
#import "NSObject+Swizzle.h"
#import <objc/runtime.h>

static char *edgeInsetsKey = "edgeInsetsKey";

@implementation UILabel (Ext)

+(void)load{
    
    [self switchMethod:@selector(textRectForBounds:limitedToNumberOfLines:) swizzled:@selector(zl_textRectForBounds:limitedToNumberOfLines:)];
    [self switchMethod:@selector(drawTextInRect:) swizzled:@selector(zl_drawTextInRect:)];
}

-(UIEdgeInsets)edgeInsets{
    
    NSValue *value = objc_getAssociatedObject(self, &edgeInsetsKey);
    
    return value.UIEdgeInsetsValue;
}

-(void)setEdgeInsets:(UIEdgeInsets)edgeInsets{
    
    objc_setAssociatedObject(self, &edgeInsetsKey, [NSValue valueWithUIEdgeInsets:edgeInsets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGRect)zl_textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    
    UIEdgeInsets insets = self.edgeInsets;
    CGRect rect = [self zl_textRectForBounds:UIEdgeInsetsInsetRect(bounds, insets)
                    limitedToNumberOfLines:numberOfLines];
    
    rect.origin.x    -= insets.left;
    rect.origin.y    -= insets.top;
    rect.size.width  += (insets.left + insets.right);
    rect.size.height += (insets.top + insets.bottom);
    
    return rect;
}

- (void)zl_drawTextInRect:(CGRect)rect {
    
    [self zl_drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
}

@end


