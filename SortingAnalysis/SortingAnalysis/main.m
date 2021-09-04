//
//  main.m
//  SortingAnalysis
//
//  Created by Park Jong Won on 4/22/21.
//

#import <Foundation/Foundation.h>
#import "Timer.h"
#import "Stack.h"
#import "Array.h"

@interface SortAnalysis : NSObject

+ (int*) selection:(int*)arr;
+ (int*) quickSort:(int*)arr size:(int)n;
+ (int*) quickSortWrapper:(int*)arr low:(int)low high:(int)high;
+ (NSArray*) binarySearch:(int*)arr size:(int)n targetValue:(int)targetValue;
+ (void) arrayVersusStack;
+ (int*) appendToArrayOf:(int*)arr sizeOf:(int)size addingIndex:(int)i;

@end

@implementation SortAnalysis

//
// PASSED: Working
//
+ (void) selection:(int*)arr size:(int)n {
	for (int i = 0; i < n; i++) {
		int minIndex = i;
		// constrain j to i+1 (skipping i-th element)
		// and find min within the constrained array
		for (int j = i+1; j < n; j++) {
			if (arr[j] < arr[minIndex]) {
				minIndex = j;
			}
		}
		// swap the first element with min element found
		int minVal = arr[minIndex];
		arr[minIndex] = arr[i];
		arr[i] = minVal;
	}
}

//
// PASSED: Working
//
+ (int*) quickSort:(int*)arr size:(int)n {
	// illustration:
	// https://en.wikipedia.org/wiki/File:Quicksort-diagram.svg
	
	// special cases
	if (n < 2)
		return arr;
	
	// indice
	int lowIndex = 0;		// initial: first element
	int pivotIndex = n-1;	// initial: last element (initial high index)
	
	return [self quickSortWrapper:arr lowIndex:lowIndex highIndex:pivotIndex];
}

+ (int*) quickSortWrapper:(int*)arr lowIndex:(int)lowIndex highIndex:(int)highIndex {
	// if highIndex is lower than lowIndex, stop
	if (lowIndex < highIndex) {
		// START: Partition
		//
		int pivot = arr[highIndex]; // the new pivot (last element)
		int i = lowIndex - 1;
		
		// From [low] to [high-1] index (high itself is the pivot)
		// 		swap value if it's lower than pivot.
		// This sorts the given array (which is either a partitioned array before or after the pivot)
		for (int j = lowIndex; j <= highIndex-1; j++) {
			if (arr[j] < pivot) {
				i++;
				// swap
				int tmp = arr[j];
				arr[j] = arr[i];
				arr[i] = tmp;
			}
		}
		// array is sorted now
		
		// swap the pivot element with first element
		//	(as anything sorted to right is greater than pivot and anything to the left is less than pivot)
		int tmp = arr[i+1];
		arr[i+1] = arr[highIndex];
		arr[highIndex] = tmp;
		//
		// END: Partition
		
		int partitionIndex = i + 1;
		int beforePartition = partitionIndex - 1;
		int afterPartition = partitionIndex + 1;
		
		// sort elements two ways
		arr = [self quickSortWrapper:arr lowIndex:lowIndex highIndex:beforePartition]; // before the partition index
		arr = [self quickSortWrapper:arr lowIndex:afterPartition highIndex:highIndex]; // after the partition index
	}

	return arr;
}

//
// PASSED: Working
//
+ (NSArray*) binarySearch:(int*)arr size:(int)n targetValue:(int)targetValue {
	// illustration:
	// https://www.geeksforgeeks.org/wp-content/uploads/Binary-Search.png

	int left = 0;
	int right = n-1;
	int mid = 0;
	int ops = 3;
	
	while (left <= right) {
		mid = floor((left+right)/2); // middle element index
		ops += 2; // comparison, assignment
		if (arr[mid] < targetValue) {
			// shift left to half mid + 1
			left = mid + 1;
			ops += 2; // comparison, assignment
		} else if (arr[mid] > targetValue) {
			// shift right to half mid - 1
			right = mid - 1;
			ops += 2; // comparison, assignment
		} else
			return @[[NSNumber numberWithInt:mid], [NSNumber numberWithInt:ops]]; // arr[mid] is target
	}
	
	ops += 1;
	return @[@(-1), [NSNumber numberWithInt:ops]]; // unsuccessful
}

