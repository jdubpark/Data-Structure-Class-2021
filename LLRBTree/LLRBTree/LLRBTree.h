//
//  LLRBTree.h
//  LLRBTree
//
//  Created by Jongwon Park on 5/10/21.
//

#ifndef LLRBTree_h
#define LLRBTree_h

#import "Node.h"

@interface LLRBTree : NSObject

@property Node* root;

- (void) insertKey:(int)key;

@end


#endif /* LLRBTree_h */
