//
//  WhereamiViewController.m
//  Whereami
//
//  Created by Sean Coleman on 6/11/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import "WhereamiViewController.h"

@interface WhereamiViewController ()

@end

@implementation WhereamiViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {
        // Create location manager object.
        locationManager = [[CLLocationManager alloc] init];

        [locationManager setDelegate:self];

        // And we want it to be as accurate as possible
        // regardless of how much time/power it takes.
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];

        // Tell our manager to start looking for its location immediately.
        [locationManager startUpdatingLocation];
    }

    return self;
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"%@", newLocation);
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"Could not find location: %@", error);
}

- (void)dealloc
{
    // Tell the location manager to stop sending us messages.
    // Delegates are not weak, they are __unsafe_unretained.
    [locationManager setDelegate:nil];
}

@end
