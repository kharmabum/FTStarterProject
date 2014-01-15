#import "UIView+Animations.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (FTAdditions)

#pragma mark - SSToolKitAdditions

- (UIImage *)imageRepresentation {
	UIGraphicsBeginImageContext(self.bounds.size);
	[self.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}


- (void)hide {
	self.alpha = 0.0f;
}


- (void)show {
	self.alpha = 1.0f;
}


- (void)fadeOut {
	UIView *view = self;
	[UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
		view.alpha = 0.0f;
	} completion:nil];
}


- (void)fadeOutAndRemoveFromSuperview {
	UIView *view = self;
	[UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
		view.alpha = 0.0f;
	} completion:^(BOOL finished) {
		[view removeFromSuperview];
	}];
}


- (void)fadeIn {
	UIView *view = self;
	[UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
		view.alpha = 1.0f;
	} completion:nil];
}


- (NSArray *)superviews {
	NSMutableArray *superviews = [[NSMutableArray alloc] init];
	
	UIView *view = self;
	UIView *superview = nil;
	while (view) {
		superview = [view superview];
		if (!superview) {
			break;
		}
		
		[superviews addObject:superview];
		view = superview;
	}
	
	return superviews;
}

- (id)firstSuperviewOfClass:(Class)superviewClass {
	for (UIView *view = [self superview]; view != nil; view = [view superview]) {
		if ([view isKindOfClass:superviewClass]) {
			return view;
		}
	}
	return nil;
}

#pragma mark - Layout

- (CGFloat)xOrigin
{
	CGFloat xOrigin = self.center.x - (self.width / 2.0f);
	
	return xOrigin;
}

- (void)setXOrigin: (CGFloat)xOrigin
{
	CGPoint viewCenter = self.center;
	
	// floor the x origin to avoid subpixel rendering
	viewCenter.x = floor(xOrigin) + (self.width / 2.0f);
	
	self.center = viewCenter;
}

- (CGFloat)yOrigin
{
	CGFloat yOrigin = self.center.y - (self.height / 2.0f);
	
	return yOrigin;
}

- (void)setYOrigin: (CGFloat)yOrigin
{
	CGPoint viewCenter = self.center;
	
	// floor the y origin to avoid subpixel rendering
	viewCenter.y = floorf(yOrigin) + (self.height / 2.0f);
	
	self.center = viewCenter;
}

- (CGFloat)width
{
	CGFloat width = self.bounds.size.width;
	
	return width;
}

- (void)setWidth: (CGFloat)width
{
	// because changing the width of a view through its bounds updates the x origin we need to track the previous value and set it after the bounds have been changed
	CGFloat previousXOrigin = self.xOrigin;
	
	CGRect viewBounds = self.bounds;
	
	// floor the width to avoid subpixel rendering
	viewBounds.size.width = floorf(width);
	
	self.bounds = viewBounds;
	
	self.xOrigin = previousXOrigin;
}

- (CGFloat)height
{
	CGFloat height = self.bounds.size.height;
	
	return height;
}

- (void)setHeight: (CGFloat)height
{
	// because changing the height of a view through its bounds updates the y origin we need to track the previous value and set it after the bounds have been changed
	CGFloat previousYOrigin = self.yOrigin;
	
	CGRect viewBounds = self.bounds;
	
	// floor the height to avoid subpixel rendering
	viewBounds.size.height = floorf(height);
	
	self.bounds = viewBounds;
	
	self.yOrigin = previousYOrigin;
}

- (void)alignHorizontally: (UIViewHorizontalAlignment)horizontalAlignment
{
	if (self.superview == nil)
	{
		return;
	}
	
	switch (horizontalAlignment)
	{
		case UIViewHorizontalAlignmentCenter:
		{
			self.xOrigin = (self.superview.width - self.width) / 2.0f;
			
			break;
		}
            
		case UIViewHorizontalAlignmentLeft:
		{
			self.xOrigin = 0.0f;
			
			break;
		}
            
		case UIViewHorizontalAlignmentRight:
		{
			self.xOrigin = self.superview.width - self.width;
			
			break;
		}
	}
}

- (void)alignVertically: (UIViewVerticalAlignment)verticalAlignment
{
	if (self.superview == nil)
	{
		return;
	}
	
	switch (verticalAlignment)
	{
		case UIViewVerticalAlignmentMiddle:
		{
			self.yOrigin = (self.superview.height - self.height) / 2.0f;
			
			break;
		}
            
		case UIViewVerticalAlignmentTop:
		{
			self.yOrigin = 0.0;
			
			break;
		}
            
		case UIViewVerticalAlignmentBottom:
		{
			self.yOrigin = self.superview.height - self.height;
			
			break;
		}
	}
}

- (void)alignHorizontally: (UIViewHorizontalAlignment)horizontalAlignment
               vertically: (UIViewVerticalAlignment)verticalAlignment
{
	[self alignHorizontally: horizontalAlignment];
	[self alignVertically: verticalAlignment];
}

- (void)removeAllSubviews
{
	[self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
}

#pragma mark - Static Methods

+ (void)animateIf: (BOOL)condition
         duration: (NSTimeInterval)duration
            delay: (NSTimeInterval)delay
          options: (UIViewAnimationOptions)options
       animations: (void (^)(void))animations
       completion: (void (^)(BOOL finished))completion
{
	if (condition == YES)
	{
		[UIView animateWithDuration: duration 
			delay: delay 
			options: options 
			animations: animations 
			completion: completion];
	}
	else
	{
		if (animations != nil)
		{
			animations();
		}
		
		if (completion != nil)
		{
			completion(NO);
		}
	}
}

@end