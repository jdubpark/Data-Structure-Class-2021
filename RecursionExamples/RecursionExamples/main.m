//
//  main.m
//  RecursionExamples
//
//  Created by Park Jong Won on 4/1/21.
//

#import <Foundation/Foundation.h>
//#import "main.h"

@interface Recursion : NSObject

+ (int) count7:(int)n;

@end

@implementation Recursion

+ (int) count7:(int)n {
	int count = 0;
	if (n%10==7) count++; // last digit is 7
	if (n/10==0)
		return count; // end of digit
	return count + [self count7:n/10]; // else
}

+ (NSString*) noX:(NSString*)s {
	if ([s length] <= 1) return [s isEqual:@"x"] ? @"" : s;
	NSString *pop = [s substringFromIndex:1];
	if ([[s substringToIndex:1] isEqual:@"x"])
		return [self noX:pop];
	return [NSString stringWithFormat:@"%@%@", [s substringToIndex:1], [self noX:pop]];
}

+ (NSString*) noXRegEx:(NSString*)str {
	NSError *error = nil;
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"x" options:NSRegularExpressionCaseInsensitive error:&error];
	NSString *modifiedString = [regex stringByReplacingMatchesInString:str options:0 range:NSMakeRange(0, [str length]) withTemplate:@""];
	return modifiedString;
}

+ (BOOL) array6:(NSArray*)arr index:(int)i {
	// base case:
	// if (array is empty or we looped all elements) return false
	if ([arr count] <= i)
		return false; // 0 NO
	// step case:
	// if (is 6 at index i) return true;
	// else recursive;
	if ([[arr objectAtIndex:i] isEqualToNumber:[NSNumber numberWithInt:6]])
		return true; // 1 YES
	return [self array6:arr index:i+1];
}

+ (BOOL) groupSum:(int)start nums:(NSArray*)nums target:(int)target {
	if (start >= [nums count]) {
		return target == 0;
	} else {
		// case1: target = target - nums[start] (nums[start] is aaded)
		// case2: without base added
		bool case1 = [self groupSum:start+1 nums:nums target:target-[nums[start] intValue]];
		bool case2 = [self groupSum:start+1 nums:nums target:target];
		// true means target == 0
		return case1 == true || case2 == true;
	}
}

@end



int main(int argc, const char * argv[]) {
	@autoreleasepool {
	    // insert code here...
	    NSLog(@"Hello, World!");
//		Recursion *recursion = [[Recursion alloc] init];
		
//		assert([Recursion count7:717] == 2);
//		assert([Recursion count7:7] == 1);
//		assert([Recursion count7:123] == 0);
//		NSLog(@"Passed: count7");

//		assert([[Recursion noX:@"xaxb"] isEqual:@"ab"]);
//		assert([[Recursion noX:@"abc"] isEqual:@"abc"]);
//		assert([[Recursion noX:@"xx"] isEqual:@""]);
//		NSLog(@"Passed: countX");
		
//		assert([Recursion array6:(@[@1,@6,@4]) index:0]);
//		assert([Recursion array6:(@[@1,@4]) index:0] == false);
//		assert([Recursion array6:(@[@6]) index:0]);
//		NSLog(@"Passed: array6");
		
		assert([Recursion groupSum:0 nums:(@[@2, @4, @8]) target:10]);
		assert([Recursion groupSum:0 nums:(@[@2, @4, @8]) target:14]);
		assert([Recursion groupSum:0 nums:(@[@2, @4, @8]) target:9] == false);
		NSLog(@"Passed: groupSum");
	}
	return 0;
}
