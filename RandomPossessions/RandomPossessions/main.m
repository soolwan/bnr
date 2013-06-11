//
//  main.m
//  RandomPossessions
//
//  Created by Sean Coleman on 6/3/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRItem.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // Create a mutable array object, store its address in items variable.
        NSMutableArray *items = [[NSMutableArray alloc] init];

        BNRItem *backpack = [[BNRItem alloc] init];
        [backpack setItemName:@"Backpack"];
        [items addObject:backpack];

        BNRItem *calculator = [[BNRItem alloc] init];
        [calculator setItemName:@"Calculator"];
        [items addObject:calculator];

        [backpack setContainedItem:calculator];

        for (BNRItem *item in items) {
            NSLog(@"%@", item);
        }

        // Destroy the array pointed to by items.
        NSLog(@"Setting items to nil...");
        items = nil;
    }
    return 0;
}

