//
//  ViewController.m
//  MazeDFS
//
//  Created by Park Jong Won on 4/16/21.
//

#import "ViewController.h"
#import "GameScene.h"

@implementation ViewController

- (void) viewDidLoad {
    [super viewDidLoad];

    // Load the SKScene from 'GameScene.sks'
    GameScene *scene = (GameScene *)[SKScene nodeWithFileNamed:@"GameScene"];
    
    // Set the scale mode to scale to fit the window
    scene.scaleMode = SKSceneScaleModeAspectFill;	
    
    // Present the scene
    [self.skView presentScene:scene];
    
    self.skView.showsFPS = NO;
    self.skView.showsNodeCount = NO;
}

@end
