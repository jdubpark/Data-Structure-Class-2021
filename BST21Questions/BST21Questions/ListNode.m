//
//  ListNode.m
//  LinkedList-API
//
//  Created by Park Jong Won on 4/6/21.
//

#import <Foundation/Foundation.h>
#import "ListNode.h"

@implementation ListNode

- (instancetype) initWithObject:(NSNumber*)object {
	self = [super init];
	if (self) {
		self.object = object;
	}
	return self;
}

@end
