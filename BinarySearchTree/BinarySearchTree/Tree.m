//
//  Tree.m
//  Tree
//
//  Created by Park Jong Won on 4/29/21.
//

#import <Foundation/Foundation.h>
#import "Tree.h"
#import "Node.h"
#import "LinkedList.h"

@implementation Tree

- (instancetype) init {
	self = [super init];
	return self;
}

// MARK: isEmpty
- (bool) isEmpty {
	return self.root == nil;
}

// MARK: height
- (int) heightWrapper {
	return [self height:self.root];
}

// height = number of layers - 1
- (int) height:(Node*)node {
	if (node == nil)
		return 0;
    
    int heightToLeft = [self height:node.leftChild];
    int heightToRight = [self height:node.rightChild];
    return 1 + MAX(heightToLeft, heightToRight);
}

// MARK: size
- (int) sizeWrapper {
	return [self size:self.root];
}

- (int) size:(Node*)node {
	if (!node)
		return 0;

	// add 1 for the node itself and do recursion for its children
	return 1 + [self size:node.leftChild] + [self size:node.rightChild];
}

// MARK: max
- (int) maxWrapper {
	return [self max:self.root];
}

- (int) max:(Node*)node {
	if (node.rightChild)
		return [self max:node.rightChild]; // go down right if child exists

	return node.key; // if not, return key (max value reached)
}

// MARK: min
- (int) minWrapper {
	return [self max:self.root];
}

- (int) min:(Node*)node {
	if (node.leftChild)
		return [self max:node.leftChild]; // go down left if child exists

	return node.key; // if not, return key (min value reached)
}

//
// MARK: putKey
//
- (void) putKeyWrapper:(int)key {
	if ([self isEmpty])
        // put as the root
		self.root = [[Node alloc] initWithKey:key];
    else
        [self putKey:key parent:self.root];
}

- (void) putKey:(int)key parent:(Node*)parent {
	Node* node = [[Node alloc] initWithKey:key];
	
	// key > parentKey ==> go down RIGHT (parent's right child)
	// key < parentKey ==> go down LEFT (parent's left child)
	// key == parentKey ==> same key, do nothing
	// * if parent's child-to-compare is null, then this key is a leaf
	// ** by using else and not recursive (passing parent of nil),
	//	  it's easier to assign node to parent.leftChild or parent.rightChild
	//	  AND assign node's parent to passed parent node.
	
	if (key == parent.key)
		return;
	
	node.parent = parent;
	if (key > parent.key) {
		if (parent.rightChild != nil)
			[self putKey:key parent:parent.rightChild];
		else
			parent.rightChild = node; // leaf
	}
	else if (key < parent.key) {
		if (parent.leftChild != nil)
			[self putKey:key parent:parent.leftChild];
		else
			parent.leftChild = node; // leaf
	}
}

// MARK: containsKey
- (bool) containsKeyWrapper:(int)key {
	return [self containsKey:key withNode:self.root];
}

- (bool) containsKey:(int)key withNode:(Node*)node {
	if (!node)
		return false; // undefined node
	if (node.key == key)
		return true; // node contains key

	// check left and right child
	bool checkLeft = [self containsKey:key withNode:node.leftChild];
	bool checkRight = [self containsKey:key withNode:node.rightChild];
	return checkLeft || checkRight;
}

//
// MARK: deleteKey
// (deleteKey as a wrapper to deleteNode)
//
- (void) deleteKey:(int)key {
	// get target node (to be deleted)
	Node* node = [self findNodeForDeleteKeyWrapper:key];
	
	if (node == nil)
		return; // no node found with target key
	
	return [self deleteNode:node];
}

- (void) deleteNode:(Node*)node {
	bool isNodeLeftChild = node.parent.key > node.key;

	// Case 1: node is leaf (no child). Just remove
	if ([node hasNoChild]) {
		// setting parent's child to nil will not only remove that child
		// but also cleanup empty references
		if (isNodeLeftChild)
			node.parent.leftChild = nil;
		else
			node.parent.rightChild = nil;
	}
	
	// Case 2: node has only ONE child. Take the child node and move it up
	else if ([node hasOneChild]) {
		// get node's only child
		Node* successorNode = node.leftChild ? node.leftChild : node.rightChild;
		
		// skip node (aka move descendant to node's place and thereby deleting node)
		if (isNodeLeftChild)
			node.parent.leftChild = successorNode;
		else
			node.parent.rightChild = successorNode;
	}
	
	// Case 3: node has TWO children
	else {
		
		// Find the greatest lesser value. Go one level left, then continue going right.
		// Subcase 1: last right node is a leaf (no child)
		// ==> Replace target node's key with that leaf's key and remove that leaf.
		// Subcase 2: last right node has a left child
		// ==> Replace target node's key with last right node's key.
		//		Then run deleteNode again on last right node to replace it with
		//		the next largest least key node.
		
		// first find the right-most child
		Node* successorNode = node.leftChild;
		while (successorNode.rightChild != nil) {
			successorNode = node.rightChild;
		}
		
		if ([successorNode hasNoChild]) {
            // is leaf
			node.key = successorNode.key;
			successorNode = nil;
		} else {
            // NOT leaf
			node.key = successorNode.key;
			[self deleteNode:successorNode];
		}
	}
}

