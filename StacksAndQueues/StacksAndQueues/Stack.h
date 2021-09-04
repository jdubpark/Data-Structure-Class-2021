//
//  stack.h
//  StacksAndQueue
//

#import "Item.h"

#ifndef stack_h
#define stack_h

@interface Stack : NSObject

@property Item* top;

- (bool) isEmpty;
- (void) push:(id)object;
- (Item*) pop;
- (int) size;
- (void) print;

+ (int) TwoStack:(NSString*)expression;

@end

#endif /* stack_h */
