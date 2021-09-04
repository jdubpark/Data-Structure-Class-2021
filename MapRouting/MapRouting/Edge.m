//
//  Edge.m
//  MapRouting
//
//  Created by Jongwon Park on 5/18/21.
//

#import <Foundation/Foundation.h>
#import "Edge.h"
#import "Vertex.h"

@implementation Edge

// edge is uni-direction

- (instancetype) initWithSource:(Vertex*)src andDest:(Vertex*)dest {
    if (self = [super init]) {
        self.src = src;
        self.dest = dest;
        self.distance = [self getDistance];
    }
    return self;
}

- (double) getDistance {
    // pythagorean theorem
    return sqrt(pow((self.src.x - self.dest.x),2) + pow((self.src.y - self.dest.y),2));
}

@end
