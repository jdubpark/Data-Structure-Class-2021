//
//  ViewController.h
//  DateCalculatorApp
//
//  Created by Park Jong Won on 3/30/21.
//

#import <Cocoa/Cocoa.h>
#import "date.h"

@interface ViewController : NSViewController

// (strong) to be used in all methods
@property int labelLastChanged;
@property (strong) Date *firstDate;
@property (strong) Date *secondDate;
@property (strong) NSDateFormatter *formatter;

//https://developer.apple.com/documentation/appkit/nstextfield?language=objc
@property (assign) IBOutlet NSTextField *firstDateLabel;
@property (assign) IBOutlet NSTextField *secondDateLabel;
@property (assign) IBOutlet NSTextField *isBeforeLabel;
@property (assign) IBOutlet NSTextField *diffDaysLabel;
//https://developer.apple.com/documentation/appkit/nsdatepicker?language=objc
@property (assign) IBOutlet NSDatePicker *datePicker;

- (IBAction) datePickerChanged:(id)sender;
- (IBAction) firstDateClicked:(id)sender;
- (IBAction) secondDateClicked:(id)sender;
- (BOOL) isFirst;
- (void) newDateSelected;
- (void) redoDateSelection;

@end
