//
//  UIButton+Ext.m
//  GIChainLib
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
static char *changeOverKey = "changeOverKey";

@implementation UIButton (Ext)

+(void)load{
    
    [self switchMethod:@selector(setEnabled:) swizzled:@selector(ext_setEnabled:)];
    [self switchMethod:@selector(setImage:forState:) swizzled:@selector(ext_setImage:forState:)];
    [self switchMethod:@selector(setTitle:forState:) swizzled:@selector(ext_setTitle:forState:)];
}

- (void)ext_setEnabled:(BOOL)enabled {
    
    [self ext_setEnabled:enabled];
    
    if (self.enabelity) {
        
        UIColor *disColor = self.disableColor ? : self.backgroundColor;
        UIColor *normColor = self.normalColor ? : self.backgroundColor;
        
        [self setBackgroundColor:enabled ? normColor : disColor];
    }
}

-(void)ext_setImage:(UIImage *)image forState:(UIControlState)state{

    [self ext_setImage:image forState:state];
    
    if (self.changeOver) {
       
        [self adjustImageToRight];
    }
}

-(void)ext_setTitle:(NSString *)title forState:(UIControlState)state{
    
    [self ext_setTitle:title forState:state];
    
    if (self.changeOver) {
        
        [self adjustImageToRight];
    }
}

- (void)setEnabelity:(BOOL)enabelity {
    
    objc_setAssociatedObject(self, enabelityKey, @(enabelity), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)enabelity {
    
    return [objc_getAssociatedObject(self, enabelityKey) boolValue];
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

-(void)setChangeOver:(BOOL)changeOver{
    
    objc_setAssociatedObject(self, changeOverKey, @(changeOver), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (changeOver) {
        
        [self adjustImageToRight];

    }else{
        
        [self resetImageToLeft];
    }
}

-(BOOL)changeOver{
    
    return [objc_getAssociatedObject(self, changeOverKey) boolValue];
}

-(void)adjustImageToRight{
    
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.imageView.image.size.width, 0, self.imageView.image.size.width)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, self.titleLabel.bounds.size.width, 0, -self.titleLabel.bounds.size.width)];
}

-(void)resetImageToLeft{
    
    [self setTitleEdgeInsets:UIEdgeInsetsZero];
    [self setImageEdgeInsets:UIEdgeInsetsZero];
}

@end
