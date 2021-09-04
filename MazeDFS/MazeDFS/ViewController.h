//
//  ViewController.h
//  MazeDFS
//
//  Created by Park Jong Won on 4/16/21.
//

#import <Cocoa/Cocoa.h>
#import <SpriteKit/SpriteKit.h>
#import <GameplayKit/GameplayKit.h>
#import "MazeSolver.h"

@interface ViewController : NSViewController

@property (assign) IBOutlet SKView *skView;

@property (nonatomic, strong) MazeSolver* mazeSolver;

@end

