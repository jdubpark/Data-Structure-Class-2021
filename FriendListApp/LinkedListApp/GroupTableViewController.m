//
//  GroupTableViewController.m
//  FriendListApp
//
//  Created by Park Jong Won on 4/11/21.
//

#import "GroupTableViewController.h"
#import "LinkedList.h"
#import "ListNode.h"

@implementation GroupTableViewController

- (void) dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id) init {
	if (self = [super init]) {}
	
	// set up notification center to listen to message "ReloadGroupTable"
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableViewData:) name:@"ReloadGroupTable" object:nil];

	return self;
}

- (void) viewDidLoad {
	self.groupPointerList = [[LinkedList alloc] init];
}

#pragma mark - NSTableViewDataSource

- (NSInteger) numberOfRowsInTableView:(NSTableView*)tableView {
	return [self.groupPointerList count];
}

#pragma mark - NSTableViewDelegate

- (NSView*) tableView:(NSTableView*)tableView viewForTableColumn:(NSTableColumn*)tableColumn row:(NSInteger)row {
	NSString *identifier = tableColumn.identifier;
	NSTableCellView *cell = [tableView makeViewWithIdentifier:identifier owner:self];
	
	if ([identifier isEqualToString:@"groupFriendNameColumn"]) {
		ListNode *friend = [self.groupPointerList nodeAt:(int)row];
		if (friend.pointer.name != nil) {
			cell.textField.stringValue = friend.pointer.name;
		}
	}
	
	return cell;
}

#pragma mark - TableView Methods

- (void) reloadTableViewData:(NSNotification*)notification {
	NSDictionary* userInfo = notification.userInfo;
	self.groupPointerList = userInfo[@"groupPointerList"];
	
	NSLog(@"---- Clicked Friend Group ----");
	int friendCount = [self.groupPointerList count];
	if (friendCount == 0) {
		NSLog(@"No friends yet :/");
	} else {
		for (int i = 0; i < friendCount; i++) {
			NSLog(@"Friend %i - %@", i+1, [self.groupPointerList nodeAt:i].pointer.name);
		}
	}

	// update
	if (self.groupPointerList != nil) {
		[self.tableView reloadData];
	}
}

- (void) tableViewSelectionDidChange:(NSNotification*)notification {
	int rowIndex = (int)[[notification object] selectedRow];
	ListNode *selectedFriend = [self.groupPointerList nodeAt:rowIndex];
	
	// send notification "GroupFriendSelected"
	NSDictionary* userInfo = [NSDictionary dictionaryWithObject:selectedFriend forKey:@"groupNode"];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"GroupFriendSelected" object:self userInfo:userInfo];
}

@end
