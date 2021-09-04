//
//  FriendTableViewController.m
//  FriendListApp
//
//  Created by Park Jong Won on 4/11/21.
//

#import "FriendTableViewController.h"
#import "LinkedList.h"
#import "ListNode.h"

@implementation FriendTableViewController

- (void) dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id) init {
	if (self = [super init]) {}
	
	// set up notification center to listen to message "ReloadFriendTable"
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableViewData:) name:@"ReloadFriendTable" object:nil];

	return self;
}

- (void) viewDidLoad {
	self.friendList = [[LinkedList alloc] init];
}

#pragma mark - NSTableViewDataSource

- (NSInteger) numberOfRowsInTableView:(NSTableView*)tableView {
	return [self.friendList count];
}

#pragma mark - NSTableViewDelegate

- (NSView*) tableView:(NSTableView*)tableView viewForTableColumn:(NSTableColumn*)tableColumn row:(NSInteger)row {
	NSString *identifier = tableColumn.identifier;
	NSTableCellView *cell = [tableView makeViewWithIdentifier:identifier owner:self];
	
	if ([identifier isEqualToString:@"friendNameColumn"]) {
		ListNode *friend = [self.friendList nodeAt:(int)row];
		if (friend.pointer.name != nil) {
			cell.textField.stringValue = friend.pointer.name;
		}
	}
	
	return cell;
}

#pragma mark - TableView Methods

- (void) reloadTableViewData:(NSNotification*)notification {
	NSDictionary* userInfo = notification.userInfo;
	self.friendList = userInfo[@"myFriendList"];

	if (self.friendList != nil) {
		[self.tableView reloadData];
	}
}

- (void) tableViewSelectionDidChange:(NSNotification*)notification {
	int rowIndex = (int)[[notification object] selectedRow];
	ListNode *selectedFriend = [self.friendList nodeAt:rowIndex];
	
	// send notification "FriendSelected"
	NSDictionary* userInfo = [NSDictionary dictionaryWithObject:selectedFriend.pointer forKey:@"groupNode"];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"FriendSelected" object:self userInfo:userInfo];
}

@end
