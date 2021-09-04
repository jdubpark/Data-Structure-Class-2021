//
//  MazeSolver.h
//  MazeDFS
//
//  Created by Park Jong Won on 4/17/21.
//

#import <Foundation/Foundation.h>
#import "Stack.h"

#ifndef MazeSolver_h
#define MazeSolver_h

@interface MazeSolver : NSObject

@property (nonatomic, strong) Stack* stack;
@property (nonatomic, strong) NSArray* lines;
@property (nonatomic, strong) NSMutableArray* visited;
@property int rowCount;
@property int colCount;

- (void) startNewMaze:(NSString*)fname;
- (NSArray*) search; // depth-first search
- (bool) isValidMoveAtRow:(int)row andCol:(int)col;

@end


#endif /* MazeSolver_h */
