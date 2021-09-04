//
//  Map.h
//  MapRouting
//
//  Created by Jongwon Park on 5/18/21.
//

#ifndef Map_h
#define Map_h

#import "Vertex.h"
#import "MinHeapTree.h"

@interface Map : NSObject

@property MinHeapTree *vertices;
@property Vertex *vStart; // vertex starting (changes as we move down the queue)
@property Vertex *vDest; // vertex destination

// x,y max for normalizing to visualize later
@property int xMax;
@property int yMax;

- (void) readMapFromFile:(NSString*)userFilePath direction:(NSString*)direction;
- (void) pickOriginVertex:(int)origin;
- (NSArray*) distanceTo:(int)dest;

@end

#endif /* Map_h */
