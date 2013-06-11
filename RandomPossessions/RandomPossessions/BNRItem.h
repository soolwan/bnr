//
//  BNRItem.h
//  RandomPossessions
//
//  Created by Sean Coleman on 6/3/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject

+ (id)randomItem;

// Designated initializer
- (id)initWithItemName:(NSString *)name
        valueInDollars:(int)value
          serialNumber:(NSString *)sNumber;

- (id)initWithItemName:(NSString *)name
          serialNumber:(NSString *)sNumber;

@property (nonatomic) BNRItem *containedItem;
@property (nonatomic, weak) BNRItem *container;

@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
@property (nonatomic, readonly) NSDate *dateCreated;

@end
