//
//  Node.h
//  LLRBTree
//
//  Created by Jongwon Park on 5/10/21.
//

#ifndef Node_h
#define Node_h

@interface Node : NSObject

@property int key;
@property BOOL isRed; // color from this node to parent
@property Node* leftChild;
@property Node* rightChild;

- (instancetype) initWithKey:(int)key;

@end

#endif /* Node_h */
