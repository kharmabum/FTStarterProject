#import "NSURLRequest+Debug.h"

@implementation NSURLRequest (Debug)
- (void) logDebugData {
	NSLog(@"Method: %@", self.HTTPMethod);
	NSLog(@"URL: %@", self.URL.absoluteString);
	NSLog(@"Body: %@", [[NSString alloc] initWithData:self.HTTPBody encoding:NSUTF8StringEncoding]);
}

@end
