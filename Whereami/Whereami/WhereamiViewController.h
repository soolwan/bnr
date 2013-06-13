//
//  WhereamiViewController.h
//  Whereami
//
//  Created by Sean Coleman on 6/11/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface WhereamiViewController : UIViewController <CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
}

@end
