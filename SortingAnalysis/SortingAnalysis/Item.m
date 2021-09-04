//
//  item.m
//  StacksAndQueue
//

#import <Foundation/Foundation.h>
#import "Item.h"

@implementation Item

- (instancetype)initWithInt:(int)number {
	self = [super init];
	if (self) {
		self.value = number;
	}
	return self;
}

@end
