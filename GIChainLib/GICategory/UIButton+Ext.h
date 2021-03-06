//
//  UIButton+Ext.h
//  GIChainLib
//
//  Created by ZT on 2018/3/21.
//  Copyright © 2018年 ChuangShiZhiLian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Ext)

@property (nonatomic) IBInspectable BOOL enabelity;

@property (nonatomic) IBInspectable UIColor *normalColor;

@property (nonatomic) IBInspectable UIColor *disableColor;

@property (nonatomic) IBInspectable BOOL changeOver;

-(void)adjustImageToRight;
-(void)resetImageToLeft;

@end
