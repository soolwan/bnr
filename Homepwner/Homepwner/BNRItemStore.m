//
//  BNRItemStore.m
//  Homepwner
//
//  Created by Sean Coleman on 6/28/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"

@implementation BNRItemStore

// Alloc calls allocWithZone. Override allocWithZone to prevent instances
// of BNRItemStore from being created, enforcing its singleton status.
+ (id)allocWithZone:(NSZone *)zone
{
    // sharedStore ends up calling NSObject's allocWithZone.
    return [self sharedStore];
}

+ (BNRItemStore *)sharedStore
{
    // Static variables live on the stack and are not destroyed
    // when the method returns.
    static BNRItemStore *sharedStore = nil;
    if (!sharedStore) {
        // Call allocWithZone via super here to avoid getting
        // stuck in a loop.
        sharedStore = [[super allocWithZone:nil] init];
    }

    return sharedStore;
}

// We need to create the allItems array.
- (id)init
{
    self = [super init];
    if (self) {
        allItems = [[NSMutableArray alloc] init];
    }

    return self;
}

- (NSArray *)allItems
{
    return allItems;
}

- (BNRItem *)createItem
{
    BNRItem *p = [BNRItem randomItem];

    [allItems addObject:p];

    return p;
}

- (void)removeItem:(BNRItem *)p
{
    [allItems removeObjectIdenticalTo:p];
}

- (void)moveItemAtIndex:(int)from toIndex:(int)to
{
    if (from == to) {
        return;
    }

    // Get a pointer to the object being moved so we can re-insert it.
    BNRItem *p = [allItems objectAtIndex:from];

    // Remove p from array.
    [allItems removeObjectAtIndex:from];

    // Insert p in array at new location.
    [allItems insertObject:p atIndex:to];
}

@end
