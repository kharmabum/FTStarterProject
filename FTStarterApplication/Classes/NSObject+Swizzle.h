//
//  NSObject+Swizzle.h
//  OneHundredPlus
//
//  Created by Juan-Carlos Foust on 27/02/2013.
//  Copyright (c) 2013 100Plus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzle)

+ (void)swizzleInstanceSelector:(SEL)originalSelector
                withNewSelector:(SEL)newSelector;

@end