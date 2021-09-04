//
//  main.m
//  DFS-BFS
//
//  Created by Park Jong Won on 4/15/21.
//

#import <Foundation/Foundation.h>
#import "Maze.h";

int main(int argc, const char * argv[]) {
	@autoreleasepool {
	    // insert code here...
	    NSLog(@"Hello, World!");
//		[Maze readFile:@"./maze-tests/smallMaze.txt"];
		
		[Maze depthFirstSearch];
		
	}
	return 0;
}
