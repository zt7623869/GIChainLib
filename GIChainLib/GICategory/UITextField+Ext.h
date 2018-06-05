//
//  UITextField+Ext.h
//  ZLExchange
//
//  Created by ZT on 2018/3/21.
//  Copyright © 2018年 ChuangShiZhiLian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Ext)

@property (nonatomic) IBInspectable UIColor *placeholderTextColor;

@property (nonatomic) IBInspectable UIFont *placeholderFont;

- (void)setClearButtonImage:(UIImage *)image;

@end
