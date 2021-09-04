//
//  Item.m
//  MazeDFS
//
//  Created by Park Jong Won on 4/17/21.
//

#import <Foundation/Foundation.h>
#import "Item.h"

@implementation Item

- (instancetype)initWithObject:(id)object {
	self = [super init];
	if (self) {
		self.object = object;
	}
	return self;
}

- (instancetype)initWithObject:(id)object andNextItem:(Item*)node {
	self = [super init];
	if (self) {
		self.object = object;
		self.next = node;
	}
	return self;
}

@end
