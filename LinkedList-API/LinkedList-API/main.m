//
//  main.m
//  LinkedList-API
//
//  Created by Park Jong Won on 4/6/21.
//

#import <Foundation/Foundation.h>
#import "LinkedList.h"
#import "ListNode.h"

int main(int argc, const char * argv[]) {
	@autoreleasepool {
		LinkedList *list = [[LinkedList alloc] init];
		[list add:1];
		[list add:5];
		[list add:6];
		[list add:7];
		[list addObject:20 atIndex:2];
		[list addNode:[[ListNode alloc] initWithObject:50] atIndex:3];
		NSLog(@"BEFORE -----------");
		[list print];
		[list deleteNodeAtIndex:4];
		NSLog(@"AFTER 1 -----------");
		[list print];
		
        NSLog(@"count: %i", [list count]);
		NSLog(@"nodeAt: %i", [list nodeAt:2].object);
		NSLog(@"isInList: %@", [list isInList:22] ? @"TRUE" : @"FALSE");
		
		[list reverse];
		[list print];
	}
	return 0;
}
