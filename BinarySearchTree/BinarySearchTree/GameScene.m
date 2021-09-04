//
//  GameScene.m
//  BinarySearchTree
//
//  Created by Jongwon Park on 5/4/21.
//

#import "GameScene.h"
#import "Tree.h"
#import "ListNode.h"

@implementation GameScene {
    Tree* bst;

    float screenHeight;
    float screenWidth;
    float nodeWidth;
    float nodeHeight;

    float yTop;
    float yBottom;
    float xLeft;
    float xRight;
    
    float spaceFromTop;
    float spaceBetweenLevels;
    
    NSTextField* heightLabel;
    NSTextField* sizeLabel;
    NSTextField* nodeValueLabel;
    NSButton* addNodeButton;
    NSButton* deleteNodeButton;
    
    NSMutableArray* allTreeNodes;
    NSMutableArray* allTreeLines;
}

- (void)didMoveToView:(SKView*)view {
    
    screenHeight = view.frame.size.height;
    screenWidth = view.frame.size.width;

    // for SKNodes that have center as position (0,0)
    yTop = -screenHeight/2;
    yBottom = screenHeight/2;
    xLeft = -screenWidth/2;
    xRight = screenWidth/2;
    
    spaceFromTop = 80;
    spaceBetweenLevels = 50;
    
    nodeWidth = 50;
    nodeHeight = 50;
    
    // initial bst
    bst = [[Tree alloc] init];
    [bst putKeyWrapper:20];
    [bst putKeyWrapper:10];
    [bst putKeyWrapper:30];
    [bst putKeyWrapper:5];
    [bst putKeyWrapper:15];
    [bst putKeyWrapper:17];
    [bst putKeyWrapper:18];
    [bst putKeyWrapper:16];
    [bst putKeyWrapper:283];
    
    allTreeNodes = [[NSMutableArray alloc] init]; // to store tree nodes for ease
    allTreeLines = [[NSMutableArray alloc] init]; // to store tree lines for ease
    
    [self initScreenObjects];
    [self redrawAllTreeLevels];
}

// MARK: Redraw Tree

- (void) redrawAllTreeLevels {
    int treeHeight = [bst heightWrapper];
    int treeSize = [bst sizeWrapper];
    int treeLevels = treeHeight+1; // height counts from 0

    [heightLabel setStringValue:[NSString stringWithFormat:@"Height: %d",treeHeight]];
    [sizeLabel setStringValue:[NSString stringWithFormat:@"Size: %d",treeSize]];
    
    [self clearAllTreeNodes];
    [self clearAllTreeLines];
    
    // root level
    SKShapeNode* skRootNode = [self createTreeNode:bst.root atLevel:0 atPosition:1];
    
    // subsequent levels
    if (treeLevels > 1) {
        [self redrawTreeWithRoot:bst.root.leftChild atLevel:1 nodePosition:1 skParentNode:skRootNode];
        [self redrawTreeWithRoot:bst.root.rightChild atLevel:1 nodePosition:2 skParentNode:skRootNode];
    }
}

- (void) redrawTreeWithRoot:(Node*)node atLevel:(int)level nodePosition:(int)position skParentNode:(SKShapeNode*)skParentNode {
//    int maxNodesAtThisLevel = pow(2, level);
    
    SKShapeNode* skChildNode = [self createTreeNode:node atLevel:level atPosition:position];
    [self createTreeLineFromNode:skParentNode toNode:skChildNode];
    
    if (node.leftChild) {
        [self redrawTreeWithRoot:node.leftChild atLevel:level+1 nodePosition:position skParentNode:skChildNode];
    }

    if (node.rightChild) {
        // When moving right, increment position by 1
        // But if left child is empty, increment position by 2 instead (to account for blank space)
        int addValue = !node.leftChild ? 2 : 1;
        
//        if (!node.parent.leftChild)
//            addValue += 2;
        
        [self redrawTreeWithRoot:node.rightChild atLevel:level+1 nodePosition:position+addValue skParentNode:skChildNode];
    }
}

// MARK: Tree Nodes

- (SKShapeNode*) createTreeNode:(Node*)node atLevel:(int)level atPosition:(int)position {
    float levelScreenWidth = screenWidth / pow(2, level);
    float offset = levelScreenWidth * (position-1);
    
    CGFloat nodeX = xLeft + [self centerOfWidth:levelScreenWidth withOffset:offset forItemWidth:nodeWidth];
    CGFloat nodeY = yTop + [self levelDistanceFromTop:level] + 100;
    
    CGSize nodeSize = CGSizeMake(nodeWidth, nodeHeight);
    CGPoint nodePosition = CGPointMake(nodeX, nodeY);
    
    SKShapeNode* treeNode = [SKShapeNode shapeNodeWithRectOfSize:nodeSize];
    treeNode.lineWidth = 2.0;
    treeNode.position = nodePosition;
    treeNode.fillColor = [SKColor darkGrayColor];
    
    SKLabelNode* treeLabel = [SKLabelNode labelNodeWithText:[NSString stringWithFormat:@"%d",node.key]];
    treeLabel.fontName = @"AvenirNext-Bold"; // makes it bold
    treeLabel.position = [self getCenterOfNode:treeNode];
    treeLabel.color = [SKColor whiteColor];
    treeLabel.fontSize = 16;

    [self addChild:treeNode];
    [self addChild:treeLabel];
    
    [allTreeNodes addObject:treeNode];
    [allTreeNodes addObject:treeLabel];
    
    return treeNode;
}

// MARK: Tree Lines

