//
//  TouchDrawView.m
//  TouchTracker
//
//  Created by Sean Coleman on 10/17/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import "TouchDrawView.h"
#import "Line.h"

@implementation TouchDrawView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
        linesInProcess = [[NSMutableDictionary alloc] init];

        completeLines = [[NSMutableArray alloc] init];

        [self setBackgroundColor:[UIColor whiteColor]];
        [self setMultipleTouchEnabled:YES];

        UITapGestureRecognizer *tapRecognizer =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tapRecognizer];

        UILongPressGestureRecognizer *pressRecognizer =
        [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:pressRecognizer];

        moveRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                 action:@selector(moveLine:)];
        [moveRecognizer setDelegate:self];
        [moveRecognizer setCancelsTouchesInView:NO];
        [self addGestureRecognizer:moveRecognizer];
    }

    return self;
}

// Allow view to become first responder so we can show the UIMenuController.
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 10.0);
    CGContextSetLineCap(context, kCGLineCapRound);

    // Draw complete lines in black.
    [[UIColor blackColor] set];
    for (Line *line in completeLines) {
        CGContextMoveToPoint(context, [line begin].x, [line begin].y);
        CGContextAddLineToPoint(context, [line end].x, [line end].y);
        CGContextStrokePath(context);
    }

    // Track lines in process in red.
    [[UIColor redColor] set];
    for (NSValue *v in linesInProcess) {
        Line *line = [linesInProcess objectForKey:v];
        CGContextMoveToPoint(context, [line begin].x, [line begin].y);
        CGContextAddLineToPoint(context, [line end].x, [line end].y);
        CGContextStrokePath(context);
    }

    // If there is a selected line, draw it green.
    if ([self selectedLine]) {
        [[UIColor greenColor] set];
        CGContextMoveToPoint(context, [[self selectedLine] begin].x, [[self selectedLine] begin].y);
        CGContextAddLineToPoint(context, [[self selectedLine] end].x, [[self selectedLine] end].y);
        CGContextStrokePath(context);
    }
}

- (Line *)lineAtPoint:(CGPoint)p
{
    // Find a line close to p.
    for (Line *l in completeLines) {
        CGPoint start = [l begin];
        CGPoint end = [l end];

        // Check a few points on the line.
        for (float t = 0.0; t <= 1.0; t += 0.05) {

            // Add portions of the extent to each starting value to check each
            // spot on the line.
            float x = start.x + (t * (end.x - start.x));  // end.x - start.x is the x extent.
            float y = start.y + (t * (end.y - start.y));  // end.y - start.y is the y extent.

            // If the tapped point is within 20 points, let's return this line.
            // hypot takes two side sizes and does sqrt(side1 * side1 + side2 * side2).
            if (hypot(x - p.x, y - p.y) < 20.0) {
                return l;
            }
        }
    }

    // If nothing is close enough to the tapped point, then we didn't select a line.
    return nil;
}

- (void)clearAll
{
    // Clear the collections.
    [linesInProcess removeAllObjects];
    [completeLines removeAllObjects];

    // Redraw
    [self setNeedsDisplay];
}

- (void)deleteLine:(id)sender
{
    // Remove the selected line from the list of completeLines.
    [completeLines removeObject:[self selectedLine]];

    // Redraw everything.
    [self setNeedsDisplay];
}

#pragma mark UIGestureRecognizer Delegate Methods

// Allow the pan gesture to work within the long press gesture.
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if (gestureRecognizer == moveRecognizer) {
        return YES;
    }

    return NO;
}

#pragma mark UIGestureRecognizer Actions

- (void)tap:(UIGestureRecognizer *)gr
{
    NSLog(@"Recognized tap");

    CGPoint point = [gr locationInView:self];
    [self setSelectedLine:[self lineAtPoint:point]];

    // If we just tapped, remove all lines in process
    // so that a tap doesn't result in a new line.
    [linesInProcess removeAllObjects];

    if ([self selectedLine]) {
        [self becomeFirstResponder];

        // Grab the menu controller.
        UIMenuController *menu = [UIMenuController sharedMenuController];

        // Create a new "Delete" UIMenuItem.
        UIMenuItem *deleteItem = [[UIMenuItem alloc] initWithTitle:@"Delete"
                                                            action:@selector(deleteLine:)];
        [menu setMenuItems:[NSArray arrayWithObject:deleteItem]];

        // Tell the menu where it should come from and show it.
        [menu setTargetRect:CGRectMake(point.x, point.y, 2, 2) inView:self];
        [menu setMenuVisible:YES animated:YES];

    } else {
        // Hide the menu if no line is selected.
        [[UIMenuController sharedMenuController] setMenuVisible:NO
                                                       animated:YES];
    }

    [self setNeedsDisplay];
}

- (void)longPress:(UIGestureRecognizer *)gr
{
    if ([gr state] == UIGestureRecognizerStateBegan) {
        CGPoint point = [gr locationInView:self];
        [self setSelectedLine:[self lineAtPoint:point]];

        if ([self selectedLine]) {
            [linesInProcess removeAllObjects];
        }
    } else if ([gr state] == UIGestureRecognizerStateEnded) {
        [self setSelectedLine:nil];
    }

    [self setNeedsDisplay];
}

- (void)moveLine:(UIPanGestureRecognizer *)gr
{
    // If we haven't selected a line, we don't do anything here.
    if (![self selectedLine]) {
        return;
    }

    // When the pan recognizer changes its position...
    if ([gr state] == UIGestureRecognizerStateChanged) {
        // How far has the pan moved?
        CGPoint translation = [gr translationInView:self];

        // Add the translation to the current begin and end points of the line.
        CGPoint begin = [[self selectedLine] begin];
        CGPoint end = [[self selectedLine] end];

        begin.x += translation.x;
        begin.y += translation.y;
        end.x += translation.x;
        end.y += translation.y;

        // Set the new beginning and end points of the line.
        [[self selectedLine] setBegin:begin];
        [[self selectedLine] setEnd:end];

        // Redraw the screen.
        [self setNeedsDisplay];

        // Need to zero-out the pan to get the delta each time.
        [gr setTranslation:CGPointZero inView:self];
    }
}

#pragma mark UIResponder Touch Events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *t in touches) {
        // Is this a double tap?
        if ([t tapCount] > 1) {
            [self clearAll];
            return;
        }

        if (self.selectedLine) break;

        // Use the touch object (packed in an NSValue) as the key.
        NSValue *key = [NSValue valueWithNonretainedObject:t];

        // Create a line for the value.
        CGPoint loc = [t locationInView:self];
        Line *newLine = [[Line alloc] init];
        [newLine setBegin:loc];
        [newLine setEnd:loc];

        // Put pair in dictionary.
        [linesInProcess setObject:newLine forKey:key];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.selectedLine) return;

    // Update linesInProcess with moved touches.
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];

        // Find the line for this touch.
        Line *line = [linesInProcess objectForKey:key];

        // Update the line.
        CGPoint loc = [t locationInView:self];
        [line setEnd:loc];
    }

    // Redraw.
    [self setNeedsDisplay];
}

- (void)endTouches:(NSSet *)touches
{
    if (self.selectedLine) return;

    // Remove ending touches from dictionary.
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        Line *line = [linesInProcess objectForKey:key];

        // If this is a double tap, 'line' will be nil,
        // so make sure not to add it to the array.
        if (line) {
            [completeLines addObject:line];
            [linesInProcess removeObjectForKey:key];
        }
    }

    // Redraw.
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endTouches:touches];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endTouches:touches];
}

@end
