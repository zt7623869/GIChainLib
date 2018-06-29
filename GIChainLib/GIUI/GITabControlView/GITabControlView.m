//
//  GITabControlView.m
//  GIChainLib
//
//  Created by ZT on 2018/3/24.
//  Copyright © 2018年 ChuangShiZhiLian. All rights reserved.
//

#import "GITabControlView.h"
#import <Masonry/Masonry.h>
#import "UIViewExt.h"
#import "UIView+Ext.h"

#define CONTAINER_PRE 0
#define CONTAINER_MIDDLE 1
#define CONTAINER_NEXT 2

@interface GITabControlView()<UIScrollViewDelegate,GITabCollectionViewDelegate>

@property (nonatomic,strong) NSMutableArray *contentViews;
@property (nonatomic,strong) NSMutableArray <UIView *>*containers;

@property (nonatomic,copy) UIResponder *(^createContent)(NSInteger index);

@property (nonatomic,assign) NSInteger lastSelected;

@end

@implementation GITabControlView

- (void)awakeFromNib{
    
    [super awakeFromNib];
    
    self.contentViews = [NSMutableArray arrayWithCapacity:0];
    self.containers = [NSMutableArray arrayWithCapacity:0];
    
    [self setupSubViews];
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setupSubViews];
    }
    
    return self;
}

- (void)setupSubViews{
    
    self.lastSelected = -1;
    
    _tabCollectionView = [[GITabCollectionView alloc]initWithFrame:CGRectMake(0, 0, self.width, 30)];
    self.tabCollectionView.delegate = self;

    [self addSubview:self.tabCollectionView];
    
    [self.tabCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.leading.trailing.mas_equalTo(0);
        make.height.mas_equalTo(30);
    }];
    
    _contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.tabCollectionView.bottom, self.width, self.height - self.tabCollectionView.bottom)];
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    self.contentScrollView.showsVerticalScrollIndicator = NO;
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.delegate = self;
    self.contentScrollView.clipsToBounds = YES;
    [self addSubview:self.contentScrollView];
    
    [self.contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.tabCollectionView.mas_bottom);
        make.leading.trailing.bottom.mas_equalTo(0);
    }];
}

-(void)setTabs:(NSArray <NSString *>*)tabs contents:(UIResponder *(^)(NSInteger index))createContent{
    
    _tabCollectionView.tabs = tabs;
    _createContent = createContent;
    
    [self tabSetFinished:tabs];
}

-(void)setTabs:(NSArray *)tabs display:(NSString *(^)(id tab))display contents:(UIResponder *(^)(NSInteger index))createContent{
    
    [_tabCollectionView tabs:tabs display:display];
    _createContent = createContent;
    
    [self tabSetFinished:tabs];
}

