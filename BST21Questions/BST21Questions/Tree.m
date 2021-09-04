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

// MARK: Add Q & A
- (Node*) addQuestion:(NSString*)question forParentNode:(Node*)parent {
    Node* questionNode = [[Node alloc] initWithKey:question];
    questionNode.isQuestion = true;
    
    if (parent == nil) {
        self.root = questionNode;
    } else if (parent.isQuestion) {
        parent.rightChild = questionNode;
    } else {
        Node* tmpAnswerNode = parent;
        parent = questionNode;
        parent.leftChild = tmpAnswerNode;
    }
    
    return questionNode;
}

- (Node*) addAnswer:(NSString*)answer forQuestionNode:(Node*)parent {
    Node* answerNode = [[Node alloc] initWithKey:answer];
    
    if (parent.isQuestion) {
        parent.leftChild = answerNode;
    }
    
    return answerNode;
}

//
// MARK: putKey
//
- (Node*) putKeyWrapper:(NSString*)key {
    if ([self isEmpty]) {
        // put as the root
        self.root = [[Node alloc] initWithKey:key];
        return self.root;
    } else {
        return [self putKey:key parent:self.root];
    }
}

- (Node*) putKey:(NSString*)key parent:(Node*)parent {
	Node* node = [[Node alloc] initWithKey:key];
	
	// key > parentKey ==> go down RIGHT (parent's right child)
	// key < parentKey ==> go down LEFT (parent's left child)
	// key == parentKey ==> same key, do nothing
	// * if parent's child-to-compare is null, then this key is a leaf
	// ** by using else and not recursive (passing parent of nil),
	//	  it's easier to assign node to parent.leftChild or parent.rightChild
	//	  AND assign node's parent to passed parent node.
	
	if ([key isEqualToString:parent.key])
		return node;
	
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
    
    return node;
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
    if (root.leftChild)
        [self inorder:root.leftChild orderedList:list];

    [list addObject:[NSNumber numberWithInt:root.key]];
    
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
    [list addObject:[NSNumber numberWithInt:root.key]];

    if (root.leftChild)
        [self preorder:root.leftChild orderedList:list];

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
    if (root.leftChild)
        [self postorder:root.leftChild orderedList:list];
    
    if (root.rightChild)
        [self postorder:root.rightChild orderedList:list];

    [list addObject:[NSNumber numberWithInt:root.key]];
    
    return list;
}

@end
