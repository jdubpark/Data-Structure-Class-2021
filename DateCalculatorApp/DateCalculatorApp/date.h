//
//  date.h
//  DateCalculator
//
//  Created by Park Jong Won on 3/30/21.
//

#import <Foundation/Foundation.h>

#ifndef date_h
#define date_h

@interface Date : NSObject

@property (nonatomic) int year;
@property (nonatomic) int month;
@property (nonatomic) int day;

//+ (int*) daysInMonths;
- (id) initWithDate:(int) year :(int) month :(int) day;
- (BOOL) isBefore:(Date*) date;
- (int) daysUntil:(Date*) date;
- (Date*) nextWeek;
- (Date*) nextMonth;
- (NSString*) toString;

@end

#endif /* date_h */