- (void) createTreeLineFromNode:(SKNode*)fNode toNode:(SKNode*)tNode {
    SKShapeNode *treeLine = [SKShapeNode node];
    CGMutablePathRef pathToDraw = CGPathCreateMutable();
    
    CGFloat fNodeCenterX = fNode.frame.origin.x + fNode.frame.size.width/2;
    CGFloat tNodeCenterX = tNode.frame.origin.x + fNode.frame.size.width/2;
    CGFloat fNodeBottomY = fNode.frame.origin.y;
    CGFloat tNodeTopY = tNode.frame.origin.y + fNode.frame.size.height;

    CGPathMoveToPoint(pathToDraw, NULL, fNodeCenterX, fNodeBottomY);
    CGPathAddLineToPoint(pathToDraw, NULL, tNodeCenterX, tNodeTopY);

    treeLine.path = pathToDraw;
    [treeLine setStrokeColor:[SKColor redColor]];
    [treeLine setLineWidth:2.0];
    
    [allTreeLines addObject:treeLine];
    [self addChild:treeLine];
}

- (void) clearAllTreeNodes {
    [self removeChildrenInArray:allTreeNodes];
    [allTreeNodes removeAllObjects];
}

- (void) clearAllTreeLines {
    [self removeChildrenInArray:allTreeLines];
    [allTreeLines removeAllObjects];
}

// MARK: Positioning

- (CGFloat) levelDistanceFromTop:(int)level {
    return screenHeight - (level * (nodeHeight + spaceBetweenLevels) + spaceFromTop);
}

- (CGFloat) centerOfWidth:(int)totalWidth withOffset:(int)offset forItemWidth:(int)itemWidth {
    CGFloat centerX = totalWidth/2 - itemWidth/2;
    return offset+centerX;
}

- (CGPoint) getCenterOfNode:(SKNode*)node {
    CGFloat centerX = node.frame.origin.x + node.frame.size.width/2;
    CGFloat centerY = node.frame.origin.y + node.frame.size.height/2 - 5;
    return CGPointMake(centerX, centerY);
}

// MARK: Trivial components

- (NSTextField*) pseudoNSLabel:(NSRect)frame {
    NSTextField* nsLabel = [[NSTextField alloc] initWithFrame:frame];
    [nsLabel setSelectable:FALSE];
    [nsLabel setBordered:FALSE];
    [nsLabel setEditable:FALSE];
    [nsLabel setBezeled:FALSE];
    [nsLabel setDrawsBackground:FALSE];
    [nsLabel setTextColor:[NSColor blackColor]];
    [nsLabel setFont:[NSFont fontWithName:@"Helvetica" size:14]];
    return nsLabel;
}

// MARK: Button Clicks

- (void) addNodeButtonClicked:(id)sender {
    int nodeValue = [nodeValueLabel intValue]; // get int from input
    [nodeValueLabel setStringValue:@""]; // clear input
    [bst putKeyWrapper:nodeValue]; // add int
    [self redrawAllTreeLevels];
}

- (void) deleteNodeButtonClicked:(id)sender {
    int nodeValue = [nodeValueLabel intValue]; // get int from input
    [nodeValueLabel setStringValue:@""]; // clear input
    [bst deleteKey:nodeValue]; // add int
    [self redrawAllTreeLevels];
}

// MARK: Initialize Screen

- (void) initScreenObjects {
    float defaultWidth = 70;
    float defaultHeight = 30;

    float infoLabelX = 15;
    float nodeValueLabelX = screenWidth - defaultWidth*3 - 70;
    float addButtonX = screenWidth - defaultWidth*2 - 60;
    float deleteButtonX = screenWidth - defaultWidth - 50;

    float heightLabelY = screenHeight - 50;
    float sizeLabelY = screenHeight - 75;
    float toolBarY = defaultHeight + 10;
    
    // height & size labels
    NSRect heightFrame = NSMakeRect(infoLabelX, heightLabelY, defaultWidth, defaultHeight);
    heightLabel = [self pseudoNSLabel:heightFrame];
    [heightLabel setStringValue:@"Height: 0"];
    
    NSRect sizeFrame = NSMakeRect(infoLabelX, sizeLabelY, defaultWidth, defaultHeight);
    sizeLabel = [self pseudoNSLabel:sizeFrame];
    [sizeLabel setStringValue:@"Size: 0"];
    
    // value input for adding new node
    nodeValueLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(nodeValueLabelX, toolBarY, defaultWidth, defaultHeight)];
    [nodeValueLabel setStringValue:@""];
    [nodeValueLabel setFont:[NSFont fontWithName:@"Helvetica" size:20]];
    [nodeValueLabel setBordered:YES];
    
    // button to add new node with given value
    addNodeButton = [[NSButton alloc] initWithFrame:NSMakeRect(addButtonX, toolBarY, defaultWidth, defaultHeight)];
    [addNodeButton setTitle:@"Add"];
    [addNodeButton setFont:[NSFont fontWithName:@"Helvetica" size:14]];
    [addNodeButton setTarget:self];
    [addNodeButton setAction:@selector(addNodeButtonClicked:)];
    
    // button to delete node of given value
    deleteNodeButton = [[NSButton alloc] initWithFrame:NSMakeRect(deleteButtonX, toolBarY, defaultWidth, defaultHeight)];
    [deleteNodeButton setTitle:@"Delete"];
    [deleteNodeButton setFont:[NSFont fontWithName:@"Helvetica" size:14]];
    [deleteNodeButton setTarget:self];
    [deleteNodeButton setAction:@selector(deleteNodeButtonClicked:)];
    
    // add all to subviews
    [self.view addSubview:heightLabel];
    [self.view addSubview:sizeLabel];
    [self.view addSubview:nodeValueLabel];
    [self.view addSubview:addNodeButton];
    [self.view addSubview:deleteNodeButton];
    
    // update mutable subviews
    [heightLabel setWantsLayer:YES];
    [sizeLabel setWantsLayer:YES];
}

@end
