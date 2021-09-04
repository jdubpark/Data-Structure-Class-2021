//
//  Queue.h
//  StacksAndQueue
//

#import "Item.h"

#ifndef Queue_h
#define Queue_h

@interface Queue : NSObject

@property Item* front;
@property Item* back;

- (bool) isEmpty;
- (void) enqueue:(id)item;
- (Item*) dequeue;
- (int) size;
- (void) print;

//The method should take S and N as inputs and display on the console the order which people are eliminated, S is the skip space of the elimination, and N is the number of people.  The output would show where Josephus should sit (assuming he wishes to avoid elimination).

+ (void) Josephus:(int)numberOfPeople skipSpace:(int)skipSpace;

@end

#endif /* Queue_h */
