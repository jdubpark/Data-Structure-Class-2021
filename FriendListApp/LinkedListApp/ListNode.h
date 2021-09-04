//
//  ListNode.m
//  LinkedListApp
//
//  Created by Park Jong Won on 4/6/21.
//

#import <Foundation/Foundation.h>

@class LinkedList; // prevent circular import

@interface ListNode : NSObject

@property NSString *name;

@property ListNode *next;

@property ListNode *pointer; // only used for friend groups' friend

@property LinkedList *friendPointers;

- (instancetype)initWithName:(NSString*)name;

- (instancetype)initWithPointer:(ListNode*)pointer;

- (instancetype)init;


@end
