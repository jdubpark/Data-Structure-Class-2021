//
//  stack.m
//  StacksAndQueue
//

#import <Foundation/Foundation.h>
#import "Stack.h"
#import "Item.h"

@implementation Stack // LIFO (Last In, First Out --> Item is added as first and taken out first)

- (id) init {
	self = [super init];
	return self;
}

- (bool) isEmpty {
	return self.top == nil;
}

- (int) size {
	int count = 0;
	Item *tmp = self.top;
	while (tmp.next != nil) {
		tmp = tmp.next;
		count++;
	}
	return count;
}

- (void) push:(id)object {
	Item *item = [[Item alloc] initWithObject:object];
	Item *tmp = self.top;
	self.top = item;
	self.top.next = tmp;
}

- (Item*) pop {
	Item *tmp = self.top;
	self.top = self.top.next;
	return tmp;
}

- (void) print {
	Item *tmp = self.top;
	NSLog(@"%@",tmp.object);
	while (tmp.next != nil) {
		tmp = tmp.next;
		NSLog(@"%@",tmp.object);
	}
}

// - Push operands onto the operand stack.
// - Push operators onto the operator stack.
// - Ignore left parentheses.
// - On encountering a right parenthesis, pop an operator, pop the requisite number of operands, and push onto the operand stack the result of applying that operator to those operands.
// - After the final right parenthesis has been processed, there is one value on the stack, which is the value of the expression.  - from https://algs4.cs.princeton.edu/13stacks/

+ (int) TwoStack:(NSString*)expression {
	Stack *operands = [[Stack alloc] init];
	Stack *operators = [[Stack alloc] init];
	
	bool wasPreviousAnOperand = NO;
	for (int i = 0; i < [expression length]; i++) {
		// loop through each character of epxression
		
		NSString *character = [expression substringWithRange:NSMakeRange(i, 1)];
		
		// will change to YES later if number is multi-digit
		wasPreviousAnOperand = NO;
		
		if ([character isEqual:@" "] || [character isEqual:@"("]) {
			// ignore blank space OR left parenthesis
			continue;
		} else if ([character isEqual:@")"]) {
			// right parenthesis -> calculate
			// pop an operator, pop the requisite number of operands (two)

			int lastNumber = [[operands pop].object intValue];
			int secondLastNumber = [[operands pop].object intValue];
			int calculation = 0;
			NSString *operator = [operators pop].object;
			
			if ([operator isEqual:@"+"]) {
				calculation = secondLastNumber + lastNumber;
			} else if ([operator isEqual:@"-"]) {
				calculation = secondLastNumber - lastNumber;
			} else if ([operator isEqual:@"*"]) {
				calculation = secondLastNumber * lastNumber;
			} else if ([operator isEqual:@"/"]) {
				calculation = secondLastNumber / lastNumber;
			} else if ([operator isEqual:@"%"]) {
				calculation = secondLastNumber % lastNumber;
			}
			
			[operands push:[NSNumber numberWithInt:calculation]];
		} else {
			if ([character isEqual:@"+"] || [character isEqual:@"-"] || [character isEqual:@"/"]
				|| [character isEqual:@"*"] || [character isEqual:@"%"]) {
				// is operator
				[operators push:character];
			} else {
				// is operand
				if (wasPreviousAnOperand == YES) {
					// multi-digit number: append to stack's head
					
					// double digit number
					// method 1: this works
					NSString *prev = operands.top.object;
					operands.top.object = [NSString stringWithFormat:@"%@%@", prev, character]; // append character

					// method 2: this works as well
					// int prev = [operands.top.object intValue];
					// int intChar = [character intValue];
					// operands.top.object = [@(prev * 10 + intChar) stringValue];
				} else {
					// single-digit number
					[operands push:character];
					wasPreviousAnOperand = YES;
				}
			}
		}
	}

	return [[operands pop].object intValue];
}

@end

