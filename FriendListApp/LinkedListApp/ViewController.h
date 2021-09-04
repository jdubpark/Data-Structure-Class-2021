//
//  ViewController.h
//  LinkedListApp
//
//  Created by Park Jong Won on 4/8/21.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "FriendTableViewController.h"
#import "LinkedList.h"

@interface ViewController : NSViewController

@property (nonatomic, strong) LinkedList *myFriendList;
@property (nonatomic, strong) LinkedList *allFriendList;
@property (nonatomic, strong) ListNode *groupNode;

@property (nonatomic, strong) NSTableView *friendTableView;

@property (assign) IBOutlet NSTextField *inviteNameTextField;
@property (assign) IBOutlet NSButton *inviteButton;
@property (assign) IBOutlet NSTextField  *inviteStatusLabel;

@property (assign) IBOutlet NSTextField *groupFriendNameTextField;
@property (assign) IBOutlet NSButton *addToGroupButton;
@property (assign) IBOutlet NSTextField *groupLabel;
@property (assign) IBOutlet NSTextField *groupStatusLabel;

- (IBAction) inviteButtonClicked:(id)sender;
- (IBAction) addToGroupButtonClicked:(id)sender;
//- (IBAction) secondDateClicked:(id)sender;

@end

