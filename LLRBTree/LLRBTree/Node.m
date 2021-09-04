//
//  Node.m
//  LLRBTree
//
//  Created by Jongwon Park on 5/10/21.
//

#import <Foundation/Foundation.h>
#import "Node.h"

@implementation Node

- (instancetype) initWithKey:(int)key {
    self = [super init];
    if (self) {
        self.isRed = true;
        self.key = key;
    }
    return self;
}

@end
