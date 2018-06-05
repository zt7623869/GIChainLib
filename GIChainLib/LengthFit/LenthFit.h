//
//  LenthFitTools.h
//  Pods
//
//  Created by ZT on 2018/6/1.
//

#import "NSLayoutConstraint+LengthFit.h"
#import "UILabel+LengthFit.h"
#import "UITextField+LengthFit.h"
#import "UITextView+LengthFit.h"
#import "UIButton+LengthFit.h"
#import "UIView+Circle.h"


typedef enum : NSUInteger {
    iPhone4Screen = 0,
    iPhone5Screen,
    iPhone6Screen,
    iPhone6pScreen,
    iPhoneXScreen
} ScreenModel;

static ScreenModel lengthFitReference = iPhone6Screen;

static inline float lengthFit(float length)
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        
    switch (lengthFitReference) {
            
        case iPhone4Screen:
        case iPhone5Screen:

            return length *screenWidth/320.0f;
            break;
            
        case iPhone6Screen:
        case iPhoneXScreen:
            
            return length *screenWidth/375.0f;
            break;
            
        case iPhone6pScreen:
            
            return length *screenWidth/414.0f;
            break;
            
        default:
            
            return length;
            break;
    }
}

static inline float fontFit(float font)
{
    return lengthFit(font);
}

