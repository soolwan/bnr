//
//  BNRMapPoint.m
//  Whereami
//
//  Created by Sean Coleman on 6/13/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import "BNRMapPoint.h"

@implementation BNRMapPoint

- (id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t
{
    self = [super init];
    if (self) {
        _coordinate = c;
        _title = t;
    }

    return self;
}

- (id)init
{
    return [self initWithCoordinate:CLLocationCoordinate2DMake(43.07, -89.32) title:@"Hometown"];
}

@end
