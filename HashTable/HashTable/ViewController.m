//
//  ViewController.m
//  HashTable
//
//  Created by Jongwon Park on 5/16/21.
//

#import "ViewController.h"
#import "HashTable.h"

@implementation ViewController {
    HashTable *hashTable;
    NSTextField *findKeyInput;
    NSTextField *findKeyResult;
    NSTextField *findKeyOps;
    NSButton *findKeyButton;
    
    NSTextField *addKeyInput;
    NSTextField *addKeyResult;
    NSTextField *addKeyOps;
    NSButton *addKeyButton;
    
    double yTop;
}

- (void) setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
//    hashTable = [[HashTable alloc] initWithHashFunction:@"simpleASCII"];
    hashTable = [[HashTable alloc] initWithHashFunction:@"simpleASCII"];
    [hashTable readFromFile:@"1000WordDictionary"];
    
    // positioning
    yTop = self.view.frame.size.height;
    
    //
    // populate items for view
    //
    
    // section: find key
    findKeyInput = [[NSTextField alloc] initWithFrame:NSMakeRect(50, yTop-50, 120, 25)];
    [findKeyInput setFont:[NSFont fontWithName:@"Helvetica" size:16]];
    [[findKeyInput cell] setPlaceholderString:@"Enter key to find"];
    
    findKeyButton = [[NSButton alloc] initWithFrame:NSMakeRect(180, yTop-50, 80, 25)];
    [findKeyButton setTitle:@"Find Key"];
    [findKeyButton setFont:[NSFont fontWithName:@"Helvetica" size:16]];
    [findKeyButton setTarget:self];
    [findKeyButton setAction:@selector(findKeyButtonClicked:)];
    
    findKeyResult = [self createNSLabelWithFrame:NSMakeRect(50, yTop-90, 200, 25) andString:@"Search to show..."];
    findKeyOps = [self createNSLabelWithFrame:NSMakeRect(50, yTop-120, 200, 25) andString:@"# of collision: ..."];
    
    // section: add key
    addKeyInput = [[NSTextField alloc] initWithFrame:NSMakeRect(50, yTop-150, 120, 25)];
    [addKeyInput setFont:[NSFont fontWithName:@"Helvetica" size:16]];
    [[addKeyInput cell] setPlaceholderString:@"Enter key to add"];
    
    addKeyButton = [[NSButton alloc] initWithFrame:NSMakeRect(180, yTop-150, 80, 25)];
    [addKeyButton setTitle:@"Add Key"];
    [addKeyButton setFont:[NSFont fontWithName:@"Helvetica" size:16]];
    [addKeyButton setTarget:self];
    [addKeyButton setAction:@selector(addKeyButtonClicked:)];
    
    addKeyResult = [self createNSLabelWithFrame:NSMakeRect(50, yTop-190, 200, 25) andString:@"Add to show..."];
    addKeyOps = [self createNSLabelWithFrame:NSMakeRect(50, yTop-220, 200, 25) andString:@"# of collision: ..."];
    
    // add all of them
    [self.view addSubview:findKeyInput];
    [self.view addSubview:findKeyButton];
    [self.view addSubview:findKeyResult];
    [self.view addSubview:findKeyOps];
    [self.view addSubview:addKeyInput];
    [self.view addSubview:addKeyButton];
    [self.view addSubview:addKeyResult];
    [self.view addSubview:addKeyOps];
}

- (NSTextField*) createNSLabelWithFrame:(NSRect)frameRect andString:(NSString*)string {
    NSTextField *label = [[NSTextField alloc] initWithFrame:frameRect];
    [label setStringValue:string];
    [label setFont:[NSFont fontWithName:@"Helvetica" size:16]];
    [label setBezeled:NO];
    [label setDrawsBackground:NO];
    [label setEditable:NO];
    [label setSelectable:NO];
    return label;
}

// MARK: Button Actions

- (void) findKeyButtonClicked:(id)sender {
    NSString *input = [findKeyInput stringValue];
    
    if ([input isEqualTo:@""])
        return;
    
    // returns ["found/not-found", index (if found), # of collision (if found)]
    NSArray *ret = [hashTable findKey:input];
    [findKeyInput setStringValue:@""];
    
    if ([ret[0] isEqualTo:@"found"]) {
        [findKeyResult setStringValue:[NSString stringWithFormat:@"Key FOUND at index: %lu", [ret[1] unsignedLongValue]]];
        [findKeyOps setStringValue:[NSString stringWithFormat:@"# of collision: %i", [ret[2] intValue]]];
    } else {
        [findKeyResult setStringValue:@"Key is NOT found!"];
        [findKeyOps setStringValue:@"# of collision: ..."];
    }
    
    NSLog(@"find %@",ret);
}

- (void) addKeyButtonClicked:(id)sender {
    NSString *input = [addKeyInput stringValue];
    
    if ([input isEqualTo:@""])
        return;
    
    [addKeyInput setStringValue:@""];
    
    // returns ["added/exists", added/found index, # of collision]
    NSArray *ret = [hashTable addKey:input];
    if ([ret[0] isEqualTo:@"added"])
        [addKeyResult setStringValue:[NSString stringWithFormat:@"Key ADDED at index: %lu", [ret[1] unsignedLongValue]]];
    else
        [addKeyResult setStringValue:[NSString stringWithFormat:@"Key EXISTS at index: %lu", [ret[1] unsignedLongValue]]];
    
    [addKeyOps setStringValue:[NSString stringWithFormat:@"# of collision: %i", [ret[2] intValue]]];
    
    NSLog(@"add %@",ret);
}


@end
