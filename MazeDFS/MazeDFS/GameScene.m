//
//  GameScene.m
//  MazeDFS
//
//  Created by Park Jong Won on 4/16/21.
//

#import "GameScene.h"
#import "MazeSolver.h"
#import "Item.h"

@implementation GameScene {
	NSMutableArray* grid;
	Item* currentNode;
	
	// for maze solver
	MazeSolver* mazeSolver;
	int rowCount;
	int colCount;
	
	// offsets
	CGFloat topMost;
	CGFloat bottomMost;
	CGFloat leftMost;
	CGFloat rightMost;
	// for grid outline
	CGFloat outlineHeight;
	CGFloat outlineWidth;
	CGFloat outlineWidthMargin;
	CGFloat outlineLeftMost;
	// for rect in grid
	CGFloat height;
	CGFloat width;
}

- (void) didMoveToView:(SKView *)view {
	//
	// select maze:
	//
//	NSString* mazePath = @"./maze-tests/smallMaze";
//	NSString* mazePath = @"./maze-tests/mediumMaze";
	NSString* mazePath = @"./maze-tests/largeMaze";
//	NSString* mazePath = @"./maze-tests/hugeMaze";
	
	// frame (whole window) locations metadata
	topMost = 0+view.frame.size.height/2;
	bottomMost = 0-view.frame.size.height/2;
	leftMost = 0-view.frame.size.width/2;
	rightMost = 0+view.frame.size.width/2;
	
	// outline (actual maze) size
	outlineHeight = topMost-bottomMost;
	outlineWidth = outlineHeight; // make it square // rectangular: rightMost-leftMost;
	outlineWidthMargin = outlineHeight-(rightMost-leftMost);
	
	outlineLeftMost = leftMost - outlineWidthMargin/2;
	
	// maze outline (square)
	SKShapeNode* outline = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(outlineWidth, outlineHeight)];
	CGPoint outlineCenterPoint = CGPointMake(outlineLeftMost+outlineWidth/2, topMost-outlineHeight/2);
	outline.lineWidth = 2.0;
	outline.position = outlineCenterPoint;
	outline.strokeColor = [SKColor whiteColor];
	[self addChild:outline];
	
	// MazeSolver
	mazeSolver = [[MazeSolver alloc] init];
	[mazeSolver startNewMaze:mazePath]; // don't append .txt (automatically added)
	
	rowCount = mazeSolver.rowCount;
	colCount = mazeSolver.colCount;
	
	// size of each grid
	height = MIN(30.0, outlineHeight/rowCount); // max height is 30
	width = MIN(30.0, outlineWidth/colCount); // max width is 30
	
	[self drawGrid];
	
	// YES to test grid drawing
//	self.view.paused = YES;
}

- (void) update:(CFTimeInterval)currentTime {

	// Called before each frame is rendered
	
	NSArray* ret = [mazeSolver search]; // return value [currentNode, is Solved or Empty]
	currentNode = ret[0];
	bool isSolved = [ret[1] isEqual:@"SOLVED"];
	bool isEmpty = [ret[1] isEqual:@"EMPTY"];

	if (isSolved || isEmpty) {
		// either solved or empty, pause drawing
		self.view.paused = YES;
		if (isSolved) {
			[self backtraceSolution];
			NSLog(@"Solved!");
			return;
		}
		
		NSLog(@"Unsolvable!");
	} else {
		// continue drawing (still solving)

		// location of current node
		int row = [[currentNode.object objectAtIndex:0] intValue];
		int col = [[currentNode.object objectAtIndex:1] intValue];
		
		// easy: just change the color of explored grid
		SKShapeNode* rect = grid[row][col];
		rect.fillColor = [SKColor redColor];
	}
}

- (void) drawGrid {
	grid = [[NSMutableArray alloc] init];

	// initialize a pre-defined grid of size m and n
	// where m & n are # of squares in maze (m = n as these mazes are squares)
	// BENEFIT:
	// by pre-initializing the grids, we draw them first, and
	// all we need to do later is change the color
	for (int i = 0; i < rowCount; i++) {
		grid[i] = [[NSMutableArray alloc] init];
		
		for (int j = 0; j < colCount; j++) {
			NSString* value = mazeSolver.lines[i][j];

			// each grid square
			SKShapeNode* rect = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(width, height)];
			grid[i][j] = rect;
			
			CGFloat rectX = outlineLeftMost+j*width+width/2; // +width/2 to center the drawing's width
			CGFloat rectY = topMost-i*height-height/2; // -height/2 to center the drawing's height
			rect.lineWidth = 2.0;
			rect.position = CGPointMake(rectX, rectY);
			
			if ([value isEqual:@"#"]) {
				// WALL setting
				rect.fillColor = [SKColor whiteColor]; // lightGrayColor
				rect.strokeColor = [SKColor whiteColor];
			} else if ([value isEqual:@"S"]) {
				// START setting
				rect.fillColor = [SKColor blueColor];
			} else if ([value isEqual:@"G"]) {
				// GOAL setting
				rect.fillColor = [SKColor yellowColor];
			}
			
			// add grid square to the grid
			[self addChild:rect];
		}
	}
}

- (void) backtraceSolution {
	SKShapeNode* rect;

	Item* node = currentNode.next; // skip the GOAL node (preserve color)
	while (node.next != nil) {
		int row = [[node.object objectAtIndex:0] intValue];
		int col = [[node.object objectAtIndex:1] intValue];
		rect = grid[row][col];
		rect.fillColor = [SKColor greenColor];
		node = node.next;
	}
	
	// first node in queue (STARTING POINT)
	int row = [[node.object objectAtIndex:0] intValue];
	int col = [[node.object objectAtIndex:1] intValue];
	rect = grid[row][col];
	rect.fillColor = [SKColor blueColor];
}

 

@end
