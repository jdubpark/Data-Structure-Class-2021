//
//  HashTable.m
//  HashTables
//
//  Created by Jongwon Park on 5/13/21.
//

#import <Foundation/Foundation.h>
#import "HashTable.h"

@implementation HashTable

- (instancetype) initWithHashFunction:(NSString*)hashFnName {
    if (self = [super init]) {
        self.hashFnName = hashFnName;
        // initialize mutable array of keys
        self.keys = [[NSMutableArray alloc] init];
        unsigned long arrSize = 2000;
        for (int i = 0; i < arrSize; i++) {
            self.keys[i] = @"";
        }
    }
    return self;
}

// MARK: Hash Table

- (NSArray*) addKey:(NSString*)key {
    // returns ["added/exists", added/found index, # of collision]
    unsigned long hashIndex = [self hashFunction:key];

    //
    // linear probing
    //
    NSString* currentKey = self.keys[hashIndex];
    unsigned long pseudoIndex = hashIndex; // hashIndex + collision
    unsigned long arraySize = [self.keys count];
    int ops = 0;
    
    NSLog(@"Key: %@ // hash: %lu // empty? %@", key, hashIndex, [currentKey isEqualTo:@""]?@"YES":@"NO");
    
    if ([currentKey isEqualTo:key]) {
        // hash index already has that key
        return @[@"exists", [NSNumber numberWithUnsignedLong:hashIndex], @0];
    }

    if ([currentKey isEqualTo:@""]) {
        // empty key, add to it! (no collision)
        self.keys[hashIndex] = key;
        return @[@"added", [NSNumber numberWithUnsignedLong:hashIndex], @0];
    }
    
    // go down the array of keys to find the next empty key
    // while: current key is NOT empty OR is filled with different key
    while ([currentKey isNotEqualTo:@""] && [currentKey isNotEqualTo:key]) {
        pseudoIndex += 1;
        ops += 1;
        
        if (pseudoIndex > arraySize)
            pseudoIndex = 0; // back to 0 if out-of-bound
        
        currentKey = self.keys[pseudoIndex];
        
        if ([currentKey isEqualTo:@""]) {
            // found empty key! (after N collisions)
            unsigned long collisions = pseudoIndex - hashIndex;
            self.keys[pseudoIndex] = key;
            NSLog(@"Add LP 1 :: Key: %@ // pseudo: %lu // collisions %lu", key, pseudoIndex, collisions);
            return @[@"added", [NSNumber numberWithUnsignedLong:pseudoIndex], [NSNumber numberWithUnsignedLong:collisions]];
        }
        
        if ([currentKey isEqualTo:key]) {
            unsigned long collisions = pseudoIndex - hashIndex;
            NSLog(@"Add LP 2 :: Key: %@ // pseudo: %lu // collisions %lu", key, pseudoIndex, collisions);
            return @[@"exists", [NSNumber numberWithUnsignedLong:pseudoIndex], [NSNumber numberWithUnsignedLong:collisions]];
        }
        
        if (ops > arraySize)
            // full cycle, break for statement below the while llop
            break;
    }
    
    // full cycle, add at last (a new array space); in thise case, ops is # of collision
    [self.keys addObject:key];
    pseudoIndex = arraySize; // index starts at 0, so no need for +1
    NSLog(@"Add LP 3 :: Key: %@ // pseudo: %lu // collisions %i", key, pseudoIndex, ops);
    return @[@"added", [NSNumber numberWithUnsignedLong:pseudoIndex], [NSNumber numberWithUnsignedLong:ops]];
}

- (NSArray*) findKey:(NSString*)key {
    // returns ["found/not-found", index (if found), # of collision (if found)]
    // ** same return as [self linearProbingForKey]
    unsigned long hashIndex = [self hashFunction:key];
    
    //
    // linear probing
    //
    NSString* currentKey = self.keys[hashIndex];
    unsigned long pseudoIndex = hashIndex; // hashIndex + collision
    unsigned long arraySize = [self.keys count];
    int ops = 0;

    if ([currentKey isEqualTo:key]) {
        NSLog(@"Find :: Key: %@ // hash: %lu // collisions %i", key, hashIndex, ops);
        return @[@"found", [NSNumber numberWithUnsignedLong:hashIndex], @0];
    }
    
    // go down the array of keys as long as the next key is NOT empty OR has value NOT equal to the desired key
    while ([currentKey isNotEqualTo:@""] || [currentKey isNotEqualTo:key]) {
        pseudoIndex += 1;
        ops += 1;
        
        if (pseudoIndex > arraySize)
            pseudoIndex = 0; // back to 0 if out-of-bound
        
        currentKey = self.keys[pseudoIndex];
        
        if ([currentKey isEqualTo:key]) {
            unsigned long collisions = pseudoIndex - hashIndex;
            return @[@"found", [NSNumber numberWithUnsignedLong:pseudoIndex], [NSNumber numberWithUnsignedLong:collisions]];
        }
        
        if ([currentKey isEqualTo:@""] || ops > arraySize)
            // former: empty key found (linear probing ends)
            // latter: full cycle (not found)
            return @[@"not-found", @-1, @0];
    }
    
    unsigned long collisions = pseudoIndex - hashIndex;
    return @[@"found", [NSNumber numberWithUnsignedLong:pseudoIndex], [NSNumber numberWithUnsignedLong:collisions]];
}

// MARK: Hash Functions

- (unsigned long) hashFunction:(NSString*)key {
    // uses internal hash function based on "hashFnName"
    if ([self.hashFnName isEqualTo:@"djb2"])
        return [self djb2Modified:key];
    
    return [self simpleASCII:key]; // catch all
}

- (unsigned long) simpleASCII:(NSString*)key {
    // just adds ASCII of all characters in the given string
    unsigned long hash = 0;
    for (int i = 0; i < [key length]; i++) {
        hash += [self getASCIIOfString:key atIndex:i];
    }
    return hash;
}

- (unsigned long) djb2Modified:(NSString*)key {
    // http://www.cse.yorku.ca/~oz/hash.html
    // original: multiply hash by 33, then add ASCII of a character; repeat for whole string
    // modification: by 2
    unsigned long hash = 5381; // lu: unsigned lon
    int ch;
    
    for (int i = 0; i < [key length]; i++) {
        ch = [self getASCIIOfString:key atIndex:i];
//        hash = ((hash << 5) + hash) + ch; // hash * 33 + c
        hash = ((hash << 1) + hash) + ch; // hash
    }
    
    return hash;
}

// MARK: Trivial Tools

- (int) getASCIIOfString:(NSString*)string atIndex:(int)i {
    NSString *ch_ = [NSString stringWithFormat:@"%c", [string characterAtIndex:i]];
    const char *ch = [ch_ UTF8String];
    return *ch;
}

- (void) readFromFile:(NSString*)userFilePath {
    NSError *error;
    NSBundle *myBundle = [NSBundle mainBundle];
    NSString *filePath = [myBundle pathForResource:userFilePath ofType:@"txt"];
    NSString *fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];

    // throw error if no file is found
    if (error) {
        NSLog(@"Error reading file: %@", error.localizedDescription);
        return;
    }

    // read file into lines
    NSArray *listArray = [fileContents componentsSeparatedByString:@"\n"];
    NSArray *lines = [listArray mutableCopy];
    
    for (int i = 0; i < [lines count]; i++) {
        [self addKey:lines[i]];
    }
}

@end
