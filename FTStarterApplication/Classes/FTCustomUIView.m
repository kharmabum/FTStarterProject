//
//  FTCustomUIView.m
//  FTStarterApplication
//
//  Created by Juan-Carlos Foust on 06/03/2013.
//  Copyright (c) 2013 Fototropik. All rights reserved.
//

#import "FTCustomUIView.h"

@interface FTCustomUIView ()

@property (strong, nonatomic) IBOutlet UIView *containerView;

@end

@implementation FTCustomUIView

- (void)setup
{
    
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [[[self class] nibCache] instantiateWithOwner:self options:nil];
    [self addSubview:self.containerView];
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [[[self class] nibCache] instantiateWithOwner:self options:nil];
        [self addSubview:self.containerView];
        [self setup];
    }
    return self;
}

- (void) dealloc
{
}

static UINib *_nib = nil;

+ (UINib *)nibCache
{
    if (!_nib) {
        _nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
    }
    return _nib;
}

+ (void)cacheNib
{
    _nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

@end