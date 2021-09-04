//
//  MinHeapTree.m
//  MapRouting
//
//  Created by Jongwon Park on 5/21/21.
//

#import <Foundation/Foundation.h>
#import "MinHeapTree.h"
#import "Vertex.h"

// array representation of weighted min-heap tree (priority queue)

@implementation MinHeapTree

- (instancetype) init {
    if (self = [super init]) {
        // first index (0) is skipped; root node is stored at index 1
        // [x, 1, 2, 5, 4, 7, 9, 10, ...];
        // starting at 1 makes i/2 (finding parent node) easier
        self.array = [[NSMutableArray alloc] init];
        [self.array addObject:@""];
    }
    return self;
}

- (Vertex*) get:(int)index {
    // first index (0) is skipped; root node is stored at index 1
    return self.array[index+1];
}

- (Vertex*) popFirst {
    Vertex *first = [self get:0];
    first.visited = true; // popped means visited
    [self.array removeObjectAtIndex:1]; // first index (0) is skipped
    return first;
}

- (int) count {
    return [self.array count] - 1; // fist index (0) is skipped
}

- (bool) isEmpty {
    return [self.array count] <= 1;
}

- (void) insert:(Vertex*)vertex {
    
    [self.array addObject:vertex]; // add vertex to the next available location (i.e. append in array)
    int vIndex = [self.array count] - 1; // get that newly added index

    // then get parent edge
    int parentIndex = vIndex/2;
    Vertex *parentVertex = self.array[parentIndex];
    
    if (parentIndex == 0)
        return; // no need to calculate when parent index is 0 (first actual element added)

    while (vertex.distance < parentVertex.distance) {
        // while: (this edge's distance is shorter than parent's)
        // make this edge the new parent (swap)
        self.array[parentIndex] = vertex;
        self.array[vIndex] = parentVertex;
        vIndex = parentIndex; // update edge's index
        parentIndex = vIndex/2; // update to new parent
        parentVertex = self.array[parentIndex];
        
        // stop if edge is at root
        if (vIndex <= 1)
            break;
    }

}

@end
