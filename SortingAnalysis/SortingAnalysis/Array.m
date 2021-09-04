//
//  Array.m
//  SortingAnalysis
//
//  Created by Park Jong Won on 4/27/21.
//

#import <Foundation/Foundation.h>
#import "Array.h"

@implementation Array

- (instancetype) initWithSize:(int)size {
	self = [super init];
	if (self) {
		self.array = malloc(size * sizeof(int));
		self.size = size;
		self.index = 0;
	}
	return self;
}

- (void) resize {
	// resize by reallocating the array with double its size
	int newSize = self.size * 2;
	
//	printf("size %d > %d, reallocating to size of %d\n", self.index, self.size, newSize);

	// METHOD 1: realloc & preserve old values (less computation needed)
	// this is faster than METHOD 2 (below)
//	self.array = realloc(self.array, newSize * sizeof(int));
//	self.size = newSize;
	
	// METHOD 2: rudimentary method of initializing new array and transferring value
	int* newArr = malloc(newSize * sizeof(int));
	for (int i = 0; i < self.size; i++) {
		newArr[i] = self.array[i];
	}
	self.array = newArr;
	self.size = newSize;
}

- (void) append:(int)val {
	self.index += 1;
	
	// If new item overflows the current size of array then resize
	if (self.index > self.size) {
		[self resize];
	}
	
	self.array[self.index] = val;
}

- (void) dealloc {
	free(self.array);
}

@end
