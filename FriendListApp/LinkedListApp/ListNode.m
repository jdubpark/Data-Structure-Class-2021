//
//  ListNode.m
//  LinkedListApp
//
//  Created by Park Jong Won on 4/6/21.
//

#import <Foundation/Foundation.h>
#import "LinkedList.h"
#import "ListNode.h"

@implementation ListNode

- (instancetype)initWithName:(NSString*)name {
	self = [super init];
	if (self) {
		self.name = name;
		self.friendPointers = [[LinkedList alloc] init];
	}
	return self;
}

- (instancetype)initWithPointer:(ListNode*)pointer {
	self = [super init];
	if (self) {
		self.pointer = pointer;
	}
	return self;
}

- (instancetype)init{
	self = [super init];
	return self;
}

@end
