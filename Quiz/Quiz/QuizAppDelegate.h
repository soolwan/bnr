//
//  QuizAppDelegate.h
//  Quiz
//
//  Created by Sean Coleman on 6/3/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QuizViewController;

@interface QuizAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) QuizViewController *viewController;

@end
