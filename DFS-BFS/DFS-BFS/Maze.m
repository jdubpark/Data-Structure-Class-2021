//
//  Maze.m
//  DFS-BFS
//
//  Created by Park Jong Won on 4/15/21.
//

#import <Foundation/Foundation.h>
#import <stdio.h>
#import "Maze.h"
#import "Stack.h"
#import "Queue.h"
#import "Item.h"

@implementation Maze

+ (void) readFile:(NSString*)pathString {
	//NSArray*

	pathString = @"./maze-tests/smallMaze.txt";
	pathString = @"/Users/pjw/Documents/Data-Structures-Class/DFS-BFS/DFS-BFS/maze-tests/smallMaze.txt";
	
	const char* fname = [[NSFileManager defaultManager] fileSystemRepresentationWithPath:pathString];
	
	FILE* file = fopen(fname, "r");

	if (file != nil) {
		char buffer[256];
		while (fgets(buffer, sizeof(char)*256, file) != nil){
			NSString* line = [NSString stringWithUTF8String:buffer];
//			fileToRead[strcspn(fileToRead, "\n")] = '\0';
			NSLog(@"%@",line);
		}
	}
}

+ (NSArray*) dummyFile {
	//	########
	//	#S...###
	//	##.#...#
	//	##.##.##
	//	#..#.###
	//	##...#G#
	//	##.#...#
	//	########
	NSArray* lines = @[@"########", @"#S...###", @"##.#...#", @"##.##.##", @"#..#.###", @"##...#G#", @"##.#...#", @"########"];
	NSMutableArray* completeSplit = [[NSMutableArray alloc] init];
	
	int colCount = (int)[lines[0] length];
	
	for (int i = 0; i < [lines count]; i++) {
		completeSplit[i] = [[NSMutableArray alloc] init];
		for (int j = 0; j < colCount; j++) {
			completeSplit[i][j] = [lines[i] substringWithRange:NSMakeRange(j, 1)];
		}
	}
	
	return [completeSplit copy];
}

+ (void) depthFirstSearch {
	Queue* queue = [[Queue alloc] init];
	
	NSString* startChar = @"S";
	NSString* goalChar = @"G";
	
	NSArray* lines = [self dummyFile];
	int rowCount = (int)[lines count];
	int colCount = (int)[lines[0] count];
	
	NSMutableArray* visited = [[NSMutableArray alloc] init];
	
	// intiailize queue (point sets to Start point)
	for (int i = 0; i < rowCount; i++) {
		// loop through each line
		NSArray* line = lines[i];
		visited[i] = [[NSMutableArray alloc] init];

		for (int j = 0; j < colCount; j++) {
			// loop through each char
			NSString* ch = line[j];
			
			if ([ch isEqual:startChar]) {
				// initialize (only if point is S for Start)
				[queue enqueue:@[[NSNumber numberWithInt:i], [NSNumber numberWithInt:j]]];
				visited[i][j] = [NSNumber numberWithBool:TRUE];
			} else {
				visited[i][j] = [NSNumber numberWithBool:FALSE];
			}
		}
	}
	
	Item* currentNode;
	bool isReachable = FALSE;
	
	while (queue.front != nil) {
		// dequeue current position (front)
		currentNode = [queue dequeue];
		
		int row = [[currentNode.object objectAtIndex:0] intValue];
		int col = [[currentNode.object objectAtIndex:1] intValue];
		int top = row-1, bottom = row+1, left = col-1, right = col+1;

		// if current position is goal, end
		if ([lines[row][col] isEqual:goalChar]) {
			isReachable = TRUE;
			break;
		}
		
		// mark current position as visited (front)
		visited[row][col] = [NSNumber numberWithBool:TRUE];

		// enqueue all reachable branches
		// order: top > right > bottom > left
		if (top > -1 && [self isValidMove:lines row:top col:col visited:visited]) {
			// top is valid and not visited
			[queue enqueue:@[[NSNumber numberWithInt:top], [NSNumber numberWithInt:col]] previous:currentNode];
		}
		
		if (right < colCount  && [self isValidMove:lines row:row col:right visited:visited]) {
			// right is valid and not visited
			[queue enqueue:@[[NSNumber numberWithInt:row], [NSNumber numberWithInt:right]] previous:currentNode];
		}
		
		if (bottom < rowCount  && [self isValidMove:lines row:bottom col:col visited:visited]) {
			// bottom is valid and not visited
			[queue enqueue:@[[NSNumber numberWithInt:bottom], [NSNumber numberWithInt:col]] previous:currentNode];
		}
		
		if (left > -1 && [self isValidMove:lines row:row col:left visited:visited]) {
			// left is valid and not visited
			[queue enqueue:@[[NSNumber numberWithInt:row], [NSNumber numberWithInt:left]] previous:currentNode];
		}
	}
	
	if (isReachable) {
//		^(void) {
//			Item* tmp = currentNode;
//			int row = [[tmp.object objectAtIndex:0] intValue];
//			int col = [[tmp.object objectAtIndex:1] intValue];
//			NSLog(@"current (%i,%i)",row+1,col+1);
//			while (tmp.prev != nil) {
//				tmp = tmp.prev;
//				int row = [[tmp.object objectAtIndex:0] intValue];
//				int col = [[tmp.object objectAtIndex:1] intValue];
//				NSLog(@"prev (%i,%i)",row+1,col+1);
//			}
//		}();
	}
}

+ (bool) isValidMove:(NSArray*)lines row:(int)row col:(int)col visited:(NSMutableArray*)visited {
	return ![visited[row][col] boolValue] && ([lines[row][col] isEqual:@"."] || [lines[row][col] isEqual:@"G"]);
}

+ (void) breadthFirstSearch {
	Stack* search = [[Stack alloc] init];
}


//+ (NSDictionary*) dummyFileLinear {
//	NSArray* lines = [self dummyFile];
//	NSNumber* lineSize = [NSNumber numberWithInteger:[lines[0] length]];
//
//	NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
//	dict[@"linear"] = @"";
//	dict[@"lineSize"] = lineSize;
//
//	for (NSString* line in lines) {
//		dict[@"linear"] = [dict[@"linear"] stringByAppendingString:line];
//	}
//
//	return dict;
//
// 	usage:
//	NSString* linear = linearDict[@"linear"];
//	int totalSize = (int)[linear length]; // # of col (total, # of col * # of row)
//	int lineSize = [linearDict[@"lineSize"] intValue]; // # of col in a row
//	int lineCount = totalSize / lineSize; // # of rows
//
//	int (^calcLinearIndex)(int, int) = ^(int row, int col) {
//		return row*lineSize + col;
//	};
//
//	for (int i = 0; i < totalSize; i++) {
//		int row = floor(i/lineSize), col = i%lineSize;
//		int linearIndex = calcLinearIndex(row, col);
//		NSString* ch = [linear substringWithRange:NSMakeRange(linearIndex, 1)];
//	}
//}

@end
