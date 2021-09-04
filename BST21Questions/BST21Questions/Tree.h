//
//  Tree.h
//  Tree
//
//  Created by Park Jong Won on 4/29/21.
//

#import "Node.h"
#import "LinkedList.h"

#ifndef Tree_h
#define Tree_h

@interface Tree : NSObject

@property Node* root; // top of the tree

- (bool) isEmpty; // Returns true if the tree is empty (ie. root is empty)

- (Node*) addQuestion:(NSString*)question forParentNode:(Node*)parent;

- (Node*) addAnswer:(NSString*)answer forQuestionNode:(Node*)parent;

- (Node*) putKeyWrapper:(NSString*)key;
- (Node*) putKey:(NSString*)key; // Inserts the specified key into the tree (overwrite if the tree already contains the specified key)

- (int) heightWrapper;
- (int) height; // Returns the height of the BST (for debugging)

- (int) sizeWrapper;
- (int) size; // Returns the number of key-value pairs in the tree.

- (LinkedList*) levelorderWrapper;
- (LinkedList*) levelorder; // traverse the keys as levels, left to right.

- (LinkedList*) inorderWrapper;
- (LinkedList*) inorder; // traverse the keys in inorder order.

- (LinkedList*) postorderWrapper;
- (LinkedList*) postorder; // traverses the keys in postorder order.

- (LinkedList*) preorderWrapper;
- (LinkedList*) preorder; // traverses the keys in preorder order

@end

#endif /* Tree_h */
