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
@property Node* leftChild; // answer
@property Node* rightChild; // no to parent question => one more question
@property NSString* key;
@property bool isQuestion;

- (instancetype) initWithKey:(NSString*)key;
- (bool) hasNoChild;
- (bool) hasAnyChild;
- (bool) hasOneChild;

@end

#endif /* Node_h */
