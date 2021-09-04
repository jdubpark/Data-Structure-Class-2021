//
//  Node.m
//  BinarySearchTree
//
//  Created by Park Jong Won on 4/29/21.
//

#import <Foundation/Foundation.h>
#import "Node.h"

@implementation Node

- (instancetype) initWithKey:(NSString*)key {
	self = [super init];
	if (self) {
		self.key = key;
        self.isQuestion = false;
	}
	return self;
}

- (bool) hasNoChild {
	return ![self hasAnyChild];
}

- (bool) hasAnyChild {
	return self.leftChild != nil || self.rightChild != nil;
}

- (bool) hasOneChild {
	// logical XOR (!! converts vars to bool)
	return !!self.leftChild != !!self.rightChild;
}

@end
