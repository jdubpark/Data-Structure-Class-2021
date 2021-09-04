//
//  stack.m
//  StacksAndQueue
//

#import <Foundation/Foundation.h>
#import "Stack.h"
#import "Item.h"

@implementation Stack // LIFO (Last In, First Out --> Item is added as first and taken out first)

- (id) init {
	self = [super init];
	return self;
}

- (bool) isEmpty {
	return self.top == nil;
}

- (int) size {
	int count = 0;
	Item *tmp = self.top;
	while (tmp.next != nil) {
		tmp = tmp.next;
		count++;
	}
	return count;
}

- (void) push:(int)number {
	Item *item = [[Item alloc] initWithInt:number];
	Item *tmp = self.top;
	self.top = item;
	self.top.next = tmp;
}

- (Item*) pop {
	Item *tmp = self.top;
	self.top = self.top.next;
	return tmp;
}

- (void) print {
	Item *tmp = self.top;
	NSLog(@"%i",tmp.value);
	while (tmp.next != nil) {
		tmp = tmp.next;
		NSLog(@"%i",tmp.value);
	}
}

@end

