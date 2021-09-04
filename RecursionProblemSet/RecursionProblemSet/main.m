//
//  main.m
//  RecursionProblemSet
//
//  Created by Park Jong Won on 4/1/21.
//

#import <Foundation/Foundation.h>

@interface Recursion: NSObject

@end

@implementation Recursion

+ (int) sumOfDigits:(int)n {
	if (n/10 == 0) {
		return n%10;
	} else {
		return n%10 + [self sumOfDigits:(n/10)];
	}
}

+ (double) weightOnBackOf:(int)row :(int)col :(NSMutableDictionary*)table {
	// bottom-up approach
	//
	NSString *tableKey = [NSString stringWithFormat:@"%i_%i",row,col];
	if (row <= 1 || col < 0 || col > row) {
		// first two rows can be calculated as row * 100
		if (row <= 1 && !(col < 0 || col > row))
			return row * 100.0;
		// -200 for column out of range (-1 or > # of row)
		// -200 / 2 + 100 = 0 (when called)
		return -200;
	} else if ([table objectForKey:tableKey] != nil) {
		// memoization (for efficient reversed breadth-first search):
		return [[table objectForKey:tableKey] doubleValue];
	} else {
		// step case:
		double topLeftWeight = 100 + [self weightOnBackOf:(row-1) :(col-1) :table] / 2;
		double topAboveWeight = 100 + [self weightOnBackOf:(row-1) :(col) :table] / 2;
		double weightOnBack = topLeftWeight + topAboveWeight;

		// save to table
		[table setObject:[NSNumber numberWithInt:weightOnBack] forKey:tableKey];

		return weightOnBack;
	}
}

+ (double) weightOnBackOfRow:(int)row col:(int)col table:(NSMutableDictionary*)table {
	return [self weightOnBackOf:row :col :table];
}

+ (int) countCriticalVotes:(NSArray*)blocks_ blockIndex:(int)blockIndex {
	__block int criticalVotes = 0;
	int lastVote = [blocks_[blockIndex] intValue];

	NSMutableArray *blocks = [blocks_ mutableCopy];
	[blocks removeObjectsInRange:(NSRange){blockIndex, 1}]; // remove lastVote block from blocks


	void (^__block wrapper)(NSArray*, int, int) = ^(NSArray *blocks, int index, int votes) {
		if (index >= [blocks count]) {
			bool flipToA = votes <= 0 && votes + lastVote > 0; // was negative, now positive (win for entity A)
			bool flipToB = votes > 0 && votes - lastVote < 0; // was positive, now negative (win for entity B)
			if (flipToA || flipToB) {
				criticalVotes += 1;
			}
		} else {
			int blockVote = [blocks[index] intValue];
			wrapper(blocks, index+1, votes+blockVote); // case1: entity A gets the vote (add)
			wrapper(blocks, index+1, votes-blockVote); // case2: entity A doesn't get the vote (subtract)
		}
	};
	
	wrapper(blocks, 0, 0); // call the wrapper
	return criticalVotes;
}

+ (NSString*) pickcoin:(int)coins player1:(NSString*)p1 player2:(NSString*)p2 {
	// 1, 2, 4 and not 3 --> factor of 1, 2, 4 but not 3
	// when game starts:
	//	- if coins is factor of 3 (coins % 3 == 0), then first player already loses
	//	- else (not factor of 3), first player already wins
	NSString *winner = coins % 3 == 0 ? p2 : p1; // % 3 ? p2 : p1
	
	__block int count = 0;

	void (^__block wrapper)(int) = ^(int coins) {
		// for every loop, player plays optimally, i.e. take # of coins such that
		// the remaining amount is a factor of 3 (remainder % 3 == 0), which the other player has to play on

		if (coins <= 4) {
			if (coins < 0) {
				return;
			} else if (coins == 1 || coins == 2){
				// win right away
				count += 1;
			} else if (coins == 3) {
				// 3 coins left, take 1 or 2
				wrapper(coins-1);
				wrapper(coins-2);
			} else if (coins == 4) {
				// can win right away by picking 4
				count += 1;
				// or pick 1 (remainder 3) and win on the next pick
				wrapper(coins-1);
			}
		} else {
			// optimal play, e.g.
			// A take 1 -> B take 2 (-3)
			// A take 2 -> B take 1 or 4 (= -3 or -6)
			// A take 4 -> B take 2 (= -6)
			if (coins % 3 == 1) {
				wrapper(coins-1);
				wrapper(coins-4); // -1 and -3
			} else if (coins % 3 == 2) {
				wrapper(coins-2);
			} else {
				// coins % 3 == 0
				// whoever is playing now is losing, so just take all cases (b/c outcome doesn't matter anyways)
				wrapper(coins-1);
				wrapper(coins-2);
				wrapper(coins-4);
			}
		}
	};

	wrapper(coins);
	NSLog(@"%@ %i", winner, count);
	return [NSString stringWithFormat:@"%@ %i", winner, count];
}