- (Node*) findNodeForDeleteKeyWrapper:(int)key {
	Node* root = self.root;
	return [self findNodeForDeleteKey:key withParent:root];
}

- (Node*) findNodeForDeleteKey:(int)key withParent:(Node*)parent {
	if (parent == nil || parent.key == key)
		return parent; // either nil (not matched) or parent (matched)
	
	// similar to compareKey:
	//  if key < parent.key, check with parent's right child
	//  else if key > parent.key, check with parent's right child
	//  else if key == parent.key, handled above
	if (key > parent.key && parent.rightChild)
		return [self findNodeForDeleteKey:key withParent:parent.rightChild];
	else if (key < parent.key && parent.leftChild)
		return [self findNodeForDeleteKey:key withParent:parent.leftChild];

	return nil;
}

//
// MARK: getNodesAtLevel
//
- (LinkedList*) getNodesAtLevelWrapper:(int)level {
    LinkedList* nodes = [[LinkedList alloc] init];
    [self getNodesAtLevel:level currentLevel:0 currentNode:self.root finalList:nodes];
    return nodes; // nodes from left to right at that level
}

- (void) getNodesAtLevel:(int)tLevel currentLevel:(int)cLevel currentNode:(Node*)node finalList:(LinkedList*)list {
    if (node == nil) {
        [list addObject:nil];
        return;
    }

    if (cLevel == tLevel) {
        // current level == target level
        [list addObject:[NSNumber numberWithInt:node.key]];
    } else {
        // if not target level yet, then go down left & right from current node
        [self getNodesAtLevel:tLevel currentLevel:cLevel+1 currentNode:node.leftChild finalList:list];
        [self getNodesAtLevel:tLevel currentLevel:cLevel+1 currentNode:node.rightChild finalList:list];
    }
}

// MARK: Level Order

// visit each level one by one in order, left to right.
- (LinkedList*) levelorder {
    int height = [self height];
    LinkedList* list = [[LinkedList alloc] init];
    for (int level = 0; level < height; level++)
        [self levelorderOfNode:self.root atLevel:level orderedList:list];
        
    return list;
}

- (LinkedList*) levelorderOfNode:(Node*)root atLevel:(int)level orderedList:(LinkedList*)list {
    if (root) {
        if (level == 1) {
            // visit root
            [list addObject:[NSNumber numberWithInt:root.key]];
        } else if (level > 1) {
            // visit left, then right
            [self levelorderOfNode:root.leftChild atLevel:level+1 orderedList:list];
            [self levelorderOfNode:root.rightChild atLevel:level+1 orderedList:list];
        }
    }
	
	return list;
}

// MARK: In Order

// inorder: visit left child first, then itself, then right child
- (LinkedList*) inorderWrapper {
    LinkedList* list = [[LinkedList alloc] init];
	return [self inorder:self.root orderedList:list];
}

- (LinkedList*) inorder:(Node*)root orderedList:(LinkedList*)list {
    // first visit left child
    if (root.leftChild)
        [self inorder:root.leftChild orderedList:list];

    // then visit the parent itself
    [list addObject:[NSNumber numberWithInt:root.key]];
    
    // last, visit right child
    if (root.rightChild)
        [self inorder:root.rightChild orderedList:list];
	
	return list;
}

// MARK: Pre Order

// preorder: visit itself first, then left child first, then right child
- (LinkedList*) preorderWrapper {
    LinkedList* list = [[LinkedList alloc] init];
    return [self inorder:self.root orderedList:list];
}

- (LinkedList*) preorder:(Node*)root orderedList:(LinkedList*)list {
    // first visit the parent itself
    [list addObject:[NSNumber numberWithInt:root.key]];

    // then visit left child
    if (root.leftChild)
        [self preorder:root.leftChild orderedList:list];
    
    // then visit right child
    if (root.rightChild)
        [self preorder:root.rightChild orderedList:list];
    
    return list;
}

// MARK: Post Order

// postorder: visit left child first, then right child, then itself
- (LinkedList*) postorderWrapper {
    LinkedList* list = [[LinkedList alloc] init];
    return [self inorder:self.root orderedList:list];
}

- (LinkedList*) postorder:(Node*)root orderedList:(LinkedList*)list {
    // first visit left child
    if (root.leftChild)
        [self postorder:root.leftChild orderedList:list];
    
    // then visit right child
    if (root.rightChild)
        [self postorder:root.rightChild orderedList:list];

    // last, visit the parent itself
    [list addObject:[NSNumber numberWithInt:root.key]];
    
    return list;
}

@end
