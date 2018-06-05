//
//  UIButton+ZLCategory.h
//  ZLExchange
//
//  Created by ZT on 2018/3/21.
//  Copyright © 2018年 ChuangShiZhiLian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ZLCategory)

@property (nonatomic) IBInspectable BOOL useFontFit;

@property (nonatomic) IBInspectable BOOL enabelity;

@property (nonatomic) IBInspectable UIColor *disableColor;

-(void)moveImageToRight;

@end
