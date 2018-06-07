//
//  NSObject+Swizzle.h
//  GIChainLib
//
//  Created by ZT on 2018/5/16.
//  Copyright © 2018年 ChuangShiZhiLian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzle)

+ (void)switchMethod:(SEL)origin swizzled:(SEL)swizzled;

@end
