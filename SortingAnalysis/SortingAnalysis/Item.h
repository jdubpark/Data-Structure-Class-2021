//
//  item.h
//  StacksAndQueue
//

#ifndef item_h
#define item_h

@interface Item : NSObject

@property int value;
@property Item *next;

- (instancetype) initWithInt:(int)number;

@end

#endif /* item_h */
