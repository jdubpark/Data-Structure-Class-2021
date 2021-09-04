//
//  MazeSolver.h
//  MazeDFS
//
//  Created by Park Jong Won on 4/17/21.
//

#import <Foundation/Foundation.h>
#import "Queue.h"

#ifndef MazeSolver_h
#define MazeSolver_h

@interface MazeSolver : NSObject

@property (nonatomic, strong) Queue* queue;
@property (nonatomic, strong) NSArray* lines;
@property (nonatomic, strong) NSMutableArray* visited;
@property int rowCount;
@property int colCount;

- (void) startNewMaze:(NSString*)fname;
- (NSArray*) search; // depth-first search
- (bool) isValidMove:(int)row col:(int)col;

@end


#endif /* MazeSolver_h */
