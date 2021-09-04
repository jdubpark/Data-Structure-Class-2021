//
//  Timer.h
//  SortingAnalysis
//
//  Created by Park Jong Won on 4/26/21.
//

#import <Foundation/Foundation.h>

#ifndef Timer_h
#define Timer_h

@interface Timer : NSObject

@property float elapsed; // in miliseconds
@property float elapsedNano;
- (void) start;
- (void) end;

@end

#endif /* Timer_h */
