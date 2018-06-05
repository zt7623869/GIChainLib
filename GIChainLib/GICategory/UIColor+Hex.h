//
//  UIColor+Hex.h
//  ZLExchange
//
//  Created by ZT on 2018/3/21.
//  Copyright © 2018年 ChuangShiZhiLian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor *)colorWithHexString: (NSString *)color alpha:(CGFloat)alpha;

+ (UIColor *) colorWithHexString: (NSString *)color;

@end
