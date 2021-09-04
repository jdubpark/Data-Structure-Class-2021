//
//  Queue.m
//  StacksAndQueue
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
	Item *tmp = self.front;
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
		Item *item = [[Item alloc] initWithObject:object];
		Item *tmp = self.back;
		self.back = item;
		tmp.next = self.back;
	}
}

- (Item*) dequeue {
	// remove the first
	Item *tmp = self.front;
	self.front = tmp.next;
	return tmp;
}

- (void) print {
	Item *tmp = self.front;
	NSLog(@"%@",tmp.object);
	while (tmp.next != nil) {
		tmp = tmp.next;
		NSLog(@"%@",tmp.object);
	}
}

//The method should take S and N as inputs and display on the console the order which people are eliminated, S is the skip space of the elimination, and N is the number of people.  The output would show where Josephus should sit (assuming he wishes to avoid elimination).

+ (void) Josephus:(int)numberOfPeople skipSpace:(int)k {
	Queue *execution = [[Queue alloc] init];

	// add people to the queue (each Item's value is its index)
	for (int i = 0; i < numberOfPeople; i++) {
		[execution enqueue:[NSNumber numberWithInt:i]];
	}
	
	while ([execution size] > 1) {
		// dequeue until the k-1 person
		for (int i = 0; i < k-1; i++) {
			Item *item = [execution dequeue];
			[execution enqueue:item.object];
		}
		
		// executed the k-th person (disregard)
		Item *executed = [execution dequeue];
	}
	
	Item *shouldSitAt = [execution dequeue];
	NSLog(@"Josephus should sit at %ith place", [shouldSitAt.object intValue]+1);
}

@end

