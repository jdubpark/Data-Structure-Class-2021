//
//  Node.h
//  BinarySearchTree
//
//  Created by Park Jong Won on 4/29/21.
//

#ifndef Node_h
#define Node_h

@interface Node : NSObject

@property Node* parent;
@property Node* leftChild;
@property Node* rightChild;
@property int key;

- (instancetype) initWithKey:(int)key;
- (bool) hasNoChild;
- (bool) hasAnyChild;
- (bool) hasOneChild;

@end

#endif /* Node_h */
