//
//  Vertex.m
//  MapRouting
//
//  Created by Jongwon Park on 5/18/21.
//

#import <Foundation/Foundation.h>
#import "Vertex.h"
#import "Edge.h"

@implementation Vertex

- (instancetype) initWithX:(int)x andY:(int)y andId:(int)vId {
    if (self = [super init]) {
        self.vId = vId;
        self.x = x;
        self.y = y;
        self.visited = false;
        self.distance = INFINITY;
        self.neighbors = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) connectToVertex:(Vertex*)vertex {
    [self.neighbors addObject:vertex];
}

- (void) neighborMeeting {
    // calculate neighbor distance
    
    for (int i = 0; i < [self.neighbors count]; i++) {
        Vertex *neighbor = self.neighbors[i];
        float localDist = [self distanceToNeighbor:neighbor]; // distance from current to neighbor
        float globalDist = self.distance + localDist; // distance from origin vertex to this neighbor
        
//        if (!neighbor.visited && globalDist < neighbor.distance) {
        if (globalDist < neighbor.distance) {
            neighbor.distance = globalDist;
            neighbor.prev = self;
        }
    }
}

- (float) distanceToNeighbor:(Vertex*)neighbor {
    // pythagorean theorem
    return sqrt(pow((self.x - neighbor.x),2) + pow((self.y - neighbor.y),2));
}

@end
