//
//  TouchViewController.m
//  TouchTracker
//
//  Created by Sean Coleman on 10/17/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import "TouchViewController.h"
#import "TouchDrawView.h"

@implementation TouchViewController

- (void)loadView
{
    [self setView:[[TouchDrawView alloc] initWithFrame:CGRectZero]];
}

@end
