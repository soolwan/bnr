//
//  TouchDrawView.h
//  TouchTracker
//
//  Created by Sean Coleman on 10/17/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TouchDrawView : UIView {
    NSMutableDictionary *linesInProcess;
    NSMutableArray *completeLines;
}

- (void)clearAll;

@end
