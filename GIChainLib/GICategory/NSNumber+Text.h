//
//  NSNumber+Text.h
//  ZLExchange
//
//  Created by ZT on 2018/4/8.
//  Copyright © 2018年 ChuangShiZhiLian. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSNumber (Text)

+ (NSString *(^)(id, NSInteger, NSInteger))signedPercent;

+ (NSString *(^)(id, NSInteger, NSInteger))signedFraction;

+ (NSString *(^)(id, NSInteger, NSInteger))significantFraction;

+ (NSString *(^)(id, NSInteger))multiplierNumber;

+ (NSString *(^)(id, NSInteger, NSInteger))absoluteDigitFraction;

+ (NSNumber *)transDecimal:(id)number;

- (NSString *)decimalString;

- (NSString *)signedDecimalString;



@end
