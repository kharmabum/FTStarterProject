//
//  FTUI.h
//  FTStarterApplication
//
//  Created by Juan-Carlos Foust on 06/03/2013.
//  Copyright (c) 2013 Fototropik. All rights reserved.
//

#ifndef FTUIREF
#define FTUIREF

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "UIView+FTAdditions.h"
#import "UIView+Layout.h"
#import "UIImage+ImageFromDiskNamed.h"
#import "NSAttributedString+Attributes.h"

#define RGB(r,g,b) ([UIColor colorWithRed:(r)/255. green:(g)/255. blue:(b)/255. alpha:1.0])
#define RGBA(r,g,b,a) ([UIColor colorWithRed:(r)/255. green:(g)/255. blue:(b)/255. alpha:(a)/255.])i

@interface FTUI : NSObject

+ (UIFont *)fontWithName:(NSString *)fontName size:(CGFloat)fontSize;
+ (void)clearFontCache;

+ (UIColor *)colorFromHex:(int)colorInHex;
+ (UIColor *)colorFromHex:(int)colorInHex alpha:(CGFloat)alpha;
+ (void)clearColorCache;

+ (NSString *)ordinalSuffixFromNumber:(NSUInteger)n;

+ (UIBezierPath*)bezierPathWithCurvedShadowForRect:(CGRect)rect withCurve:(CGFloat)curve;
+ (UIImage*)imageWithImage:(UIImage*)sourceImage scaledToSize:(CGSize)newSize;
+ (void)setRoundedView:(UIView *)roundedView toDiameter:(float)newSize;


@end

#endif
