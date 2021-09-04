//
//  ViewController.m
//  LinkedListApp
//
//  Created by Park Jong Won on 4/8/21.
//

#import "ViewController.h"
#import "FriendTableViewController.h"
#import "LinkedList.h"
#import "ListNode.h"

@implementation ViewController

- (void) dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id) initWithCoder:(NSCoder*)decoder {
	if (self = [super initWithCoder:decoder]) {
		// Custom initialization
		NSLog(@"Intialized Main ViewController...");
	}
	
	// set up notification center to listen to message "FriendSelected" and "GroupSelected"
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(friendSelected:) name:@"FriendSelected" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(groupFriendSelected:) name:@"GroupFriendSelected" object:nil];
	
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.allFriendList = [[LinkedList alloc] init];
	self.myFriendList = [[LinkedList alloc] init];
	
	// Set label settings
	[self.inviteStatusLabel setEditable:NO];
	[self.inviteStatusLabel setSelectable:NO];
	
	// Invite a few friends for starter
	[self inviteNewFriend:@"Alice"];
	[self inviteNewFriend:@"Bob"];
	[self inviteNewFriend:@"Cat"];
	
	
//	
//	
//	[self.friendTableView insertRowsAtIndexes:[NSIndexSet indexSetWithIndex:0] withAnimation:NSTableViewAnimationSlideDown];
//
//	[self.friendTableView selectRowIndexes:[NSIndexSet indexSetWithIndex:0] byExtendingSelection:NO];
//	
//	[self.friendTableView scrollRowToVisible:0];

//	 [self.friendTableView insertRowsAtIndexes:[NSIndexSet indexSetWithIndex:newRowIndex] withAnimation:NSTableViewAnimationSlideDown];
//
//	 [self.friendTableView selectRowIndexes:[NSIndexSet indexSetWithIndex:newRowIndex] byExtendingSelection:NO];
//	 [self.friendTableView scrollRowToVisible:newRowIndex];
}


- (void) setRepresentedObject:(id)representedObject {
	[super setRepresentedObject:representedObject];

	// Update the view, if already loaded.
}

#pragma mark - Modifying Lists

- (void) inviteNewFriend:(NSString*)name {
	ListNode *friendNode = [[ListNode alloc] initWithName:name];
	ListNode *pointerNode = [[ListNode alloc] initWithPointer:friendNode];
	
	[self.allFriendList addNode:friendNode atIndex:[self.allFriendList count]];
	[self.myFriendList addNode:pointerNode atIndex:[self.myFriendList count]];
	
	[self reloadFriendTable];
}

- (void) inviteNewFriendForGroup:(NSString*)name {
	ListNode *friendNode = [[ListNode alloc] initWithName:name];
	
	[self.allFriendList addNode:friendNode atIndex:[self.allFriendList count]];
	
	[self reloadFriendTable];
	[self reloadGroupTable];
}

- (void) addFriendToGroup:(NSString*)name {
	ListNode *pointer = [self.allFriendList findNodeWithName:name];
	
	if (pointer == nil || pointer.name == nil) {
		// add new friend to global friendList
		[self inviteNewFriendForGroup:name];
		pointer = [self.allFriendList last]; // get the friend added just now
	}
	
	ListNode *groupFriendNode = [[ListNode alloc] initWithPointer:pointer];
	
	int lastIndex = [self.groupNode.friendPointers count];
//	NSLog(@"%@ == %@",pointer.name,groupFriendNode.pointer.name);
	[self.groupNode.friendPointers addNode:groupFriendNode atIndex:lastIndex];
	
	[self reloadGroupTable];
}

#pragma mark - Button Clicks

- (void) inviteButtonClicked:(id)sender {
	NSString *inviteName = [self.inviteNameTextField stringValue];
	
	if ([inviteName length] == 0) {
		[self.inviteStatusLabel setStringValue:@"Name is empty!"];
		return;
	}

	// proceed with invitee's name
	bool isInList = [self.allFriendList isInList:inviteName];
	
	if (isInList) {
		[self.inviteStatusLabel setStringValue:[[NSString alloc] initWithFormat:@"%@ is already invited!", inviteName]];
	} else {
		[self inviteNewFriend:inviteName];
		[self.inviteNameTextField setStringValue:@""];
		[self.inviteStatusLabel setStringValue:[[NSString alloc] initWithFormat:@"Congrats! %@ is now invited!", inviteName]];
	}
}

- (void) addToGroupButtonClicked:(id)sender {
	NSString *friendName = [self.groupFriendNameTextField stringValue];
	
	if ([friendName length] == 0) {
		[self.groupStatusLabel setStringValue:@"Name is empty!"];
		return;
	}

	// proceed with group's new friend name
	bool isPointerInList = [self.groupNode.friendPointers isPointerInList:friendName];
	
	if (isPointerInList) {
		[self.groupStatusLabel setStringValue:[[NSString alloc] initWithFormat:@"%@ is already %@'s friend!", friendName, self.groupNode.name]];
	} else {
		[self addFriendToGroup:friendName];
		[self.groupFriendNameTextField setStringValue:@""];
		[self.groupStatusLabel setStringValue:[[NSString alloc] initWithFormat:@"%@'s friend %@ is added!", self.groupNode.name, friendName]];
	}
}

#pragma mark - Notification Listeners

- (void) friendSelected:(NSNotification*)notification {
	NSDictionary* userInfo = notification.userInfo;
	self.groupNode = userInfo[@"groupNode"];
//	NSLog(@"%@", self.groupNode.name);
//	NSLog(@"%@", self.groupNode.friendPointers);
	[self.groupLabel setStringValue:[[NSString alloc] initWithFormat:@"Friends of %@", self.groupNode.name]];
	[self reloadGroupTable];
}

- (void) groupFriendSelected:(NSNotification*)notification {
//	NSDictionary* userInfo = notification.userInfo;
//	self.groupNode = userInfo[@"groupNode"];
//	NSLog(@"%@", self.groupNode.name);
//	[self.groupLabel setStringValue:[[NSString alloc] initWithFormat:@"Friends of %@", self.groupNode.name]];
}

#pragma mark - Notification Dispatchers

- (void) reloadFriendTable {
	// send notification "ReloadFriendTable"
	NSDictionary* userInfo = [NSDictionary dictionaryWithObject:self.myFriendList forKey:@"myFriendList"];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadFriendTable" object:self userInfo:userInfo];
}

- (void) reloadGroupTable {
	// send notification "ReloadFriendTable"
	NSDictionary* userInfo = [NSDictionary dictionaryWithObject:self.groupNode.friendPointers forKey:@"groupPointerList"];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadGroupTable" object:self userInfo:userInfo];
}


@end
