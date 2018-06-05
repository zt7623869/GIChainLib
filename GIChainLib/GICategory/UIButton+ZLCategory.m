//
//  UIButton+ZLCategory.m
//  ZLExchange
//
//  Created by ZT on 2018/3/21.
//  Copyright © 2018年 ChuangShiZhiLian. All rights reserved.
//

#import "UIButton+ZLCategory.h"

static void *useFontFitKey = &useFontFitKey;

static void *ena = &ena;
static void *disColor = &disColor;

@implementation UIButton (ZLCategory)

+(void)load{
    
    [self switchMethod:@selector(setEnabled:) swizzled:@selector(zl_setEnabled:)];
}

- (BOOL)useFontFit{
    
    return [objc_getAssociatedObject(self, &useFontFitKey) boolValue];
}

-(void)setUseFontFit:(BOOL)useFontFit{
    
    if (useFontFit) {
        
        self.titleLabel.font = [UIFont fontWithName:self.titleLabel.font.fontName size:fontFitBy375(self.titleLabel.font.pointSize)];
    }
    
    objc_setAssociatedObject(self, &useFontFitKey, @(useFontFit), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)enabelity {
    
    return [objc_getAssociatedObject(self, &ena) boolValue];
}

- (void)setEnabelity:(BOOL)enabelity {
    
    objc_setAssociatedObject(self, &ena, @(enabelity), OBJC_ASSOCIATION_ASSIGN);
    
    [self setEnabled:self.enabled];
    
    
}

- (void)zl_setEnabled:(BOOL)enabled {
    [self zl_setEnabled:enabled];
    if (self.enabelity) {

        UIColor *color = self.disableColor ? : ZL_Color.button.disable;

        UIColor *normal = ZL_Color.button.bg_blue;

        [self setBackgroundColor:enabled ? normal : color];

    }
}

- (void)setDisableColor:(UIColor *)disableColor {
    if (disableColor) {
        objc_setAssociatedObject(self, &disColor, disableColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (UIColor *)disableColor {
    return objc_getAssociatedObject(self, &disColor);
}

-(void)moveImageToRight{
    
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.imageView.image.size.width, 0, self.imageView.image.size.width)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, self.titleLabel.bounds.size.width, 0, -self.titleLabel.bounds.size.width)];
}

@end
