//
//  UIButton+Ext.m
//  ZLExchange
//
//  Created by ZT on 2018/3/21.
//  Copyright © 2018年 ChuangShiZhiLian. All rights reserved.
//

#import "UIButton+Ext.h"
#import "NSObject+Swizzle.h"
#import <objc/runtime.h>

static char *enabelityKey = "enabelityKey";
static char *disableColorKey = "disableColorKey";

@implementation UIButton (Ext)

+(void)load{
    
    [self switchMethod:@selector(setEnabled:) swizzled:@selector(zl_setEnabled:)];
}

- (BOOL)enabelity {
    
    return [objc_getAssociatedObject(self, enabelityKey) boolValue];
}

- (void)setEnabelity:(BOOL)enabelity {
    
    objc_setAssociatedObject(self, enabelityKey, @(enabelity), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self setEnabled:self.enabled];
}

- (void)zl_setEnabled:(BOOL)enabled {
    
    [self zl_setEnabled:enabled];
    
    if (self.enabelity) {

        UIColor *disColor = self.disableColor ? : self.backgroundColor;

        [self setBackgroundColor:enabled ? self.backgroundColor : disColor];
    }
}

- (void)setDisableColor:(UIColor *)disableColor {
    
    if (disableColor) {
        
        objc_setAssociatedObject(self, disableColorKey, disableColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (UIColor *)disableColor {
    
    return objc_getAssociatedObject(self, disableColorKey);
}

-(void)moveImageToRight{
    
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.imageView.image.size.width, 0, self.imageView.image.size.width)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, self.titleLabel.bounds.size.width, 0, -self.titleLabel.bounds.size.width)];
}

@end
