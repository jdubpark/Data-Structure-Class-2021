//
//  item.h
//  StacksAndQueue
//

#ifndef item_h
#define item_h

@interface Item : NSObject

@property id object;
@property Item* next;
@property Item* prev;

- (instancetype) initWithObject:(id)object;

@end

#endif /* item_h */
