//
//  MinHeapTree.h
//  MapRouting
//
//  Created by Jongwon Park on 5/21/21.
//

#ifndef MinHeapTree_h
#define MinHeapTree_h

#import "Vertex.h"

@interface MinHeapTree : NSObject

@property NSMutableArray *array; // array representation of weighted min-heap tree (priority queue)

- (void) insert:(Vertex*)vertex;
- (Vertex*) get:(int)index;
- (Vertex*) popFirst;
- (int) count;
- (bool) isEmpty; // returns true if contains only 1 element (0th index is left blank for heap tree as array)

@end

#endif /* MinHeapTree_h */
