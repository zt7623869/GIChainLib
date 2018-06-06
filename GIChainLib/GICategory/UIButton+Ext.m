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
static char *normalColorKey = "normalColorKey";
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
}

- (void)zl_setEnabled:(BOOL)enabled {
    
    [self zl_setEnabled:enabled];
    
    if (self.enabelity) {

        UIColor *disColor = self.disableColor ? : self.backgroundColor;
        UIColor *normColor = self.normalColor ? : self.backgroundColor;

        [self setBackgroundColor:enabled ? normColor : disColor];
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

- (void)setNormalColor:(UIColor *)normalColor {
    
    if (normalColor) {
        
        objc_setAssociatedObject(self, normalColorKey, normalColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (UIColor *)normalColor {
    
    return objc_getAssociatedObject(self, normalColorKey);
}

-(void)moveImageToRight{
    
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.imageView.image.size.width, 0, self.imageView.image.size.width)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, self.titleLabel.bounds.size.width, 0, -self.titleLabel.bounds.size.width)];
}

@end
