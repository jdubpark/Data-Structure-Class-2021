//
//  ListNode.m
//  LinkedList-API
//
//  Created by Park Jong Won on 4/6/21.
//

#import <Foundation/Foundation.h>

@interface ListNode : NSObject

@property  int object;

@property ListNode *next;

- (instancetype)initWithObject:(int)object;

- (instancetype)initWithObject:(int)object andNextNode:(ListNode *)node;

- (instancetype)init;


@end
