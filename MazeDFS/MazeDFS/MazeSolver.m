//
//  MazeSolver.m
//  MazeDFS
//
//  Created by Park Jong Won on 4/17/21.
//

#import <Foundation/Foundation.h>
#import "MazeSolver.h"

@implementation MazeSolver

- (instancetype) init {
	self = [super init];
	if (self) {
		self.stack = [[Stack alloc] init];
		self.visited = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void) startNewMaze:(NSString*)userFilePath {
	// find file given path
	NSError *error;
	NSString *filePath = [[NSBundle mainBundle] pathForResource:userFilePath ofType:@"txt"];
	NSString *fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];

	// throw error if no file is found
	if (error) {
		NSLog(@"Error reading file: %@", error.localizedDescription);
	}

	// read file into lines
	NSArray *listArray = [fileContents componentsSeparatedByString:@"\n"];
	NSMutableArray* lines = [listArray mutableCopy];
	
	if ([lines count] > 0) {
		// create mutable array to split the line
		NSMutableArray* completeSplit = [[NSMutableArray alloc] init];
		
		int colCount = (int)[lines[0] length];

		// loop through lines
		for (int i = 0; i < [lines count]; i++) {
			if ([lines[i] isEqual:@""])
				continue;
			
			// for each line, split the string into individual characters
			completeSplit[i] = [[NSMutableArray alloc] init];
			for (int j = 0; j < colCount; j++) {
				completeSplit[i][j] = [lines[i] substringWithRange:NSMakeRange(j, 1)];
			}
		}
		
		// assign lines and metadata to self
		self.lines = [completeSplit copy];
		self.rowCount = (int)[self.lines count];
		self.colCount = colCount;
		
		// intiailize stack (point sets to Start point)
		for (int i = 0; i < self.rowCount; i++) {
			// loop through each line
			NSArray* line = self.lines[i];
			self.visited[i] = [[NSMutableArray alloc] init];

			for (int j = 0; j < self.colCount; j++) {
				// loop through each char
				NSString* ch = line[j];
				
				if ([ch isEqual:@"S"]) {
					// initialize (only if point is S for Start)
					[self.stack push:@[[NSNumber numberWithInt:i], [NSNumber numberWithInt:j]]];
					self.visited[i][j] = [NSNumber numberWithBool:TRUE];
				} else {
					self.visited[i][j] = [NSNumber numberWithBool:FALSE];
				}
			}
		}
	}
}

- (void) exploreToRow:(int)row andCol:(int)col {
	NSArray* rowColValue = @[[NSNumber numberWithInt:row], [NSNumber numberWithInt:col]];
	[self.stack push:rowColValue];
}

- (bool) isValidMoveAtRow:(int)row andCol:(int)col{
	// row & col are within range
	bool isLocationValid = row > -1 && row < self.rowCount && col > -1 && col < self.colCount;
	
	bool isVisited = FALSE; // tile at (row,col) is not visited
	bool isValidValue = FALSE; // tile value of (row,col) is valid (either "." or "G")
	if (isLocationValid) {
		isVisited = [self.visited[row][col] boolValue];
		isValidValue = [self.lines[row][col] isEqual:@"."] || [self.lines[row][col] isEqual:@"G"];
	}

	// return TRUE if (row,col) is valid AND not visited; else FALSE
//	NSLog(@"(%d,%d) is %@", row, col, isLocationValid && !isVisited && isValidValue ? @"VALID" : @"INVALID");
//	NSLog(@"^ val: %@", self.lines[row][col]);
	return isLocationValid && !isVisited && isValidValue;
}

- (NSArray*) search {
	if (self.stack.top == nil) {
		// return all empty (end of search) for viewer
		return @[@"EMPTY", @"EMPTY", @"EMPTY"];
	}
	
	Item* currentNode = self.stack.top; // current position (top)
	bool isSolved = FALSE;
	
	// current position (of popped top)
	int row = [[currentNode.object objectAtIndex:0] intValue];
	int col = [[currentNode.object objectAtIndex:1] intValue];
	// explorable position
	int topRow = row-1, bottomRow = row+1, leftCol = col-1, rightCol = col+1;

	if ([self.lines[row][col] isEqual:@"G"]) {
		// if current position is goal, end
		isSolved = TRUE;
	} else {
		// else continue searching
		// mark current position as visited (popped top)
		self.visited[row][col] = [NSNumber numberWithBool:TRUE];

		// push reachable branch (just the first valid move)
		// order: top > right > bottom > left

		if ([self isValidMoveAtRow:topRow andCol:col])
			[self exploreToRow:topRow andCol:col];
		else if ([self isValidMoveAtRow:row andCol:rightCol])
			[self exploreToRow:row andCol:rightCol];
		else if ([self isValidMoveAtRow:bottomRow andCol:col])
			[self exploreToRow:bottomRow andCol:col];
		else if ([self isValidMoveAtRow:row andCol:leftCol])
			[self exploreToRow:row andCol:leftCol];
		else
			[self.stack pop]; // retrieve one back (pop top) if no explorable branch exists
	}
	
	// return current node and string of "SOLVED" or "UNSOLVED"
	return @[currentNode, isSolved?@"SOLVED":@"UNSOLVED"];
}

@end
