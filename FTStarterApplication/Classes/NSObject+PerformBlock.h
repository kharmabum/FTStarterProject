#import <Foundation/Foundation.h>

@interface NSObject (PerformBlock)

- (void)performBlock: (dispatch_block_t)block 
          afterDelay: (NSTimeInterval)delay;

- (void)performBlockOnMainThread: (dispatch_block_t)block;
- (void)performBlockOnMainThread: (dispatch_block_t)block
                      afterDelay: (NSTimeInterval)delay;

- (void)performBlockInBackground: (dispatch_block_t)block;

@end