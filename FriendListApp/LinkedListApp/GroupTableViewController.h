//
//  GroupTableViewController.h
//  FriendListApp
//
//  Created by Park Jong Won on 4/11/21.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "LinkedList.h"

NS_ASSUME_NONNULL_BEGIN

@interface GroupTableViewController : NSObject <NSTableViewDataSource, NSTableViewDelegate>

@property (nonatomic, strong) IBOutlet NSTableView *tableView;

@property (nonatomic, strong) LinkedList *groupPointerList;

@end

NS_ASSUME_NONNULL_END
