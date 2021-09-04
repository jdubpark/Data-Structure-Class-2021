//
//  ViewController.m
//  BST21Questions
//
//  Created by Jongwon Park on 5/4/21.
//

#import "ViewController.h"
#import "Tree.h"
#import "Node.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    Tree* bst = [[Tree alloc] init];
    
    Node* rootNode = [bst addQuestion:@"Does it have four legs?" forParentNode:bst.root];
    [bst addAnswer:@"Dog" forQuestionNode:rootNode];
    
    Node* question = [bst addQuestion:@"Does it live in water?" forParentNode:rootNode];
    [bst addAnswer:@"Turtle" forQuestionNode:question];
    
    NSLog(@"%@", bst);
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
