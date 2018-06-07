//
//  GITabControlView.h
//  GIChainLib
//
//  Created by ZT on 2018/3/24.
//  Copyright © 2018年 ChuangShiZhiLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GITabCollectionView.h"

@class GITabControlView;

@protocol GITabControlViewDelegate <NSObject>

@optional

/** 内容页进入屏幕事件 */
- (void)didAppearInTabControlView:(GITabControlView *)tabControlView;

/** 内容页移出屏幕事件 */
- (void)didDisappearInTabControlView:(GITabControlView *)tabControlView;

@end

@interface GITabControlView : UIView

/** tab的排列方式,默认是TabCollectionStyleAlignLeft */
@property (nonatomic,assign) TabCollectionStyle tabCollectionStyle;

/** tab选中时的字体样式 */
@property (nonatomic,strong) NSDictionary *selectedAttribute;

/** tab未选中时的字体样式 */
@property (nonatomic,strong) NSDictionary *unSelectedAttribute;

/** 分割线颜色 */
@property (nonatomic,strong) UIColor *cuttingLineColor UI_APPEARANCE_SELECTOR;

/** tab数组 */
@property (nonatomic,strong,readonly) NSArray <NSString *>*tabs;

/** 内容页面类型 */
@property (nonatomic,strong,readonly) Class contentClass;

/** GITabCollectionView */
@property (nonatomic,strong,readonly) GITabCollectionView *tabCollectionView;

/** 内容ScrollView */
@property (nonatomic,strong,readonly) UIScrollView *contentScrollView;

-(instancetype)init UNAVAILABLE_ATTRIBUTE;


/**
 设置tab数组

 @param tabs tab数组
 @param contentClass 内容页面类型
 @param userInfo 内容页面接收的自定义参数
 */


/**
 设置tab数组

 @param tabs tab数组
 @param contentClass 内容页面类型
 @param userInfo 内容页面自定义设置 content:内容页面对象 index:序号 tab:所属tab
 */
-(void)setTabs:(NSArray <NSString *>*)tabs content:(Class<GITabControlViewDelegate>)contentClass userInfo:(void(^)(id content, NSInteger index, NSString *tab))userInfo;

/**
 设置tab数组
 
 @param tabs tab数组
 @param display tab显示设置block
 @param contentClass 内容页面类型
 @param userInfo 内容页面自定义设置 content:内容页面对象 index:序号 tab:所属tab
 */
-(void)setTabs:(NSArray *)tabs display:(NSString *(^)(id tab))display content:(Class<GITabControlViewDelegate>)contentClass userInfo:(void(^)(id content, NSInteger index, NSString *tab))userInfo;

@end