- (void)tabSetFinished:(NSArray *)tabs{
    
    [self.contentScrollView removeAllSubviews];
    
    for (int i = 0; i < tabs.count; i++) {
        
        [self.contentViews addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    NSInteger containerNum;
    
    if (tabs.count < 3) {
        
        containerNum = tabs.count;
        
    }else{
        
        containerNum = 3;
    }
    
    for (int i = 0; i < containerNum; i++) {
        
        UIView *container = [[UIView alloc]initWithFrame:CGRectZero];
        [self.contentScrollView addSubview:container];
        [container mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.leading.mas_equalTo(self.contentScrollView.width * i);
            make.trailing.mas_equalTo(self.contentScrollView.width * -(containerNum - 1 - i));
            make.width.mas_equalTo(self.contentScrollView.width);
            make.height.mas_equalTo(self.contentScrollView.mas_height);
        }];
        [self.containers addObject:container];
        
        [self setContentView:i forContainer:i];
    }
    
    [self contentViewDidAppear:0];
}

-(void)setSelectedAttribute:(NSDictionary *)selectedAttribute{
    
    self.tabCollectionView.selectedAttribute = selectedAttribute;
}

-(NSDictionary *)selectedAttribute{
    
    return self.tabCollectionView.selectedAttribute;
}

-(void)setUnSelectedAttribute:(NSDictionary *)unSelectedAttribute{
    
    self.tabCollectionView.unSelectedAttribute = unSelectedAttribute;
}

-(NSDictionary *)unSelectedAttribute{
    
    return self.tabCollectionView.unSelectedAttribute;
}

-(void)setTabCollectionStyle:(TabCollectionStyle)tabCollectionStyle{
    
    self.tabCollectionView.tabCollectionStyle = tabCollectionStyle;
}

-(TabCollectionStyle)tabCollectionStyle{
    
    return self.tabCollectionView.tabCollectionStyle;
}

-(void)setCuttingLineColor:(UIColor *)cuttingLineColor{
    
    self.tabCollectionView.bottomLineColor = cuttingLineColor;
}

-(UIColor *)cuttingLineColor{
    
    return self.tabCollectionView.bottomLineColor;
}

-(NSArray <NSString *>*)tabs{
    
    return self.tabCollectionView.tabs;
}

- (void)moveToContainer:(NSInteger)page animated:(BOOL)animated{
    
    [self.contentScrollView setContentOffset:CGPointMake(self.contentScrollView.width * page, 0) animated:animated];
}

-(void)contentScrollViewDidScroll:(NSInteger)index{
    
    NSInteger currentIndex = self.tabCollectionView.selectedIndex;
    NSInteger count = self.tabs.count;

    if (index == currentIndex) {

        return;
    }
    
    if (count < 3) {
        
        [self moveToContainer:index animated:YES];
        
        return;
    }

    if (currentIndex == 0){

        [self setContentView:index forContainer:CONTAINER_MIDDLE];
        [self moveToContainer:CONTAINER_MIDDLE animated:YES];

    }else if (currentIndex == count - 1){

        [self setContentView:index forContainer:CONTAINER_MIDDLE];
        [self moveToContainer:CONTAINER_MIDDLE animated:YES];

    }else{

        if (index < currentIndex) {

            [self setContentView:index forContainer:CONTAINER_PRE];
            [self moveToContainer:CONTAINER_PRE animated:YES];

        }else if (index > currentIndex) {

            [self setContentView:index forContainer:CONTAINER_NEXT];
            [self moveToContainer:CONTAINER_NEXT animated:YES];
        }
    }
}

- (void)resetContentViews{
    
    NSInteger currentIndex = self.tabCollectionView.selectedIndex;
    NSInteger count = self.tabs.count;
    
    if (count < 3) {
        
        return;
    }
    
    if (currentIndex == 0) {

        [self setContentView:currentIndex + 1 forContainer:CONTAINER_MIDDLE];
        [self setContentView:currentIndex + 2 forContainer:CONTAINER_NEXT];
        
        if (self.contentScrollView.contentOffset.x == self.contentScrollView.width) {
            
            [self setContentView:currentIndex forContainer:CONTAINER_PRE];
            
            [self moveToContainer:CONTAINER_PRE animated:NO];
        }

    }else if (currentIndex == count - 1) {

        [self setContentView:currentIndex - 1 forContainer:CONTAINER_MIDDLE];
        [self setContentView:currentIndex - 2 forContainer:CONTAINER_PRE];
        
        if (self.contentScrollView.contentOffset.x == self.contentScrollView.width) {
            
            [self setContentView:currentIndex forContainer:CONTAINER_NEXT];
            
            [self moveToContainer:CONTAINER_NEXT animated:NO];
        }

    }else{

        [self setContentView:currentIndex - 1 forContainer:CONTAINER_PRE];
        [self setContentView:currentIndex forContainer:CONTAINER_MIDDLE];
        [self setContentView:currentIndex + 1 forContainer:CONTAINER_NEXT];

        [self moveToContainer:CONTAINER_MIDDLE animated:NO];
    }
    
    [self contentViewDidAppear:currentIndex];
}

- (void)setContentView:(NSInteger)index forContainer:(NSInteger)page{
    
    UIView *container = self.containers[page];
    [container removeAllSubviews];
    UIView *view = [self getContentViewByIndex:index];
    [container addSubview:view];
    
    [view mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (UIView *)getContentViewByIndex:(NSInteger)index{
    
    UIResponder *contentView;
    
    if (![self.contentViews[index] isKindOfClass:UIResponder.class]) {
        
        contentView = [self createContentView:index];
        
        [self.contentViews replaceObjectAtIndex:index withObject:contentView];
        
    }else{
        
        contentView = self.contentViews[index];
    }
    
    if ([contentView isKindOfClass:UIViewController.class]) {
        
        return ((UIViewController *)contentView).view;
        
    }else if([contentView isKindOfClass:UIView.class]){
        
        return (UIView *)contentView;
    }
    
    return nil;
}

-(UIResponder *)createContentView:(NSInteger)index{
    
    UIResponder *content = self.createContent(index);
    
    if ([content.class isSubclassOfClass:UIViewController.class]) {
        
        UIViewController *controller = (UIViewController *)content;

        controller.view.frame = CGRectMake(0, 0, self.contentScrollView.width, self.contentScrollView.height);
        content = controller;
        
    }
    
    return content;
}

- (void)contentViewDidAppear:(NSInteger)index{
    
    if (index == self.lastSelected) {
        
        return;
    }
    
    id<GITabControlViewDelegate> contentView = self.contentViews[index];
    
    if ([contentView respondsToSelector:@selector(didAppearInTabControlView:)]) {
        
        [contentView didAppearInTabControlView:self];
    }
    
    if (self.lastSelected >= 0) {
        
        id<GITabControlViewDelegate> contentView = self.contentViews[self.lastSelected];
        
        if ([contentView respondsToSelector:@selector(didDisappearInTabControlView:)]) {
            
            [contentView didDisappearInTabControlView:self];
        }
    }
    
    self.lastSelected = index;
    

}

#pragma mark - GITabCollectionViewDelegate

-(void)tabCollectionView:(GITabCollectionView *)tabCollectionView didSelectItem:(NSString *)item atIndex:(NSInteger)index{
    
    [self contentScrollViewDidScroll:index];
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger currentIndex = self.tabCollectionView.selectedIndex;
    NSInteger count = self.tabs.count;
    NSInteger containerNum;
    
    if (count < 3) {
        
        containerNum = count;
        
    }else{
        
        containerNum = 3;
    }
    
    if (currentIndex == 0) {
        
        [self.tabCollectionView setSelectedIndex:currentIndex + self.contentScrollView.contentOffset.x / self.contentScrollView.width animate:YES];
        
    }else if (currentIndex == count - 1) {
        
        [self.tabCollectionView setSelectedIndex:currentIndex - (containerNum - 1 -self.contentScrollView.contentOffset.x / self.contentScrollView.width) animate:YES];
        
    }else{
        
        [self.tabCollectionView setSelectedIndex:currentIndex + self.contentScrollView.contentOffset.x / self.contentScrollView.width - 1 animate:YES];
    }
    
    [self resetContentViews];

}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    [self resetContentViews];
}

@end
