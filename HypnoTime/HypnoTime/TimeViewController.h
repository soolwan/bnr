//
//  TimeViewController.h
//  HypnoTime
//
//  Created by Sean Coleman on 6/17/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeViewController : UIViewController
{
    // Let the view keep the only strong reference.
    __weak IBOutlet UILabel *timeLabel;
}

- (IBAction)showCurrentTime:(id)sender;

@end
