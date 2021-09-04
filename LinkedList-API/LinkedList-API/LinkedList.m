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

- (void) add: (int)object {
	ListNode *newNode = [[ListNode alloc] initWithObject:object];
	[self addNode:newNode atIndex:0];
}

- (void) addObject:(int)object atIndex:(int)index {
	if (index == 0) {
		self.head.object += object;
	} else {
		LinkedList *rest = [[LinkedList alloc] init];
		rest.head = self.head.next;
		[rest addObject:object atIndex:index - 1];
	}
}

- (BOOL) isEmpty {
	return self.head == nil;
}

- (BOOL) isInList:(int)object {
	if (self.head.object == object) {
		return true;
	} else if (self.head.next == nil) {
		return false;
	} else {
		LinkedList *rest = [[LinkedList alloc] init];
		rest.head = self.head.next;
		return [rest isInList:object];
	}
}

- (void) removeOccurrences {
	
}

- (void) clear {
	// Objc does the ARC thing, so just self.head = nil will suffice
	self.head = nil;
}

- (void) print {
    NSLog(@"%i", self.head.object);
    if (self.head.next != nil) {
        LinkedList *rest = [[LinkedList alloc] init];
        rest.head = self.head.next;
        [rest print];
    }
}

- (void) addNode: (ListNode *)newNode atIndex: (int)index {
	if (index == 0) {
		// new node becomes the head node
		newNode.next = self.head;
		self.head = newNode;
	} else if (index+1 > [self count]) {
		// index is invalid
		return;
	} else {
		ListNode *prevNode = [self traverseToIndex:index-1]; // node previous to node at index
		ListNode *tmpNode = prevNode.next; // node at index
		prevNode.next = newNode;
		newNode.next = tmpNode;
	}
}

- (void) deleteNodeAtIndex:(int)index {
	if (index == 0) {
		self.head = self.head.next;
	} else if (index > [self count]) {
		// index is invalid
		return;
	} else {
		ListNode *prevNode = [self traverseToIndex:index-1]; // node previous to target node
		ListNode *tmpNode = prevNode.next; // will-be-deleted node (target)
		prevNode.next = tmpNode.next; // prevNode connects to target node's next
		tmpNode = nil; // target node is deleted (set to nil if ARC didn't take care of lost of reference)
	}
}

- (ListNode*) traverseToIndex:(int)index {
	//
	// this method is essentially a recursive wrapper
	// for other methods like addNode & deleteNode
	//
	
	// local wrapper function
	typedef ListNode* (^Traverse)(ListNode*, int);
	__block __weak Traverse weakTraverse = nil; // assigned 'traverse' later
	
	Traverse traverse = ^(ListNode *node, int steps) {
		if (steps == 0 || node.next == nil) {
			// base case (stop)
			return node;
		} else {
			// go to next node
			node = node.next;
			
			Traverse strongTraverse = weakTraverse;
			return strongTraverse(node, steps-1);
		}
	};

	weakTraverse = traverse;
	ListNode *targetNode = traverse(self.head, index); // call wrapper
	return targetNode;
}

- (ListNode*) first {
	return self.head;
}

- (ListNode*) last {
	if (self.head.next == nil) {
		return self.head;
	} else {
		LinkedList *tail = [[LinkedList alloc] init];
		tail.head = self.head.next;
		return [tail last];
	}
}

- (int) count {
	// local wrapper function
	int (^__block wrapper)(ListNode*) = ^(ListNode *node) {
		if (node.next == nil) {
			// base case
			return 1;
		} else {
			return 1 + wrapper(node.next);
		}
	};
	int count = wrapper(self.head);
	return count;
}

- (ListNode*) nodeAt: (int)index {
	if (index == 0) {
		return self.head;
	} else {
		LinkedList *tail = [[LinkedList alloc] init];
		tail.head = self.head.next;
		return [tail nodeAt:index-1];
	}
}

- (void) reverse {
	__block int maxIndex = [self count] - 1; // outside wrapper to reduce redundancy
	
	// local wrapper function
	typedef void (^ReverseTraverse)(ListNode*, ListNode*, int);
	__block __weak ReverseTraverse weakReverseTraverse = nil;

	ReverseTraverse reverseTraverse = ^(ListNode* prevNode, ListNode* node, int index) {
		if (index >= maxIndex || prevNode == nil || node == nil) {
			// traversed all, final action
			self.head.next = nil; // remove current head's next (it will become the last)
			self.head = prevNode; // set head to last node
			return;
		} else {
			ListNode* tmpNode = node.next;
			node.next = prevNode; // change the next node's next to current node
			
			ReverseTraverse strongReverseTraverse = weakReverseTraverse;
			strongReverseTraverse(node, tmpNode, index+1);
		}
	};
	
	ListNode *headNode = [self first];
	ListNode *nextNode = headNode.next;
	weakReverseTraverse = reverseTraverse;
	reverseTraverse(headNode, nextNode, 0);
}

@end
