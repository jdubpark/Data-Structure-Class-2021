//
//  Timer.m
//  SortingAnalysis
//
//  Created by Park Jong Won on 4/26/21.
//

#import <Foundation/Foundation.h>
#import "Timer.h"

@implementation Timer {
	uint64_t startTime;
	uint64_t endTime;
}

- (id) init {
	self = [super init];
	startTime = 0.0;
	return self;
}

- (void) start {
	startTime = mach_absolute_time(); // in nanoseconds
}

- (void) end {
	endTime = mach_absolute_time(); // in nanoseconds
	uint64_t elapsedNano = endTime - startTime;
	self.elapsedNano = elapsedNano;
	self.elapsed = elapsedNano / 1000.0 / 1000.0; // nano -> micro -> mili
}

@end
