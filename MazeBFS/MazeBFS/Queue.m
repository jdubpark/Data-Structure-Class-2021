//
//  Queue.m
//  MazeDFS
//

#import <Foundation/Foundation.h>
#import "Queue.h"
#import "Item.h"

@implementation Queue // FIFO (First In, First Out --> Item is added to last and taken out last)

- (id) init {
	self = [super init];
	return self;
}

- (bool) isEmpty {
	return self.front == nil;
}

- (int) size {
	int count = 0;
	Item* tmp = self.front;
	if (self.front != nil) {
		count++;
	}
	while (tmp.next != nil) {
		tmp = tmp.next;
		count++;
	}
	return count;
}

- (void) enqueue:(id)object {
	// add as the first
	if ([self isEmpty]) {
		self.front = [[Item alloc] initWithObject:object];
		self.back = self.front;
	} else {
		Item* newItem = [[Item alloc] initWithObject:object];
		Item* tmp = self.back;
		self.back = newItem;
		tmp.next = self.back;
	}
}

- (void) enqueue:(id)object previous:(Item*)previousItem {
	// add as the first
	if ([self isEmpty]) {
		self.front = [[Item alloc] initWithObject:object];
		self.back = self.front;
	} else {
		Item* newItem = [[Item alloc] initWithObject:object];
		Item* tmp = self.back;
		
		// first -> second -> ... -> tmp (old back) -> newItem (new back)
		// tmp.next = newItem
		// newItem.prev = previousItem
		newItem.prev = previousItem;
		self.back = newItem;
		tmp.next = self.back;
	}
}

- (Item*) dequeue {
	// remove the first
	Item* tmp = self.front;
	self.front = tmp.next;
	if (self.front == nil) {
		self.front = self.back;
	}
	return tmp;
}

- (void) print {
	Item* tmp = self.front;
	NSLog(@"%@",tmp.object);
	while (tmp.next != nil) {
		tmp = tmp.next;
		NSLog(@"%@",tmp.object);
	}
}


@end

