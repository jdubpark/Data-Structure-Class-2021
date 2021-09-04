//
//  LinkedList.m
//  LinkedListApp
//
//  Created by Park Jong Won on 4/6/21.
//

#import <Foundation/Foundation.h>
#import "LinkedList.h"
#import "ListNode.h"

@implementation LinkedList

#pragma mark - Required Methods

- (void) add:(NSString*)name {
	ListNode *newNode = [[ListNode alloc] initWithName:name];
	[self addNode:newNode atIndex:0];
}

- (BOOL) isEmpty {
	return self.head == nil;
}

- (BOOL) isInList:(NSString*)name {
	// local wrapper for recursive
	typedef BOOL (^InList)(ListNode*);
	__block __weak InList weakInList = nil;
	
	InList inList = ^(ListNode *node) {
		if ([node.name isEqualToString:name]) {
			// isEqualToString is more consistent than ==
			return YES;
		} else if (node.next == nil) {
			return NO;
		} else {
			ListNode *nextNode = node.next;

			InList strongInList = weakInList;
			return strongInList(nextNode);
		}
	};
	
	weakInList = inList;
	ListNode *node = self.head;
	return inList(node);
}

- (void) removeOccurrences:(NSString*)name {
	// local wrapper function
	void (^__block remover)(ListNode*, int) = ^(ListNode *node, int index) {
		if (node.next == nil) {
			// base case
			return;
		} else {
			// step case
			if ([node.name isEqualToString:name]) {
				[self deleteNodeAtIndex:index];
			}
			
			return remover(node, index+1);
		}
	};
	return remover(self.head, 0);
}

- (void) clear {
	// Objc does the ARC thing, so just self.head = nil will suffice
	self.head = nil;
}

- (void) print {
	NSLog(@"%@", self.head.name);
	if (self.head.next != nil) {
		LinkedList *tail = [[LinkedList alloc] init];
		tail.head = self.head.next;
		[tail print];
	}
}

- (void) addNode: (ListNode *)newNode atIndex: (int)index {
	if (self.head == nil) {
		// head is empty, set new node to head
		self.head = newNode;
	} else if (index == 0) {
		// new node becomes the head node
		newNode.next = self.head;
		self.head = newNode;
	} else if (index == [self count]) {
		// add to last
		ListNode *lastNode = [self traverseToIndex:index];
		lastNode.next = newNode;
	} else if (index > [self count]) {
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
	} else if (index+1 > [self count]) {
		// index is invalid
		return;
	} else {
		ListNode *prevNode = [self traverseToIndex:index-1]; // node previous to target node
		ListNode *tmpNode = prevNode.next; // will-be-deleted node (target)
		prevNode.next = tmpNode.next; // prevNode connects to target node's next
		tmpNode = nil; // target node is deleted (set to nil if ARC didn't take care of lost of reference)
	}
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
	int (^__block counter)(ListNode*) = ^(ListNode *node) {
		if (node.next == nil) {
			// base case
			return node == nil ? 0 : 1;
		} else {
			// step case
			return 1 + counter(node.next);
		}
	};
	return counter(self.head);
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

#pragma mark - Custom Methods

- (void) remove:(NSString*)name {
	
}

- (void) person:(NSString*)name addFriend:(NSString*)friendName {
	
}

- (void) person:(NSString*)name removeFriend:(NSString*)friendName {
	
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

- (ListNode*) findNodeWithName:(NSString*)name {
	// local wrapper for recursive
	typedef ListNode* (^FindNode)(ListNode*);
	__block __weak FindNode weakFindNode = nil;
	
	FindNode findNode = ^(ListNode *node) {
		if ([node.name isEqualToString:name]) {
			// isEqualToString is more consistent than ==
			return node;
		} else if (node.next == nil) {
			return [[ListNode alloc] init];
		} else {
			ListNode *nextNode = node.next;

			FindNode strongFindNode = weakFindNode;
			return strongFindNode(nextNode);
		}
	};
	
	weakFindNode = findNode;
	ListNode *node = self.head;
	return findNode(node);
}

- (BOOL) isPointerInList:(NSString*)name {
	// local wrapper for recursive
	typedef BOOL (^InList)(ListNode*);
	__block __weak InList weakInList = nil;
	
	InList inList = ^(ListNode *node) {
		if ([node.pointer.name isEqualToString:name]) {
			// isEqualToString is more consistent than ==
			return YES;
		} else if (node.next == nil) {
			return NO;
		} else {
			ListNode *nextNode = node.next;

			InList strongInList = weakInList;
			return strongInList(nextNode);
		}
	};
	
	weakInList = inList;
	ListNode *node = self.head;
	return inList(node);
}

@end
