#import "NSArray+Accessing.h"

@implementation NSArray (Accessing)

- (id)firstObject
{
	id firstObject = nil;
	if (self.count) {
		firstObject = [self objectAtIndex: 0];
	}
	return firstObject;
}

- (id)randomObject
{
	return [self objectAtIndex:arc4random_uniform([self count])];
}

- (id)tryObjectAtIndex: (NSUInteger)index
{
	id object = nil;
	if (index < [self count]) {
		object = [self objectAtIndex: index];
	}
	return object;
}

@end
