//
//  UITextField+Ext.m
//  GIChainLib
//
//  Created by ZT on 2018/3/21.
//  Copyright © 2018年 ChuangShiZhiLian. All rights reserved.
//

#import "UITextField+Ext.h"

@implementation UITextField (Ext)

-(UIColor *)placeholderTextColor{
    
    return [self valueForKeyPath:@"_placeholderLabel.textColor"];
}

- (void)setPlaceholderTextColor:(UIColor *)color{
    [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
}

-(UIFont *)placeholderFont{
    
    return [self valueForKeyPath:@"_placeholderLabel.font"];
}

- (void)setPlaceholderFont:(UIFont *)font{
    [self setValue:font forKeyPath:@"_placeholderLabel.font"];
}

- (void)setClearButtonImage:(UIImage *)image {
    
    UIButton *clearBtn = [self valueForKeyPath:@"_clearButton"];
    
    [clearBtn setImage:image forState:UIControlStateNormal];
        
}

@end
