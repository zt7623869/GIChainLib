//
//  TZNetworkTask+Indicator.h
//  ZLExchange
//
//  Created by ZT on 2018/5/18.
//  Copyright © 2018年 ChuangShiZhiLian. All rights reserved.
//

#import "TZNetworkTask.h"

/** 网络请求任务类的界面展示分类 */
@interface TZNetworkTask (Indicator)

/** 是否显示指示器 */
@property (nonatomic) BOOL showIndicator;

/** 是否显示错误提示 */
@property (nonatomic) BOOL showNotice;

/** 设置是否显示指示器 */
- (TZNetworkTask *(^)(BOOL))indicator;

/** 设置是否显示错误提示 */
- (TZNetworkTask *(^)(BOOL))notice;

@end
