//
//  Maze.h
//  DFS-BFS
//
//  Created by Park Jong Won on 4/15/21.
//
#import <Foundation/Foundation.h>

#ifndef Maze_h
#define Maze_h

@interface Maze : NSObject

+ (void) readFile:(NSString*)fname;

+ (void) depthFirstSearch;
+ (void) breadthFirstSearch;

@end

#endif /* Maze_h */
