//
//  GITabCollectionViewCell.m
//  GIChainLib
//
//  Created by ZT on 2018/3/24.
//  Copyright © 2018年 ChuangShiZhiLian. All rights reserved.
//

#import "GITabCollectionViewCell.h"
#import <Masonry/Masonry.h>

@interface GITabCollectionViewCell()

@end

@implementation GITabCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (@available(iOS 12.0, *)) {
    
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
    
}

@end
