//
//  UIView+Circle.m
//  GIChainLib
//
//  Created by ZT on 2018/6/5.
//

#import "UIView+Circle.h"
#import <objc/runtime.h>
#import "LenthFit.h"
#import "NSLayoutConstraint+LengthFit.h"

static char *circleKey = "circleKey";

@implementation UIView (Circle)

- (BOOL)circle{
    
    return [objc_getAssociatedObject(self, circleKey) boolValue];
}

-(void)setCircle:(BOOL)circle{
    
    NSArray *constraints = self.constraints;
    
    BOOL useLengthFit = NO;
    
    for (NSLayoutConstraint *constraint in constraints) {
        
        if ((constraint.firstAttribute == NSLayoutAttributeWidth && constraint.secondAttribute == NSLayoutAttributeNotAnAttribute) || (constraint.firstAttribute == NSLayoutAttributeHeight && constraint.secondAttribute == NSLayoutAttributeNotAnAttribute)) {
            
            if (constraint.useLengthFit == YES) {
                
                useLengthFit = YES;
                break;
            }
        }
    }
    
    if (useLengthFit) {
        
        self.layer.cornerRadius = lengthFit(self.frame.size.width) * 0.5f;
        
    }else{
        
        self.layer.cornerRadius = self.frame.size.width * 0.5f;
    }
    self.layer.masksToBounds = circle;
    
    objc_setAssociatedObject(self, circleKey, @(circle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
