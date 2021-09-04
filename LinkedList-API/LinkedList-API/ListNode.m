//
//  ListNode.m
//  LinkedList-API
//
//  Created by Park Jong Won on 4/6/21.
//

#import <Foundation/Foundation.h>
#import "ListNode.h"

@implementation ListNode

- (instancetype)initWithObject:(int)object {
	self = [super init];
	if (self) {
		self.object = object;
	}
	return self;
}

- (instancetype)initWithObject:(int)object andNextNode:(ListNode *)node {
	self = [super init];
	if (self) {
		self.object = object;
		self.next = node;
	}
	return self;
}

- (instancetype)init{
	return self;
}

@end
