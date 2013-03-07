//
//  FTUI.m
//  FTStarterApplication
//
//  Created by Juan-Carlos Foust on 06/03/2013.
//  Copyright (c) 2013 Fototropik. All rights reserved.
//

#import "FTUI.h"

static NSMutableDictionary *_fontsByNameAndSize = nil;
static NSMutableDictionary *_colorsByHex = nil;

@implementation FTUI

+ (UIFont *)fontWithName:(NSString *)fontName size:(CGFloat)fontSize
{
    if (!_fontsByNameAndSize) _fontsByNameAndSize = [NSMutableDictionary dictionary];
        
    NSString *key = [NSString stringWithFormat:@"%@-%f", fontName, fontSize];
    UIFont *font = [_fontsByNameAndSize objectForKey:key];
    
    if (!font) {
        font = [UIFont fontWithName:fontName size:fontSize];
        [_fontsByNameAndSize setObject:font forKey:key];
    }
    
    return font;
}

+ (void)clearFontCache
{
    _fontsByNameAndSize = nil;
}

+ (UIColor *)colorFromHex:(int)colorInHex alpha:(CGFloat)alpha;
{
    if (!_colorsByHex) _colorsByHex = [NSMutableDictionary dictionary];
    
    NSString *key = [NSString stringWithFormat:@"%x", colorInHex];
    UIColor *color = [_colorsByHex objectForKey:key];
    
    if (!color) {
        float red = (float) ((colorInHex & 0xFF0000) >> 16) / 255.0f;
        float green = (float) ((colorInHex & 0x00FF00) >> 8) / 255.0f;
        float blue = (float) ((colorInHex & 0x000FF) >> 0) / 255.0f;
        color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
        [_colorsByHex setObject:color forKey:key];
    }
    
    return color;
}

+ (UIColor *)colorFromHex:(int)colorInHex
{
    return [FTUI colorFromHex:colorInHex alpha:1.0];
}

+ (void)clearColorCache
{
    _colorsByHex = nil;
}

+ (NSString *)ordinalSuffixFromNumber:(NSUInteger)n
{
    if (n == 11 || n == 12 || n == 13)
    {
        return @"th";
    }
    
    n = n % 10;
    
    switch (n) {
        case 1:
            return @"st";
            
        case 2:
            return @"nd";
            
        case 3:
            return @"rd";
            
        default:
            return @"th";
    }
}

static const CGFloat offset = 1.5;
+ (UIBezierPath*)bezierPathWithCurvedShadowForRect:(CGRect)rect withCurve:(CGFloat)curve {
	
	UIBezierPath *path = [UIBezierPath bezierPath];
	
	CGPoint topLeft		 = rect.origin;
	CGPoint bottomLeft	 = CGPointMake(0.0, CGRectGetHeight(rect) + offset);
	CGPoint bottomMiddle = CGPointMake(CGRectGetWidth(rect)/2, CGRectGetHeight(rect) - curve);
	CGPoint bottomRight	 = CGPointMake(CGRectGetWidth(rect), CGRectGetHeight(rect) + offset);
	CGPoint topRight	 = CGPointMake(CGRectGetWidth(rect), 0.0);
	
	[path moveToPoint:topLeft];
	[path addLineToPoint:bottomLeft];
	[path addQuadCurveToPoint:bottomRight controlPoint:bottomMiddle];
	[path addLineToPoint:topRight];
	[path addLineToPoint:topLeft];
	[path closePath];
	return path;
}

+ (UIImage*)imageWithImage:(UIImage*)sourceImage scaledToSize:(CGSize)newSize;
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [sourceImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

+ (void)setRoundedView:(UIView *)roundedView toDiameter:(float)newSize;
{
    CGPoint saveCenter = roundedView.center;
    CGRect newFrame = CGRectMake(roundedView.frame.origin.x, roundedView.frame.origin.y, newSize, newSize);
    roundedView.frame = newFrame;
    roundedView.layer.cornerRadius = newSize / 2.0;
    roundedView.center = saveCenter;
}
@end
