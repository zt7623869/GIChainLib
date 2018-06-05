//
//  UITextView+LengthFit.m
//  GIChainLib
//
//  Created by ZT on 2018/6/5.
//

#import "UITextView+LengthFit.h"
#import <objc/runtime.h>
#import "LenthFit.h"

static char *useFontFitKey = "useFontFitKey";

@implementation UITextView (LengthFit)

- (BOOL)useFontFit{
    
    return [objc_getAssociatedObject(self, useFontFitKey) boolValue];
}

-(void)setUseFontFit:(BOOL)useFontFit{
    
    if (useFontFit) {
        
        self.font = [UIFont fontWithName:self.font.fontName size:fontFit(self.font.pointSize)];
    }
    
    objc_setAssociatedObject(self, useFontFitKey, @(useFontFit), OBJC_ASSOCIATION_ASSIGN);
}

@end
