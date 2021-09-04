//
//  item.h
//  StacksAndQueue
//

#ifndef item_h
#define item_h

@interface Item : NSObject

@property id object;
@property Item *next;

- (instancetype) initWithObject:(id)object;
- (instancetype) initWithObject:(id)object andNextItem:(Item*)item;



@end

#endif /* item_h */
