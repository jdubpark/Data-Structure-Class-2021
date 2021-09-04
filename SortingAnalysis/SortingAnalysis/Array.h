//
//  Array.h
//  SortingAnalysis
//
//  Created by Park Jong Won on 4/27/21.
//

#ifndef Array_h
#define Array_h

@interface Array : NSObject

@property int* array;
@property int size;
@property int index;

- (instancetype) initWithSize:(int)size;
- (void) resize; // resize by reallocating the array with double its size
- (void) append:(int)val;
- (void) dealloc;

@end

#endif /* Array_h */
