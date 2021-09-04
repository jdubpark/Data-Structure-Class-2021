//
//  Item.h
//  MazeDFS
//
//  Created by Park Jong Won on 4/17/21.
//

#ifndef Item_h
#define Item_h

@interface Item : NSObject

@property id object;
@property Item* next;
@property Item* prev;

- (instancetype) initWithObject:(id)object;

@end

#endif /* Item_h */

