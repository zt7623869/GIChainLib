//
//  GITabCollectionView.m
//  GIChainLib
//
//  Created by ZT on 2018/3/26.
//  Copyright © 2018年 ChuangShiZhiLian. All rights reserved.
//

#import "GITabCollectionView.h"
#import "GITabCollectionViewCell.h"
#import <Masonry/Masonry.h>

#define TAB_COLLECTION_VIEW_CELL @"TAB_COLLECTION_VIEW_CELL"

@interface GITabCollectionView () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) UIView *selectionBar;

@property (nonatomic,strong) UIView *bottomLine;

@end

@implementation GITabCollectionView

- (void)awakeFromNib{
    
    [super awakeFromNib];
    
    [self setupSubViews];
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
                
        [self setupSubViews];
    }
    
    return self;
}

- (void)layoutSubviews{
    
    UICollectionViewFlowLayout *tabFlowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    if (self.tabCollectionStyle == TabCollectionStyleAlignLeft) {
        
        tabFlowLayout.estimatedItemSize = CGSizeMake(60,30);
        
    }else{
        
        tabFlowLayout.itemSize = CGSizeMake(self.frame.size.width/self.tabs.count, self.frame.size.height);
        tabFlowLayout.estimatedItemSize = CGSizeZero;
    }
}

-(void)setTabs:(NSArray<NSString *> *)tabs{
    
    _tabs = tabs;
    _selectedIndex = 0;
    
    [self.collectionView reloadData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
        [self setOffsetForSelectionBar:0 animate:NO];
    });
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabCollectionView:didSelectItem:atIndex:)]) {
        
        [self.delegate tabCollectionView:self didSelectItem:self.tabs.firstObject atIndex:0];
    }
}

-(void)setSelectedIndex:(NSInteger)selectedIndex animate:(BOOL)animate{
    
    if (self.tabs.count == 0) {
        
        return;
    }
    
    _selectedIndex = selectedIndex;
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
    [self setOffsetForSelectionBar:selectedIndex animate:animate];
    [self.collectionView reloadData];
}

-(void)setSelectedIndex:(NSInteger)selectedIndex{
    
    if (self.tabs.count == 0) {
        
        return;
    }
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
    [self setOffsetForSelectionBar:selectedIndex animate:YES];
    [self.collectionView reloadData];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabCollectionView:didSelectItem:atIndex:)]) {
        
        [self.delegate tabCollectionView:self didSelectItem:self.tabs[selectedIndex] atIndex:selectedIndex];
    }
    
    _selectedIndex = selectedIndex;
}

- (void)setupSubViews{
    
    self.backgroundColor = [UIColor clearColor];
    
    UICollectionViewFlowLayout *tabFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    tabFlowLayout.estimatedItemSize = CGSizeMake(60,30);
    tabFlowLayout.minimumInteritemSpacing = 0;
    tabFlowLayout.minimumLineSpacing = 0;
    tabFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:tabFlowLayout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(GITabCollectionViewCell.class) bundle:[NSBundle bundleForClass:[self class]]] forCellWithReuseIdentifier:TAB_COLLECTION_VIEW_CELL];
    
    self.bottomLine = [[UIView alloc]initWithFrame:CGRectZero];
    [self addSubview:self.bottomLine];

    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {

        make.leading.trailing.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
}

-(void)setTabCollectionStyle:(TabCollectionStyle)tabCollectionStyle{
    
    _tabCollectionStyle = tabCollectionStyle;
    
    if (self.tabs.count == 0) {
        
        return;
    }
    
    [self layoutIfNeeded];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self setOffsetForSelectionBar:self.selectedIndex animate:NO];
        
    });
    
}

-(void)setSelectedAttribute:(NSDictionary *)selectedAttribute{
    
    _selectedAttribute = selectedAttribute;
    
    _selectionBar.backgroundColor = [self selectedColor];
    
    if (self.tabs.count > 0) {
        
        [self.collectionView reloadData];
    }
}

-(void)setUnSelectedAttribute:(NSDictionary *)unSelectedAttribute{
    
    _unSelectedAttribute = unSelectedAttribute;
    
    if (self.tabs.count > 0) {
        
        [self.collectionView reloadData];
    }
}

-(void)setBottomLineColor:(UIColor *)bottomLineColor{
    
    self.bottomLine.backgroundColor = bottomLineColor;
}

-(UIColor *)bottomLineColor{
    
    return self.bottomLine.backgroundColor;
}

-(UIColor *)selectedColor{
    
    if (!_selectedAttribute) {
        
        return nil;
    }
    
    for (NSAttributedStringKey key in _selectedAttribute.allKeys) {
        
        if ([key isEqualToString:NSForegroundColorAttributeName] && [[_selectedAttribute valueForKey:key] isKindOfClass:UIColor.class]) {
            
            return [_selectedAttribute valueForKey:key];
        }
    }
    
    return nil;
}

-(UIView *)selectionBar{
    
    if (!_selectionBar) {
        
        _selectionBar = [[UIView alloc]initWithFrame:CGRectZero];
        _selectionBar.backgroundColor = self.selectedColor ? self.selectedColor : [UIColor whiteColor];
        [self addSubview:_selectionBar];
        
        [self.selectionBar mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(2);
        }];
    }
    
    return _selectionBar;
}

-(void)setOffsetForSelectionBar:(NSInteger)index animate:(BOOL)animate{
    
    if (self.tabs.count == 0) {
        
        return;
    }
    
    GITabCollectionViewCell *cell = (GITabCollectionViewCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:TAB_COLLECTION_VIEW_CELL forIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    
    CGRect rect = [self.collectionView convertRect:cell.frame toView:self];
    
    [self.selectionBar mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.leading.mas_equalTo(rect.origin.x + 10);
        make.width.mas_equalTo(rect.size.width - 20);
    }];
    
    if (animate) {
     
        [UIView animateWithDuration:0.2 animations:^{
        
            [self layoutIfNeeded];
        }];
    
    }else{
        
        [self layoutIfNeeded];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.tabs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GITabCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TAB_COLLECTION_VIEW_CELL forIndexPath:indexPath];
    
    if (self.tabCollectionStyle == TabCollectionStyleAlignLeft) {
        
        cell.titleLabel.numberOfLines = 1;
    
    }else{
        
        cell.titleLabel.numberOfLines = 0;
    }
    
    NSString *tab = self.tabs[indexPath.row];
    
    NSDictionary *attribute;
    
    
    if (indexPath.row == self.selectedIndex) {
        
        attribute = self.selectedAttribute;
        
    }else{
        
        attribute = self.unSelectedAttribute;
    }
    
    if (attribute) {
        
        cell.titleLabel.attributedText = [[NSAttributedString alloc]initWithString:tab attributes:attribute];

    }else{
        
        cell.titleLabel.text = tab;
    }
    
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    self.selectedIndex = indexPath.row;
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    GITabCollectionViewCell *cell = (GITabCollectionViewCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:TAB_COLLECTION_VIEW_CELL forIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:0]];
    
    CGRect rect = [self.collectionView convertRect:cell.frame toView:self];
    
    [self.selectionBar mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.leading.mas_equalTo(rect.origin.x + 10);
        make.width.mas_equalTo(rect.size.width - 20);
    }];
}

@end
