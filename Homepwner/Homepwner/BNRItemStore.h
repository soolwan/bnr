//
//  BNRItemStore.h
//  Homepwner
//
//  Created by Sean Coleman on 6/28/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNRItem;  // Tell the compiler that there is a BNRItem class
                 // and that the current file doesn't need the class's details.

@interface BNRItemStore : NSObject
{
    NSMutableArray *allItems;
}

+ (BNRItemStore *)sharedStore;

- (NSArray *)allItems;
- (BNRItem *)createItem;
- (void)removeItem:(BNRItem *)p;
- (void)moveItemAtIndex:(int)from toIndex:(int)to;

@end
