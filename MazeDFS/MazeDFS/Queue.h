//
//  Queue.h
//  MazeDFS
//

#import "Item.h"

#ifndef Queue_h
#define Queue_h

@interface Queue : NSObject

@property Item* front;
@property Item* back;

- (bool) isEmpty;
- (void) enqueue:(id)object;
- (void) enqueue:(id)object previous:(Item*)previousItem;
- (Item*) dequeue;
- (int) size;
- (void) print;

@end

#endif /* Queue_h */