//
// PASSED: Working
//
+ (void) arrayVersusStack {
	int startSize = 500;
	int finalSize = 1000;
	
	startSize = 100;
	finalSize = 30000000;
	
	// Case array: 1429.905640 ms
	// Case stack: 14474.544922 ms
	
	Array* array = [[Array alloc] initWithSize:1];
	Stack* stack = [[Stack alloc] init];
	
	// Initialize array & stack
	for (int i = 0; i < startSize; i++) {
		[array append:i];
		[stack push:i];
	}
	
	Timer* timer = [[Timer alloc] init];
	
	// Append to array (resizing)
	[timer start];
	for (int i = startSize; i < finalSize; i++) {
		[array append:i];
	}
	[timer end];
	float elapsedArray = timer.elapsed;
	
	// Append to stack (linking)
	[timer start];
	for (int i = startSize; i < finalSize; i++) {
		[stack push:i];
	}
	[timer end];
	float elapsedStack = timer.elapsed;
	
//	for (int i = 0; i < finalSize; i++) {
//		printf("%d\n", array.array[i]);
//	}
	
	NSLog(@"Case array: %f ms", elapsedArray);
	NSLog(@"Case stack: %f ms", elapsedStack);
}

@end

int main(int argc, const char * argv[]) {
	@autoreleasepool {
		NSLog(@"Running app...");
		
		Timer* timer = [[Timer alloc] init];
		
		int testN = 100000;
//		int testN = 20;
		int* arrOrdered = malloc(testN*sizeof(int));
		int* arrReversed = malloc(testN*sizeof(int));
		int* arrRandom = malloc(testN*sizeof(int));
		
		for (int i = 0; i < testN; i++) {
			arrOrdered[i] = i; // in order
			arrReversed[i] = testN-i; // reversed
			arrRandom[i] = arc4random_uniform(testN*10); // random number, upper bound testN*10
		}
		
//		NSLog(@"Processing case ordered...");
//		[timer start];
//		[SortAnalysis selection:arrOrdered size:testN];
//		[timer end];
//		float elapsedOrdered = timer.elapsed;
		
//		NSLog(@"Processing case reversed...");
//		[timer start];
//		[SortAnalysis selection:arrReversed size:testN];
//		[timer end];
//		float elapsedReversed = timer.elapsed;
		
//		NSLog(@"Processing case random...");
//		[timer start];
//		[SortAnalysis selection:arrRandom size:testN];
//		[timer end];
//		float elapsedRandom = timer.elapsed;
		
//		NSLog(@"Case ordered: %f ms", elapsedOrdered);
//		NSLog(@"Case reversed: %f ms", elapsedReversed);
//		NSLog(@"Case random: %f ms", elapsedRandom);
		
//
//		NSLog(@"--------------------------");
//		for (int i = 0; i < testN; i++)
//			printf("%d\n", arrRandom[i]);
//
//		NSLog(@"Processing case random...");
//		[timer start];
//		int* sortedArr = [SortAnalysis quickSort:arrRandom size:testN];
////		int val = [SortAnalysis binarySearch:arrOrdered size:testN targetValue:15];
//		[timer end];
//		float elapsed = timer.elapsed;
//
//		NSLog(@"Case random: %f ms", elapsed);
//		for (int i = 0; i < testN; i++)
//			printf("%d\n", sortedArr[i]);
//		printf("Binary search: %d", val);
		
//		[SortAnalysis arrayVersusStack];
		

		NSMutableString *temp = [[NSMutableString alloc] init];
		printf("------ QuickSort iteration -------");
		int* testArray;
		int testSize = (int)pow(10,3);

		for (int i = 2; i < testSize; i++) {
			int tsize = i*(int)pow(10,6)*1.05;
			testArray = malloc(tsize * sizeof(int));

			for (int j = 0; j < i; j++) {
				testArray[j] = j; // random number, upper bound testN*10
				
			}
			
			[temp appendString:[NSString stringWithFormat:@"%i,",tsize]];
			
			[timer start];
//			[SortAnalysis quickSort:testArray size:i];
//			[SortAnalysis selection:testArray size:i];
			NSArray* tarr = [SortAnalysis binarySearch:testArray size:tsize targetValue:arc4random_uniform(tsize*10)];
			NSNumber* ops = tarr[1];
			[timer end];
			float elapsed = timer.elapsedNano;
			
			[temp appendString:[NSString stringWithFormat:@"%d \n", [ops intValue]]];
//			if (i % 100 == 0)
				NSLog(@"Iteration %i", i); // less logging means faster
		}
		
		NSString *str = [NSString stringWithString:temp];

		NSArray* paths = NSSearchPathForDirectoriesInDomains
		(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString* documentsDirectory = [paths objectAtIndex:0];
		//make a file name to write the data to using the documents directory:
		NSString* fileName = [NSString stringWithFormat:@"%@/Data-Structures-Class/SortingAnalysis/binary.txt", documentsDirectory];
		//save content to the documents directory
		[str writeToFile:fileName atomically:NO encoding:NSStringEncodingConversionAllowLossy error:nil];
		
	}
	return 0;
}
