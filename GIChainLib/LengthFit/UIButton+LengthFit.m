//
//  UIButton+LengthFit.m
//  AFNetworking
//
//  Created by ZT on 2018/6/5.
//

#import "UIButton+LengthFit.h"
#import <objc/runtime.h>
#import "LenthFit.h"

static char *useFontFitKey = "useFontFitKey";

@implementation UIButton (LengthFit)

- (BOOL)useFontFit{
    
    return [objc_getAssociatedObject(self, useFontFitKey) boolValue];
}

-(void)setUseFontFit:(BOOL)useFontFit{
    
    if (useFontFit) {
        
        self.titleLabel.font = [UIFont fontWithName:self.titleLabel.font.fontName size:fontFit(self.titleLabel.font.pointSize)];
    }
    
    objc_setAssociatedObject(self, useFontFitKey, @(useFontFit), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
