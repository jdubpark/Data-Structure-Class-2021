//
//  Edge.h
//  MapRouting
//
//  Created by Jongwon Park on 5/18/21.
//

#ifndef Edge_h
#define Edge_h

@class Vertex; // prevents circular import

@interface Edge : NSObject

// this type of construction allows for uni-directional vertex
// (A -> B exists, B -> A may not exist)
@property Vertex *src; // source vertex
@property Vertex *dest; // destination vertex
@property double distance; // from src to dest

- (instancetype) initWithSource:(Vertex*)src andDest:(Vertex*)dest;

@end

#endif /* Edge_h */
