//
//  UIView+Ext.h
//  ZLExchange
//
//  Created by ZT on 2018/3/21.
//  Copyright © 2018年 ChuangShiZhiLian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Ext)

@property (nonatomic) IBInspectable CGFloat cornerRadius;

@property (nonatomic) IBInspectable CGFloat borderWidth;

@property (nonatomic) IBInspectable UIColor *borderColor;

- (void)removeAllSubviews;

@end
