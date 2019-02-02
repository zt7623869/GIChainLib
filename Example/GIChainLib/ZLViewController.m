//
//  ZLViewController.m
//  GIChainLib
//
//  Created by zt7623869 on 05/21/2018.
//  Copyright (c) 2018 zt7623869. All rights reserved.
//

#import "ZLViewController.h"
#import "ZLNetworkManager.h"
#import <GIChainLib/GICategory.h>
#import <GIChainLib/LenthFit.h>

@interface ZLViewController ()

@end

@implementation ZLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    CGFloat x = lengthFit(100);
//    lengthFitReference = iPhone6pScreen;
//    CGFloat y = lengthFit(100);
//    NSLog(@"x=%f,y=%f",x,y);
    
    
    [[ZLNetworkManager createRequestWithMethod:@"GET" url:@"index/indexValue" param:@{} cache:NO delegate:nil] success:^(id<TZNetworkResultProtocol> requestResult) {
        
    } failure:^(id<TZNetworkResultProtocol> requestResult) {

    }];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
