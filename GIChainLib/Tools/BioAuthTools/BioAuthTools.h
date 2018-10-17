//
//  BioAuthTools.h
//  ZLExchange
//
//  Created by ZT on 2018/8/8.
//  Copyright © 2018年 ChuangShiZhiLian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>


/**
 生物验证方式
 
 - eBioAuthTypeNone: 无生物验证
 - eBioAuthTypeTouchID: 指纹验证
 - eBioAuthTypeFaceID: 面容验证
 */
typedef NS_ENUM(NSUInteger, eBioAuthType) {
    eBioAuthTypeNone = 0,
    eBioAuthTypeTouchID,
    eBioAuthTypeFaceID
};

@interface BioAuthTools : NSObject


/**
 验证方法，自动选择适用的验证方式

 @param callback 验证结果回调 (success:验证结果;enable:验证开启状态;error:错误)
 */
+ (void)authenticateUser:(void(^)(BOOL success,BOOL enable, NSError *error))callback;

/**
 获取当前设备适用的验证方式

 @return 验证方式
 */
+ (eBioAuthType)authenticationType;


/**
 是否在系统中开启生物验证功能

 @param error 错误
 @return 结果
 */
+ (BOOL)isSystemBioAuthEnable:(NSError * __autoreleasing *)error;


/**
 是否在App中开启生物验证功能

 @param error 错误
 @return 结果
 */
+ (BOOL)isAppBioAuthEnable:(NSError * __autoreleasing *)error;


/**
 在App中设置生物验证的开启状态

 @param enable 开启状态
 */
+ (void)setAppBioAuthEnable:(BOOL)enable;


#pragma mark - overwrite

/**
 子类重写方法,用于自定义验证提示文字

 @return 验证提示文字
 */
+ (NSString *)localizedReason;

@end
