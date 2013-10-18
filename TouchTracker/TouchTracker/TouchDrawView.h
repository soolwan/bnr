//
//  TouchDrawView.h
//  TouchTracker
//
//  Created by Sean Coleman on 10/17/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Line;

@interface TouchDrawView : UIView {
    NSMutableDictionary *linesInProcess;
    NSMutableArray *completeLines;
}

@property (nonatomic, weak) Line *selectedLine;

- (Line *)lineAtPoint:(CGPoint)p;

- (void)clearAll;

@end
