#import <Foundation/Foundation.h>

typedef enum
{
	UIViewHorizontalAlignmentCenter = 0,
	UIViewHorizontalAlignmentLeft = 1,
    UIViewHorizontalAlignmentRight = 2
} UIViewHorizontalAlignment;

typedef enum
{
	UIViewVerticalAlignmentMiddle = 0,
	UIViewVerticalAlignmentTop = 1,
	UIViewVerticalAlignmentBottom = 2
} UIViewVerticalAlignment;

@interface UIView (FTAdditions)

@property (nonatomic, assign) CGFloat xOrigin;
@property (nonatomic, assign) CGFloat yOrigin;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

#pragma mark - UIView+SSToolkitAdditions


///-------------------------
/// @name Taking Screenshots
///-------------------------

/**
 Takes a screenshot of the underlying `CALayer` of the receiver and returns a `UIImage` object representation.
 
 @return An image representing the receiver
 */
- (UIImage *)imageRepresentation;


///-------------------------
/// @name Hiding and Showing
///-------------------------

/**
 Sets the `alpha` value of the receiver to `0.0`.
 */
- (void)hide;

/**
 Sets the `alpha` value of the receiver to `1.0`.
 */
- (void)show;


///------------------------
/// @name Fading In and Out
///------------------------

/**
 Fade out the receiver.
 
 The receiver will fade out in `0.2` seconds.
 */
- (void)fadeOut;

/**
 Fade out the receiver and remove from its super view
 
 The receiver will fade out in `0.2` seconds and be removed from its `superview` when the animation completes.
 */
- (void)fadeOutAndRemoveFromSuperview;

/**
 Fade in the receiver.
 
 The receiver will fade in in `0.2` seconds.
 */
- (void)fadeIn;


///----------------------------------
/// @name Managing the View Hierarchy
///----------------------------------

/**
 Returns an array of the receiver's superviews.
 
 The immediate super view is the first object in the array. The outer most super view is the last object in the array.
 
 @return An array of view objects containing the receiver
 */
- (NSArray *)superviews;

/**
 Returns the first super view of a given class.
 
 If a super view is not found for the given `superviewClass`, `nil` is returned.
 
 @param superviewClass A Class to search the `superviews` for
 
 @return A view object or `nil`
 */

#pragma mark - Layout

- (void)alignHorizontally: (UIViewHorizontalAlignment)horizontalAlignment;
- (void)alignVertically: (UIViewVerticalAlignment)verticalAlignment;
- (void)alignHorizontally: (UIViewHorizontalAlignment)horizontalAlignment
               vertically: (UIViewVerticalAlignment)verticalAlignment;

- (void)removeAllSubviews;

- (id)firstSuperviewOfClass:(Class)superviewClass;

#pragma mark - Static Methods

+ (void)animateIf: (BOOL)condition
         duration: (NSTimeInterval)duration
            delay: (NSTimeInterval)delay
          options: (UIViewAnimationOptions)options
       animations: (void (^)(void))animations
       completion: (void (^)(BOOL finished))completion;

@end