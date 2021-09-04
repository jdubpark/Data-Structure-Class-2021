//
//  Map.m
//  MapRouting
//
//  Created by Jongwon Park on 5/18/21.
//

#import <Foundation/Foundation.h>
#import "Map.h"
#import "Vertex.h"
#import "MinHeapTree.h"

@implementation Map

- (instancetype) init {
    if (self = [super init]) {
        self.vertices = [[MinHeapTree alloc] init];
        self.xMax = 0;
        self.yMax = 0;
    }
    return self;
}

- (void) pickOriginVertex:(int)origin {
    Vertex *newOrigin = [self.vertices get:origin];
    if (self.vStart == nil || ![self isVertex:self.vStart sameAs:newOrigin]) {
        // indeed a new origin!
        self.vStart = newOrigin;
        self.vStart.distance = 0;
        [self calibrateEdges];
    }
}

- (void) calibrateEdges {
    // redo Djikstra's Algo based on the new origin vertex
    
    // go through the min heap tree
    for (int i = 0; i < [self.vertices count]; i++) {
        // first nearest will return the vStart (origin vertex) since only it's distance is non-infinite.
        Vertex *nearestVertex = [self.vertices get:i];
        [nearestVertex neighborMeeting];
    }
    
//    while (![self.vertices isEmpty]) {
//        // first nearest will return the vStart (origin vertex) since only it's distance is non-infinite.
//        Vertex *nearestVertex = [self.vertices popFirst];
//        [nearestVertex neighborMeeting];
//    }
}

- (NSArray*) distanceTo:(int)dest {
    // returns [distance, backtrack array]
    self.vDest = [self.vertices get:dest];
    
    if (self.vDest.distance == INFINITY)
        // unreachable! (not connected)
        return @[@-1, @[]];
    
    float distance = self.vDest.distance;
    NSMutableArray *backtrack = [[NSMutableArray alloc] init];
    
    Vertex *tmp = self.vDest;
    while (![self isVertex:self.vStart sameAs:tmp]) {
        // include the destination AND the origin
        [backtrack addObject:@(tmp.vId)];
        tmp = tmp.prev;
    }
    [backtrack addObject:@(self.vStart.vId)];
 
    return @[@(distance), [backtrack copy]];
}

- (bool) isVertex:(Vertex*)one sameAs:(Vertex*)two {
    return one.x == two.x && one.y == two.y;
}

// MARK: - Reading Map

- (void) readMapFromFile:(NSString*)userFilePath direction:(NSString*)direction {
    NSError *error;
    NSBundle *myBundle = [NSBundle mainBundle];
    NSString *filePath = [myBundle pathForResource:userFilePath ofType:nil]; // @"txt"
    NSString *fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];

    // throw error if no file is found
    if (error) {
        NSLog(@"Error reading file: %@", error.localizedDescription);
        return;
    }

    // read file into lines
    NSArray *listArray = [fileContents componentsSeparatedByString:@"\n"];
    NSArray *lines = [listArray mutableCopy];
    [self processMapFromLines:lines direction:direction];
}

- (void) processMapFromLines:(NSArray*)lines direction:(NSString*)direction {
    NSArray *metadata = [lines[0] componentsSeparatedByString:@" "];
    int vertexCount = [metadata[0] intValue];
    int edgeCount = [metadata[1] intValue];
    
    NSArray *vertexLines = [lines subarrayWithRange:NSMakeRange(1, vertexCount)];
    NSArray *edgeLines = [lines subarrayWithRange:NSMakeRange(vertexCount+2, edgeCount)]; // first edge line is empty
    
    // used for removing spaces in each line
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\s+" options:NSRegularExpressionCaseInsensitive error:nil];
    
//    // for testing
//    vertexLines = [vertexLines subarrayWithRange:NSMakeRange(0, 1000)];
    
    [self processVertices:vertexLines withRegEx:regex];
    [self processEdges:edgeLines withRegEx:regex direction:(NSString*)direction];
}

- (void) processVertices:(NSArray*)vertexLines withRegEx:(NSRegularExpression*)regex {
    for (int i = 0; i < [vertexLines count]; i++) {
        NSArray *vertexArr = [self readFileLine:vertexLines[i] withRegEx:regex];
        
        int vertexId = [vertexArr[0] intValue];
        int x = [vertexArr[1] intValue];
        int y = [vertexArr[2] intValue];
        
        Vertex *vertex = [[Vertex alloc] initWithX:x andY:y andId:vertexId];
        [self.vertices insert:vertex];
        
        if (x > self.xMax)
            self.xMax = x;
        if (y > self.yMax)
            self.yMax = y;
    }
}

- (void) processEdges:(NSArray*)edgeLines withRegEx:(NSRegularExpression*)regex direction:(NSString*)direction {
    for (int i = 0; i < [edgeLines count]; i++) {
        NSArray *edgeArr = [self readFileLine:edgeLines[i] withRegEx:regex];
        int vertexFromId = [edgeArr[0] intValue];
        int vertexToId = [edgeArr[1] intValue];
        if (vertexFromId == vertexToId)
            continue;
        
//        // for testing
//        if (vertexFromId >= 1000 || vertexToId >= 1000)
//            continue;
        
        Vertex *vertexFrom = [self.vertices get:vertexFromId];
        Vertex *vertexTo = [self.vertices get:vertexToId];
        
        if (vertexFrom.x == vertexTo.x && vertexFrom.y == vertexTo.y)
            continue;
        
        // uni-directional connection
        [vertexFrom connectToVertex:vertexTo];
        
        // continue with bi-directional connection
        if ([direction isEqual:@"bi"])
            [vertexTo connectToVertex:vertexFrom];
        
    }
}

- (NSArray*) readFileLine:(NSString*)string withRegEx:(NSRegularExpression*)regex {
    string = [regex stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, [string length]) withTemplate:@"_"]; // string without space
    string = [string substringFromIndex:1]; // ignore first character "_"

    return [string componentsSeparatedByString:@"_"];
}

@end
