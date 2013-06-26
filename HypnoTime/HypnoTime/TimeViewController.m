//
//  TimeViewController.m
//  HypnoTime
//
//  Created by Sean Coleman on 6/17/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import "TimeViewController.h"

@implementation TimeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {
        // Get the tab bar item.
        UITabBarItem *tbi = [self tabBarItem];

        // Give it a label.
        [tbi setTitle:@"Time"];

        // Create a UIImage from a file, uses @2x on retina.
        UIImage *i = [UIImage imageNamed:@"Time.png"];

        // Put that image on the tab bar item.
        [tbi setImage:i];
    }

    return self;
}

- (IBAction)showCurrentTime:(id)sender
{
    NSDate *now = [NSDate date];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];

    [timeLabel setText:[formatter stringFromDate:now]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"TimeViewController loaded its view.");

    [[self view] setBackgroundColor:[UIColor greenColor]];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"TimeViewController will appear.");
    [super viewWillAppear:animated];
    [self showCurrentTime:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"TimeViewController will disappear.");
    [super viewWillDisappear:animated];
}

// Not in iOS 6.
//- (void)viewDidUnload
//{
//    [super viewDidUnload];
//    timeLabel = nil;
//}

@end
