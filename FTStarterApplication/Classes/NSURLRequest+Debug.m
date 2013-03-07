//
//  NSURLRequest+Debug.m
//  OneHundredPlus
//
//  Created by Juan-Carlos Foust on 1/28/13.
//  Copyright (c) 2013 100Plus. All rights reserved.
//

#import "NSURLRequest+Debug.h"

@implementation NSURLRequest (Debug)
- (void) logDebugData {
	NSLog(@"Method: %@", self.HTTPMethod);
	NSLog(@"URL: %@", self.URL.absoluteString);
	NSLog(@"Body: %@", [[NSString alloc] initWithData:self.HTTPBody encoding:NSUTF8StringEncoding]);
}
@end
