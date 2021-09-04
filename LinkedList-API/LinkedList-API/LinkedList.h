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

- (void) add:(int)object; // inserts a node at the head of the list

- (void) addNode:(ListNode*)node atIndex:(int)index; // inserts node at an aindex

- (void) addObject:(int)object atIndex:(int)index; // adds a value at an index

- (BOOL) isEmpty; //check is the linked list is empty

- (BOOL) isInList:(int)object;

- (void) removeOccurrences;

- (void) clear; //clear the linked list

- (void) print; //print out every element in the list

- (void) deleteNodeAtIndex:(int)index; //removes a node at a given index

- (ListNode*) traverseToIndex:(int)index;

- (ListNode*) first; //return the first node of the list

- (ListNode*) last; //return the last node of the list.

- (int) count; // returns the number of items in the list

- (ListNode*) nodeAt:(int)index; // returns a pointer to a node at the given index

- (void) reverse;

@end

#endif /* LinkListNode_h */
