//
//  NSObject+Swizzle.m
//  OneHundredPlus
//
//  Created by Juan-Carlos Foust on 27/02/2013.
//  Copyright (c) 2013 100Plus. All rights reserved.
//

#import "NSObject+Swizzle.h"
#import <objc/runtime.h>

@implementation NSObject (Swizzle)

+ (void) swizzleInstanceSelector:(SEL)originalSelector
                 withNewSelector:(SEL)newSelector
{
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method newMethod = class_getInstanceMethod(self, newSelector);
    
    BOOL methodAdded = class_addMethod([self class],
                                       originalSelector,
                                       method_getImplementation(newMethod),
                                       method_getTypeEncoding(newMethod));
    
    if (methodAdded) {
        class_replaceMethod([self class],
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, newMethod);
    }
}

@end