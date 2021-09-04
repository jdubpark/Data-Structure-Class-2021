//
//  GameScene.m
//  MapRouting
//
//  Created by Jongwon Park on 5/18/21.
//

#import "GameScene.h"
#import "Map.h"
#import "Vertex.h"
#import "MinHeapTree.h"

@implementation GameScene {
    Map *map;
    NSMutableArray *AllEdges;
    
    float screenHeight;
    float screenWidth;
    float nodeWidth;
    float nodeHeight;

    float yTop;
}

- (void) didMoveToView:(SKView *)view {
    screenHeight = view.frame.size.height;
    screenWidth = view.frame.size.width;
    nodeWidth = 10;
    nodeHeight = nodeWidth;
    
    yTop = screenHeight;
    
    map = [[Map alloc] init];
    NSString *direction = @"bi"; // either "uni" or "bi" direction
    [map readMapFromFile:@"usa.txt" direction:direction];
    
    // between 100 and 600 are the sweet numbers!
    int originVertex = 300;
    int destVertex = 600;
    
    AllEdges = [[NSMutableArray alloc] init];
    [self drawEdges:map.vertices];

    [map pickOriginVertex:originVertex];
    NSArray *ret = [map distanceTo:destVertex];
    float distance = [ret[0] doubleValue];
    NSArray *backtrack = [[ret[1] reverseObjectEnumerator] allObjects]; // reversed
    
    [self backtrackVertices:(NSArray*)backtrack];
    
    if (distance != -1) {
        NSLog(@"Distance: %f", [ret[0] doubleValue]);
        NSLog(@"Direction: %@", [backtrack componentsJoinedByString:@" => "]);
    } else {
        NSLog(@"NOT CONNECTED");
    }
}

- (void) drawEdges:(MinHeapTree*)vertices {
    for (int i = 0; i < [vertices count]; i++) {
        Vertex *sourceVertex = [vertices get:i];
        NSMutableArray *neighbors = sourceVertex.neighbors;
        NSMutableArray *sourceEdges = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < [neighbors count]; i++) {
            SKShapeNode *edge = [self createEdgeShapeFrom:sourceVertex to:neighbors[i]];
            [sourceEdges addObject:edge];
            [self addChild:edge];
        }
        
        [AllEdges addObject:sourceEdges];
    }
}

- (SKShapeNode*) createEdgeShapeFrom:(Vertex*)source to:(Vertex*)dest {
    float xNormSource = ((float)source.x - (float)map.xMax / 2) / (float)map.xMax * screenWidth; // x normalized
    float yNormSource = ((float)source.y - (float)map.yMax / 2) / (float)map.yMax * screenHeight; // y normalized
    
    float xNormDest = ((float)dest.x - (float)map.xMax / 2) / (float)map.xMax * screenWidth;
    float yNormDest = ((float)dest.y - (float)map.yMax / 2) / (float)map.yMax * screenHeight;

    SKShapeNode *edge = [SKShapeNode node];
    CGMutablePathRef pathToDraw = CGPathCreateMutable();

    CGPathMoveToPoint(pathToDraw, NULL, xNormSource, yNormSource);
    CGPathAddLineToPoint(pathToDraw, NULL, xNormDest, yNormDest);

    edge.path = pathToDraw;
    [edge setStrokeColor:[SKColor blackColor]];
    [edge setLineWidth:2.0];
    
    return edge;
}

- (void) backtrackVertices:(NSArray*)vertices {
    int count = [vertices count];
    for (int i = 0; i < count; i++) {
        int vIdCurrent = [vertices[i] intValue]; // id of current vertice
        if (i+1 > count-1)
            break; // index out of range
        int vIdNext = [vertices[i+1] intValue]; // id of next vertex to backtrace
        
        Vertex *currentVertex = [map.vertices get:vIdCurrent];
        Vertex *nextVertex = [map.vertices get:vIdNext];
        
        NSMutableArray *neighbors = currentVertex.neighbors;
        NSMutableArray *localEdges = AllEdges[vIdCurrent];

        for (int j = 0; j < [neighbors count]; j++) {
            Vertex *neighbor = neighbors[j];
            if (neighbor.vId != vIdNext)
                continue;
            
            // corrrect edge found
            [localEdges[j] setStrokeColor:[SKColor redColor]];
            [localEdges[j] setLineWidth:15.0];
        }
    }
}

- (void) update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
}

@end
