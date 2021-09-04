//
//  LinkListNode.h
//  LinkedListApp
//
//  Created by Park Jong Won on 4/6/21.
//

#ifndef LinkListNode_h
#define LinkListNode_h

#import <Foundation/Foundation.h>

@class ListNode; // prevent circular import

@interface LinkedList : NSObject
 
@property ListNode *head;

#pragma mark - Required methods

- (void) add:(NSString*)name; // inserts a node at the head of the list

- (void) addNode:(ListNode*)node atIndex:(int)index; // inserts node at an aindex

- (BOOL) isEmpty; //check is the linked list is empty

- (BOOL) isInList:(NSString*)name;

- (void) removeOccurrences;

- (void) clear; //clear the linked list

- (void) print; //print out every element in the list

- (void) deleteNodeAtIndex:(int)index; //removes a node at a given index

- (ListNode*) first; //return the first node of the list

- (ListNode*) last; //return the last node of the list.

- (int) count; // returns the number of items in the list

- (ListNode*) nodeAt:(int)index; // returns a pointer to a node at the given index

- (void) reverse;

#pragma mark - Custom methods

- (void) remove:(NSString*)name;

- (ListNode*) findNodeWithName:(NSString*)name;

- (int) countMyFriends;

- (void) person:(NSString*)name addFriend:(NSString*)friendName;

- (void) person:(NSString*)name removeFriend:(NSString*)friendName;

- (BOOL) isPointerInList:(NSString*)name;

- (ListNode*) traverseToIndex:(int)index;

@end

#endif /* LinkListNode_h */
