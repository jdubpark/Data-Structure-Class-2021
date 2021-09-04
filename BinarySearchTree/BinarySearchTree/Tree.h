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

- (void) putKeyWrapper:(int)key;
- (void) putKey:(int)key; // Inserts the specified key into the tree (overwrite if the tree already contains the specified key)

- (int) heightWrapper;
- (int) height; // Returns the height of the BST (for debugging)

- (int) sizeWrapper;
- (int) size; // Returns the number of key-value pairs in the tree.

- (bool) containsKeyWrapper:(int)key;
- (bool) containsKey:(int)key; // Does the tree contain the given key?

- (void) deleteKey:(int)key;
- (void) deleteNode:(Node*)node; // Removes the specified key and its associated value from the tree (if the key is in the tree).

- (int) maxWrapper;
- (int) max; // Returns the largest key in the symbol table.

- (int) minWrapper;
- (int) min; // Returns the smallest key in the symbol table.

- (LinkedList*) getNodesAtLevelWrapper:(int)level;
- (void) getNodesAtLevel:(int)tLevel currentLevel:(int)cLevel currentNode:(Node*)node finalList:(LinkedList*)list; // Returns the nodes at level i, left to right

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
