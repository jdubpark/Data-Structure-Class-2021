//
//  date.m
//  DateCalculatorApp
//
//  Created by Park Jong Won on 3/30/21.
//

#import <Foundation/Foundation.h>
#import "date.h"

@implementation Date

static int daysInMonths[12] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

// [[Date alloc] initWithDate:YEAR :MONTH :DAY]
- (instancetype) initWithDate:(int)year :(int)month :(int)day {
	self = [super init];
	if (self) {
		self.year = year;
		self.month = month;
		self.day = day;
	}
	return [self isValid] ? self : nil;
}

// getters

- (int) imonth {
	// month for internal indexing since index 0: Jan & 11: Dec
	// example: array[imonth]
	return self.month-1;
}

// /getters

// required methods for HW

- (BOOL) isBefore:(Date*)date {
	if (self.year < date.year) return 1;
	else if (self.year > date.year) return 0;

	if (self.month < date.month) return 1;
	else if (self.month > date.month) return 0;

	if (self.day < date.day) return 1;
	return 0;
}

- (int) daysUntil:(Date*)date {
	// convert years and day to days
	int daysLeft = self.year * 365 + self.day;
	int daysRight = date.year * 365 + date.day;
//	NSLog(@"%i -- %i", daysLeft, daysRight);
	
	// cumulate days upto the given year's month (including all days of the given month)
	for (int i = 0; i < self.imonth; i++) daysLeft += daysInMonths[i];
	for (int i = 0; i < date.imonth; i++) daysRight += daysInMonths[i];
//	NSLog(@"%i -- %i", daysLeft, daysRight);
	
	// add leap years (one leap year = one extra day)
	daysLeft += [self countLeapYears];
	daysRight += [date countLeapYears];
//	NSLog(@"%i -- %i", daysLeft, daysRight);
	
	return daysRight - daysLeft;
}

- (Date*) nextWeek {
	int daysInCurMonth = daysInMonths[self.imonth];
	self.day += 7;
	
	if (self.day > daysInCurMonth) {
		// roll over to next month
		int rollover = self.day - daysInCurMonth;
		[self nextMonth];
		self.day = rollover;
	}
	
	return self;
}

- (NSString*) toString {
	char d = '/';
	return [NSString stringWithFormat:@"%i%c%i%c%i",self.year,d,self.month,d,self.day];
}

// other methods

- (BOOL) isAfter:(Date*)date {
	return ([self isBefore:date] || [self isEqual:date]) ? 0 : 1;
}

- (BOOL) isEqual:(Date*)date {
	return (self.year == date.year && self.month == date.month && self.day == date.day);
}

- (BOOL) isValid {
	// sorry, no BCE :/
	if (self.year < 0 || self.month < 1 || self.month > 12) return 0;
	if (self.day < 0 || self.day >= daysInMonths[self.imonth]) return 0;
	return 1;
}

- (BOOL) isLeapYear {
	// is leap if mutiple (400) or (4 and NOT 100)
	return (self.year % 400 == 0) || (self.year % 4 == 0 && self.year % 100 != 0);
}

- (int) countLeapYears {
	// is leap if mutiple (400) or (4 and NOT 100)
	int count = self.year/4 + self.year/400 - self.year/100;
	if ([self isLeapYear]) {
		// check if it should be counted (before Feb 29 or not)
		if (self.month == 1 || (self.month == 2 && self.day != 29)) count--;
	}
	return count;
}

- (Date*) nextMonth {
	self.month += 1;
	// index starts at 0 (so 11 is December)
	if (self.month > 11) self.month = 0;
	return self;
}

@end
