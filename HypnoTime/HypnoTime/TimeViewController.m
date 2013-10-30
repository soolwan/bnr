//
//  TimeViewController.m
//  HypnoTime
//
//  Created by Sean Coleman on 6/17/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

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

//    [self spinTimeLabel];
    [self bounceTimeLabel];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"%@ finished: %d", anim, flag);
}

- (void)spinTimeLabel
{
    // Create a basic animation.
    CABasicAnimation *spin = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    [spin setDelegate:self];

    // fromValue is implied.
    [spin setToValue:[NSNumber numberWithFloat:M_PI * 2.0]];  // 2 * M_PI is 360 degrees.
    [spin setDuration:1.0];

    CAMediaTimingFunction *tf = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    [spin setTimingFunction:tf];

    [[timeLabel layer] addAnimation:spin forKey:@"spinAnimation"];
}

- (void)bounceTimeLabel
{
    // Create a key frame animation
    CAKeyframeAnimation *bounce = [CAKeyframeAnimation animationWithKeyPath:@"transform"];

    // Create the values it will pass through.
    CATransform3D forward = CATransform3DMakeScale(1.3, 1.3, 1);
    CATransform3D back = CATransform3DMakeScale(0.7, 0.7, 1);
    CATransform3D forward2 = CATransform3DMakeScale(1.2, 1.2, 1);
    CATransform3D back2 = CATransform3DMakeScale(0.9, 0.9, 1);

    [bounce setValues:@[[NSValue valueWithCATransform3D:CATransform3DIdentity],
                        [NSValue valueWithCATransform3D:forward],
                        [NSValue valueWithCATransform3D:back],
                        [NSValue valueWithCATransform3D:forward2],
                        [NSValue valueWithCATransform3D:back2],
                        [NSValue valueWithCATransform3D:CATransform3DIdentity]]];

     // Set the duration.
    [bounce setDuration:0.6];

    // Animate the layer.
    [[timeLabel layer] addAnimation:bounce forKey:@"bounceAnimation"];
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

@end
