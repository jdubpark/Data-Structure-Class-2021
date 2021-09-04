//
//  LLRBTree.m
//  LLRBTree
//
//  Created by Jongwon Park on 5/10/21.
//

#import <Foundation/Foundation.h>
#import "LLRBTree.h"
#import "Node.h"

@implementation LLRBTree

- (instancetype) init {
    self = [super init];
    return self;
}

- (void) insertKeyWrapper:(int)key {
    [self insertKey:key withParent:self.root];
}

- (Node*) insertKey:(int)key withParent:(Node*)parent {
    if(!parent){
        return [[Node alloc]initWithKey:key];
    }
    if (parent.key < key)
        parent = [self insertKey:key withParent:parent.rightChild];
    else if (parent.key > key)
        parent = [self insertKey:key withParent:parent.leftChild];
    
    if(parent.leftChild.isRed && parent.rightChild.isRed){
        [self flip:parent];
    }
    if(parent.rightChild.isRed){
        parent = [self rotateLeft:parent];
    }
    if(parent.leftChild.isRed && parent.leftChild.leftChild.isRed){
        parent = [self rotateRight:parent];
    }
    return parent;
}

// returns the new top node given the old top node
// where the new top node is the right child of the old top node
- (Node*) rotateLeft:(Node*)topNode {
    Node* newTopNode = topNode.rightChild;
    
    topNode.rightChild = newTopNode.leftChild;
    newTopNode.leftChild = topNode;
    
    topNode.isRed = true;
    newTopNode.isRed = false;
    
    return newTopNode;
}

- (Node*) rotateRight:(Node*)topNode {
    Node* newTopNode = topNode.leftChild;
    Node* tmpNode = newTopNode.rightChild;
    
    newTopNode.rightChild = topNode;
    topNode.leftChild = tmpNode;
    
    newTopNode.leftChild.isRed = false;
    newTopNode.rightChild.isRed = false;
    
    return newTopNode;
}

- (void) flip:(Node*)parentNode {
    parentNode.isRed = true;
    parentNode.leftChild.isRed = false;
    parentNode.rightChild.isRed = false;
}

@end
