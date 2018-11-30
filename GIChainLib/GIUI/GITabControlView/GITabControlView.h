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

/** GITabCollectionView */
@property (nonatomic,strong,readonly) GITabCollectionView *tabCollectionView;

/** 内容ScrollView */
@property (nonatomic,strong,readonly) UIScrollView *contentScrollView;

-(instancetype)init UNAVAILABLE_ATTRIBUTE;


/**
 设置tab数组

 @param tabs tab数组
 @param createContent 内容页面自定义
 */
-(void)setTabs:(NSArray <NSString *>*)tabs contents:(UIResponder *(^)(NSInteger index))createContent;

/**
 设置tab数组

 @param tabs tab数组
 @param display tab显示设置
 @param createContent 内容页面自定义
 */
-(void)setTabs:(NSArray *)tabs display:(NSString *(^)(id tab))display contents:(UIResponder *(^)(NSInteger index))createContent;

@end
