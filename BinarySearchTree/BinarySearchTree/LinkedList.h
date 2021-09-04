//
//  LinkListNode.h
//  LinkedList-API
//
//  Created by Park Jong Won on 4/6/21.
//

#ifndef LinkListNode_h
#define LinkListNode_h

#import <Foundation/Foundation.h>

#import "ListNode.h"


@interface LinkedList : NSObject
 
@property ListNode *head;

- (void) addObject:(NSNumber*)object; // adds a Node (containing the object) to the end

- (int) count;

- (BOOL) isEmpty; //check is the linked list is empty

@end

#endif /* LinkListNode_h */
