//
//  Vertex.h
//  MapRouting
//
//  Created by Jongwon Park on 5/18/21.
//

#ifndef Vertex_h
#define Vertex_h

@class Edge; // prevents circular import

@interface Vertex : NSObject

@property int vId; // vertex ID
@property int x;
@property int y;
@property bool visited;
@property float distance; // distance weight
@property NSMutableArray *neighbors;
@property Vertex *prev; // used for backtracing

- (instancetype) initWithX:(int)x andY:(int)y andId:(int)vId;

- (void) connectToVertex:(Vertex*)vertex;
- (void) neighborMeeting; // calculates distance from origin vertex to the neighbors of current vertex

@end

#endif /* Vertex_h */
