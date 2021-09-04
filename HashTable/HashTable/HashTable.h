//
//  HashTable.h
//  HashTables
//
//  Created by Jongwon Park on 5/13/21.
//

#ifndef HashTable_h
#define HashTable_h

@interface HashTable : NSObject

@property NSMutableArray* keys;
@property NSString* hashFnName;

- (instancetype) initWithHashFunction:(NSString*)hashFnName;
- (void) readFromFile:(NSString*)userFilePath;

- (NSArray*) addKey:(NSString*)key;
- (NSArray*) findKey:(NSString*)key;

@end

#endif /* HashTable_h */
