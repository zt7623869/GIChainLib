//
//  NSDecimalNumber+Ext.m
//  AFNetworking
//
//  Created by ZT on 2018/8/1.
//

#import "NSDecimalNumber+Ext.h"

@implementation NSDecimalNumber (Ext)

+ (NSDecimalNumber *)transDecimal:(id)number{
    
    NSDecimalNumber *num;
    
    if ([number isKindOfClass:NSNumber.class]) {
        
        num = [[NSDecimalNumber alloc]initWithDecimal:((NSNumber *)number).decimalValue];
        
    }else if([number isKindOfClass:NSString.class]){
        
        num = [[NSDecimalNumber alloc] initWithString:(NSString *)number];
        
    }else{
        
        num = @0;
    }
    
    return num;
}

@end
