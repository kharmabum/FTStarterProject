//
//  FTUITableViewCell.m
//  FTStarterApplication
//
//  Created by Juan-Carlos Foust on 06/03/2013.
//  Copyright (c) 2013 Fototropik. All rights reserved.
//

#import "FTUITableViewCell.h"

static UIImage *_placeholderImage = nil;

@interface FTUITableViewCell ()
@property (strong, nonatomic)  UIImage *placeHolderImage;
@end

@implementation FTUITableViewCell

@dynamic placeHolderImage;

- (UIImage *)placeholderImage
{
    if (!_placeholderImage) {
        _placeholderImage = [UIImage imageNamed:@"<#image-name#>.png"];
    }
    return _placeholderImage;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
}

- (void)setup
{
    
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

+ (CGFloat)heightForInfo:(NSDictionary *)info
{
    CGFloat height = 0;
    //calculate height
    return height;
}

@end
