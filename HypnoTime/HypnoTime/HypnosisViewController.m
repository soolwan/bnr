//
//  HypnosisViewController.m
//  HypnoTime
//
//  Created by Sean Coleman on 6/14/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import "HypnosisViewController.h"
#import "HypnosisView.h"

@implementation HypnosisViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {
        // Get the tab bar item.
        UITabBarItem *tbi = [self tabBarItem];

        // Give it a label.
        [tbi setTitle:@"Hypnosis"];

        // Create a UIImage from a file, uses @2x on retina.
        UIImage *i = [UIImage imageNamed:@"Hypno.png"];

        // Put that image on the tab bar item.
        [tbi setImage:i];
    }

    return self;
}

- (void)loadView
{
    // Create a view.
    CGRect frame = [[UIScreen mainScreen] bounds];
    HypnosisView *v = [[HypnosisView alloc] initWithFrame:frame];

    // Set it as *the* view of this view controller.
    [self setView:v];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"HypnosisViewController loaded its view.");
}

@end