@end

int main(int argc, const char * argv[]) {
	@autoreleasepool {
	    // insert code here...
	    NSLog(@"Running app...");
		
		//
		//	Recursion: sumOfDigits
		//
//		assert([Recursion sumOfDigits:2345] == 14);
//		NSLog(@"Passed: sumOfDigits");
		
		//
		//	Recursion: weightOnBackOfRow
		//
//		NSMutableDictionary *weightTable = [[NSMutableDictionary alloc] init];
//		assert([Recursion weightOnBackOfRow:0 col:0 table:weightTable] == 0);
//		assert([Recursion weightOnBackOfRow:1 col:0 table:weightTable] == 100);
//		assert([Recursion weightOnBackOfRow:1 col:1 table:weightTable] == 100);
//		assert([Recursion weightOnBackOfRow:2 col:0 table:weightTable] == 150);
//		assert([Recursion weightOnBackOfRow:2 col:1 table:weightTable] == 300);
//		assert([Recursion weightOnBackOfRow:2 col:2 table:weightTable] == 150);
//		assert([Recursion weightOnBackOfRow:4 col:2 table:weightTable] == 625);
//		NSLog(@"%f", [Recursion weightOnBackOfRow:30 col:15 table:weightTable]);
//		NSLog(@"Passed: weightOnBackOf");
		
		//
		//	Recursion: countCriticalVotes
		//
//		assert([Recursion countCriticalVotes:(@[@4,@2,@7,@4]) blockIndex:0] == 2);
//		assert([Recursion countCriticalVotes:(@[@4,@2,@7,@4]) blockIndex:1] == 2);
//		assert([Recursion countCriticalVotes:(@[@4,@2,@7,@4]) blockIndex:2] == 6);
//		assert([Recursion countCriticalVotes:(@[@4,@2,@7,@4]) blockIndex:3] == 2);
//		assert([Recursion countCriticalVotes:(@[@9,@9,@7,@3,@1,@1]) blockIndex:3] == 0);
//		assert([Recursion countCriticalVotes:(@[@9,@9,@7,@3,@1,@1]) blockIndex:4] == 0);
//		assert([Recursion countCriticalVotes:(@[@9,@9,@7,@3,@1,@1]) blockIndex:5] == 0);
//		NSLog(@"Passed: countCriticalVotes");
		
		//
		//	Recursion: pickcoin (usable via command line)
		//
//		char cstring[100+1]; // +1 for terminating null byte
//		NSLog(@"pickcoin: ");
//		scanf("%[^\n]", cstring); // get full string with whitespace (considered \n by scanf)
//		NSString *text = [NSString stringWithCString:cstring encoding:1];
//		// split by whitespace
//		NSArray *split = [text componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//
//		// retrieve values from split
//		int coins = [split[0] intValue];
//		NSString *player1 = split[1];
//		NSString *player2 = split[2];
//		NSString *test = [Recursion pickcoin:coins player1:player1 player2:player2];
//
//		assert([[Recursion pickcoin:1 player1:@"alice" player2:@"bob"] isEqual:@"alice 1"]);
//		assert([[Recursion pickcoin:2 player1:@"bob" player2:@"alice"] isEqual:@"bob 1"]);
//		assert([[Recursion pickcoin:3 player1:@"alice" player2:@"bob"] isEqual:@"bob 2"]);
//		assert([[Recursion pickcoin:10 player1:@"alice" player2:@"bob"] isEqual:@"alice 22"]);
//		assert([[Recursion pickcoin:25 player1:@"alice" player2:@"bob"] isEqual:@"alice 3344"]);
//		assert([[Recursion pickcoin:30 player1:@"alice" player2:@"bob"] isEqual:@"bob 18272"]);
//		NSLog(@"Passed: pickcoin");
	}
	return 0;
}
