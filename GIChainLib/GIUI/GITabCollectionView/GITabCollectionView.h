//
//  GITabCollectionView.h
//  GIChainLib
//
//  Created by ZT on 2018/3/26.
//  Copyright © 2018年 ChuangShiZhiLian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    TabCollectionStyleAlignLeft = 0,  //靠左排列
    TabCollectionStyleEqually,  //等分屏幕排列
} TabCollectionStyle;

@class GITabCollectionView;

@protocol ZLTabCollectionViewDelegate <NSObject>

/**
 选中tab事件

 @param tabCollectionView ZLTabCollectionView对象
 @param item 选中项目
 @param index 选中index
 */
-(void)tabCollectionView:(GITabCollectionView *)tabCollectionView didSelectItem:(NSString *)item atIndex:(NSInteger)index;

@end


@interface GITabCollectionView : UIView

/** tab数组 */
@property (nonatomic,strong) NSArray <NSString *>*tabs;

/** 代理 */
@property (nonatomic,weak) id<ZLTabCollectionViewDelegate> delegate;

/** tab的排列方式,默认是TabCollectionStyleAlignLeft */
@property (nonatomic,assign) TabCollectionStyle tabCollectionStyle;

/** tab选中时的字体样式 */
@property (nonatomic,strong) NSDictionary *selectedAttribute;

/** tab未选中时的字体样式 */
@property (nonatomic,strong) NSDictionary *unSelectedAttribute;

/** 底部分割线颜色 */
@property (nonatomic,strong) UIColor *bottomLineColor UI_APPEARANCE_SELECTOR;

/** 当前选中的index */
@property (nonatomic,assign,readonly) NSInteger selectedIndex;

-(instancetype)init UNAVAILABLE_ATTRIBUTE;
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout UNAVAILABLE_ATTRIBUTE;


/**
 设置选中index

 @param selectedIndex 选中index
 @param animate 是否需要切换动画
 */
-(void)setSelectedIndex:(NSInteger)selectedIndex animate:(BOOL)animate;

@end
