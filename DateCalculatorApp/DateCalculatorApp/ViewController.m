//
//  ViewController.m
//  DateCalculatorApp
//
//  Created by Park Jong Won on 3/30/21.
//

#import "ViewController.h"
#import "date.h"

@implementation ViewController

- (void) viewDidLoad {
	[super viewDidLoad];
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd"];
//	[formatter setDateStyle:NSDateFormatterShortStyle];
	
	// set to current date
	NSDate *curDate = [NSDate date];
	[self.datePicker setDateValue:curDate];
	
	self.labelLastChanged = 1; // 0 for FIRST, 1 for SECOND
	self.formatter = formatter;
	
	NSArray *labels = @[self.firstDateLabel, self.secondDateLabel, self.isBeforeLabel, self.diffDaysLabel];
	for (id labelElement in labels) {
		[labelElement setEditable:NO];
		[labelElement setSelectable:NO];
	}
	
//	[self.firstDateLabel setStringValue:@"(click to select)"];
//	[self.secondDateLabel setStringValue:@"(click to select)"];
	
	// add click gestures to NSTextField
	NSClickGestureRecognizer *click1 = [[NSClickGestureRecognizer alloc] initWithTarget:self action:@selector(firstDateClicked:)];
	[self.firstDateLabel addGestureRecognizer:click1];
	
	NSClickGestureRecognizer *click2 = [[NSClickGestureRecognizer alloc] initWithTarget:self action:@selector(secondDateClicked:)];
	[self.secondDateLabel addGestureRecognizer:click2];
}

- (void) awakeFromNib {
	// ensures that when date picker is clicked,
	// IBAction is called only once (otherwise called twice)
//	[self.datePicker sendActionOn: NSEventMaskLeftMouseDown]; // this doesn't work
	[self.datePicker sendActionOn:NSEventTypeLeftMouseDown]; // ignore warning
}

- (IBAction) datePickerChanged:(id)sender {
	NSString *selectedDate = [self.formatter stringFromDate:[sender dateValue]];
	NSArray *split = [selectedDate componentsSeparatedByString:@"-"];
	NSTextField *target = self.isFirst ? self.firstDateLabel : self.secondDateLabel;

	int year = [split[0] intValue];
	int month = [split[1] intValue];
	int day = [split[2] intValue];
	Date *date = [[Date alloc] initWithDate:year :month :day];
	
	if (self.isFirst) self.firstDate = date;
	else self.secondDate = date;
	
	[target setStringValue:[date toString]];
	[self newDateSelected];
	self.labelLastChanged = self.labelLastChanged ? 0 : 1;
}

- (IBAction) firstDateClicked:(id)sender {
//	NSLog(@"First Date Clicked!");
	self.labelLastChanged = 1;
	[self redoDateSelection];
}

- (IBAction) secondDateClicked:(id)sender {
//	NSLog(@"Second Date Clicked!");
	self.labelLastChanged = 0;
	[self redoDateSelection];
}

- (BOOL) isFirst {
	return self.labelLastChanged == 1;
}

- (void) newDateSelected {
	if (self.firstDate == nil || self.secondDate == nil) return;

	BOOL isBefore = [self.firstDate isBefore:self.secondDate];
	int diffDays = [self.firstDate daysUntil:self.secondDate];
//	NSString *diffDays = [[NSString alloc] initWithFormat:@"%i days", [self.firstDate daysUntil:self.secondDate]];
	
	
	[self.isBeforeLabel setStringValue:isBefore ? @"YES" : @"NO"];
	[self.diffDaysLabel setIntValue:diffDays];
}

- (void) redoDateSelection {
	if (self.isFirst) self.firstDate = nil;
	else self.secondDate = nil;
	NSTextField *targetLabel = self.isFirst ? self.firstDateLabel : self.secondDateLabel;
	
	[targetLabel setStringValue:@"(click to select)"];
	[self.isBeforeLabel setStringValue:@"(select both)"];
	[self.diffDaysLabel setStringValue:@"(select both)"];
}

@end
