//
//  UIView+Ext.m
//  ZLExchange
//
//  Created by ZT on 2018/3/21.
//  Copyright © 2018年 ChuangShiZhiLian. All rights reserved.
//

#import "UIView+Ext.h"
#import <objc/runtime.h>

@implementation UIView (Ext)

- (CGFloat)cornerRadius
{
    
    return self.layer.cornerRadius;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = (cornerRadius > 0);
}

-(CGFloat)borderWidth{
    
    return self.layer.borderWidth;
}

-(void)setBorderWidth:(CGFloat)borderWidth{
    
    self.layer.borderWidth = borderWidth;
}

-(UIColor *)borderColor{
    
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

-(void)setBorderColor:(UIColor *)borderColor{
    
    self.layer.borderColor = [borderColor CGColor];
}

- (void)removeAllSubviews{
    
    for (UIView *subView in self.subviews) {
        
        [subView removeFromSuperview];
    }
}

@end
