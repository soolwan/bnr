//
//  HypnosisterAppDelegate.m
//  Hypnosister
//
//  Created by Sean Coleman on 6/13/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import "HypnosisterAppDelegate.h"

@implementation HypnosisterAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    // Override point for customization after application launch.

    // Fade out the status bar.
    [[UIApplication sharedApplication] setStatusBarHidden:YES
                                            withAnimation:UIStatusBarAnimationFade];

    CGRect screenRect = [[self window] bounds];

    // Create the UIScrollView to have the size of the window, matching its size.
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:screenRect];
    //[scrollView setPagingEnabled:YES];

    // Zooming.
    [scrollView setMaximumZoomScale:1.0];
    [scrollView setMaximumZoomScale:5.0];

    [scrollView setDelegate:self];

    [[self window] addSubview:scrollView];

    //CGRect viewFrame = CGRectMake(160, 240, 100, 150);
    //HypnosisView *view = [[HypnosisView alloc] initWithFrame:viewFrame];
    //HypnosisView *view = [[HypnosisView alloc] initWithFrame:[[self window] bounds]];
    //[view setBackgroundColor:[UIColor redColor]];
    //[self.window addSubview:view];

    // Create the HypnosisView with a frame that is twice the size of the screen.
    CGRect bigRect = screenRect;
    //bigRect.size.width *= 2.0;
    //bigRect.size.height *= 2.0;
    //HypnosisView *view = [[HypnosisView alloc] initWithFrame:bigRect];
    view = [[HypnosisView alloc] initWithFrame:screenRect];

    // Add the HypnosisView as a subview of the scrollView instead of the window.
    [scrollView addSubview:view];

    // Move the rectangle for the other HypnosisView to the right, just off the screen.
    //screenRect.origin.x = screenRect.size.width;
    //HypnosisView *anotherView = [[HypnosisView alloc] initWithFrame:screenRect];
    //[scrollView addSubview:anotherView];

    // Tell the scrollView how big its virtual world is.
    [scrollView setContentSize:bigRect.size];

    // The view needs to become first responder to respond to shake events.
    BOOL success = [view becomeFirstResponder];
    if (success) {
        NSLog(@"HypnosisView became the first responder.");
    } else {
        NSLog(@"Could not become first responder.");
    }

    //CGRect anotherFrame = CGRectMake(20, 30, 50, 50);
    //HypnosisView *anotherView = [[HypnosisView alloc] initWithFrame:anotherFrame];
    //[anotherView setBackgroundColor:[UIColor blueColor]];
    //[view addSubview:anotherView];

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return view;
}

@end
