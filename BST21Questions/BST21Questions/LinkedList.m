//
//  LinkedList.m
//  LinkedList-API
//
//  Created by Park Jong Won on 4/6/21.
//

#import <Foundation/Foundation.h>
#import "LinkedList.h"
#import "ListNode.h"

@implementation LinkedList

- (void) addNumber:(NSNumber*)object {
	ListNode *newNode = [[ListNode alloc] initWithObject:object];
    
    if (self.head == nil) {
        self.head = newNode;
    } else {
        ListNode* finalNode = self.head;
        while (finalNode.next != nil) {
            finalNode = finalNode.next;
        }
        
        finalNode.next = newNode;
    }
}

- (int) count {
    int n = 0;
    ListNode* node = self.head;
    while (node != nil) {
        n += 1;
        node = node.next;
    }
    return n;
}

- (BOOL) isEmpty {
	return self.head == nil;
}

@end
