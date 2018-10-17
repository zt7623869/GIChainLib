//
//  BioAuthTools.m
//  ZLExchange
//
//  Created by ZT on 2018/8/8.
//  Copyright © 2018年 ChuangShiZhiLian. All rights reserved.
//

#import "BioAuthTools.h"
#import "sys/utsname.h"

static NSString *BioAuthEnable = @"BioAuthEnable";

@implementation BioAuthTools

+ (void)authenticateUser:(void(^)(BOOL success,BOOL enable, NSError *error))callback
{
    
    LAContext* context = [[LAContext alloc] init];
    
    NSError* error = nil;
    
    if ([self isSystemBioAuthEnable:&error]) {
        
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:[self localizedReason] reply:^(BOOL success, NSError *error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (callback) {
                    callback(success,YES,error);
                }
            });
        }];
    
    }else{
       
        if (callback) {
            callback(NO,NO,error);
        }
    }
}

+ (eBioAuthType)authenticationType{

    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSString *deviceName = [deviceString componentsSeparatedByString:@","].firstObject;
    
    if (![deviceName hasPrefix:@"iPhone"]) {
        
        return eBioAuthTypeNone;
    }
    
    NSInteger era = [deviceName substringFromIndex:6].integerValue;

    if (era > 10 || [deviceString isEqualToString:@"iPhone10,3"] || [deviceString isEqualToString:@"iPhone10,6"]) {
        
        return eBioAuthTypeFaceID;
    
    }else if(era >= 6 && era <= 10){
        
        return eBioAuthTypeTouchID;
        
    }else{
        
        return eBioAuthTypeNone;
    }
}

+ (BOOL)isSystemBioAuthEnable:(NSError * __autoreleasing *)error{
    
    LAContext* context = [[LAContext alloc] init];
    
    BOOL enable = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:error];
    
    if (!enable) {
        
        [self setAppBioAuthEnable:NO];
    }
    
    return enable;
}

+ (BOOL)isAppBioAuthEnable:(NSError * __autoreleasing *)error{
    
    if (![self isSystemBioAuthEnable:error]) {
        
        return NO;
    }
    
    ZLAccountModel *lastest = [ZLSingletonUser lastestAccount];

    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] valueForKey:BioAuthEnable];
    
    BOOL enable;
    if ([dic isKindOfClass:[NSDictionary class]]) {
        
        enable = [[dic valueForKey:lastest.user.userId] boolValue];
    
    }else{
        
        enable = NO;
    }
    
    return enable;
}

+ (void)setAppBioAuthEnable:(BOOL)enable{
    
    ZLAccountModel *lastest = [ZLSingletonUser account];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] valueForKey:BioAuthEnable];
    NSMutableDictionary *newDic;
    
    if (!dic || ![dic isKindOfClass:[NSDictionary class]]) {
        newDic = [NSMutableDictionary dictionaryWithCapacity:0];
    }else{
        newDic = [dic mutableCopy];
    }
    
    if (!lastest.user.userId.length) {
        return;
    }
    
    [newDic setValue:@(enable) forKey:lastest.user.userId];
    
    [defaults setValue:newDic forKey:BioAuthEnable];
    [defaults synchronize];
}

+ (NSString *)localizedReason{
    
    return @"需要验证您的身份";
}


@end
