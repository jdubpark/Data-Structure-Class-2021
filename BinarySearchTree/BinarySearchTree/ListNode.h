//
//  ListNode.m
//  LinkedList-API
//
//  Created by Park Jong Won on 4/6/21.
//

#import <Foundation/Foundation.h>

@interface ListNode : NSObject

@property NSNumber* object;
@property ListNode *next;

- (instancetype) initWithObject:(id)object;


@end
