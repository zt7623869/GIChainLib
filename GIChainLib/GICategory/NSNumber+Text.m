//
//  NSNumber+ZLCategory.m
//  ZLExchange
//
//  Created by ZT on 2018/4/8.
//  Copyright © 2018年 ChuangShiZhiLian. All rights reserved.
//

#import "NSNumber+Text.h"

@implementation NSNumber (Text)

+ (NSString *(^)(id, NSInteger, NSInteger))signedPercent{
    
    return ^NSString *(id number, NSInteger minimumFractionDigits, NSInteger maximumFractionDigits) {
        
        return [NSString stringWithFormat:@"%@%%",NSNumber.signedFraction(number,minimumFractionDigits,maximumFractionDigits)];
    };
}

+ (NSString *(^)(id, NSInteger, NSInteger))signedFraction{
    
    return ^NSString *(id number, NSInteger minimumFractionDigits, NSInteger maximumFractionDigits) {
        
        NSString *numberStr = NSNumber.significantFraction(number,minimumFractionDigits,maximumFractionDigits);
        
        if (numberStr.floatValue > 0) {
            
            return [NSString stringWithFormat:@"+%@",numberStr];
            
        }else{
            
            return numberStr;
        }
    };
}

+ (NSString *(^)(id, NSInteger, NSInteger))significantFraction{
    
    return ^NSString *(id number, NSInteger minimumFractionDigits, NSInteger maximumFractionDigits) {
        
        NSNumber *num;
        
        if ([number isKindOfClass:NSNumber.class]) {
            
            num = (NSNumber *)number;
            
        }else if([number isKindOfClass:NSString.class]){
            
            NSDecimalNumber *decimal = [[NSDecimalNumber alloc] initWithString:(NSString *)number];
            num = decimal;
            
        }else{
            
            num = @0;
        }
        
        NSNumberFormatter *numFormat = [[NSNumberFormatter alloc] init];
        numFormat.numberStyle = NSNumberFormatterDecimalStyle;
        numFormat.maximumFractionDigits = maximumFractionDigits;
        numFormat.minimumFractionDigits = minimumFractionDigits;
        numFormat.groupingSize = 0;
        numFormat.roundingMode = NSNumberFormatterRoundFloor;
        
        if (num.floatValue < 1 && num.floatValue > -1 && num.floatValue != 0){
            
            if ([numFormat stringFromNumber:num].floatValue == 0) {
                
                numFormat.maximumSignificantDigits = 1;
                numFormat.maximumFractionDigits = CGFLOAT_MAX;
            }
        }
        
        NSString *str = [numFormat stringFromNumber:num];
        return str;
    };
}

+ (NSString *(^)(id, NSInteger, NSInteger))absoluteDigitFraction{
    
    return ^NSString *(id number, NSInteger minimumFractionDigits, NSInteger maximumFractionDigits) {
        
        NSNumber *num;
        
        if ([number isKindOfClass:NSNumber.class]) {
            
            num = (NSNumber *)number;
            
        }else if([number isKindOfClass:NSString.class]){
            
            NSDecimalNumber *decimal = [[NSDecimalNumber alloc] initWithString:(NSString *)number];
            num = decimal;
            
        }else{
            
            num = @0;
        }
        
        NSNumberFormatter *numFormat = [[NSNumberFormatter alloc] init];
        numFormat.numberStyle = NSNumberFormatterDecimalStyle;
        numFormat.maximumFractionDigits = maximumFractionDigits;
        numFormat.minimumFractionDigits = minimumFractionDigits;
        numFormat.groupingSize = 0;
        numFormat.roundingMode = NSNumberFormatterRoundFloor;
        
        NSString *str = [numFormat stringFromNumber:num];
        return str;
    };
}

+ (NSString *(^)(id, NSInteger))multiplierNumber{
    
    return ^NSString *(id number, NSInteger digit) {
        
        NSNumber *num;
        
        if ([number isKindOfClass:NSNumber.class]) {
            
            num = (NSNumber *)number;
            
        }else if([number isKindOfClass:NSString.class]){
            
            NSDecimalNumber *decimal = [[NSDecimalNumber alloc] initWithString:(NSString *)number];
            num = decimal;
            
        }else{
            
            num = @0;
        }
        
        NSNumberFormatter *numFormat = [[NSNumberFormatter alloc] init];
        numFormat.numberStyle = NSNumberFormatterDecimalStyle;
        numFormat.groupingSize = 0;
        
        if (num.floatValue/1000 > 1 || num.floatValue/1000 < -1) {
            
            numFormat.multiplier = @0.001;
            numFormat.positiveSuffix = @"k";
            numFormat.maximumSignificantDigits = digit - 1;
            
        }else if (num.floatValue < 1 && num.floatValue > -1 && num.floatValue != 0){
            
            numFormat.maximumFractionDigits = digit - 1;
            
            if ([numFormat stringFromNumber:num].floatValue == 0) {
                
                numFormat.maximumSignificantDigits = 1;
                numFormat.maximumFractionDigits = CGFLOAT_MAX;
            }
            
        }else{
            
            numFormat.maximumSignificantDigits = digit;
        }
        
        return [numFormat stringFromNumber:num];
    };
}


- (NSString *)decimalString{
    
    double d = [self doubleValue];
    NSString *doubleString = [NSString stringWithFormat:@"%f", d];
    NSDecimalNumber *decimal = [[NSDecimalNumber alloc]initWithString:doubleString];
    return decimal.stringValue;
}


- (NSString *)signedDecimalString{
    
    double d = [self doubleValue];
    NSString *doubleString = [NSString stringWithFormat:@"%f", d];
    NSDecimalNumber *decimal = [[NSDecimalNumber alloc]initWithString:doubleString];
    
    if (d > 0) {
        
        return [NSString stringWithFormat:@"+%@",decimal.stringValue];
        
    }else{
        
        return decimal.stringValue;
    }
}

@end
