//
//  HypnosisView.m
//  Hypnosister
//
//  Created by Sean Coleman on 6/13/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import "HypnosisView.h"

@implementation HypnosisView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // All HypnosisViews start with a clear background color.
        [self setBackgroundColor:[UIColor clearColor]];
    }

    return self;
}

- (void)drawRect:(CGRect)dirtyRect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect bounds = [self bounds];

    // Figure out the center of the bounds rectangle.
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;

    // The radius of the circle should be nearly as big as the view.
    //float maxRadius = hypot(bounds.size.width, bounds.size.height) / 4.0;
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;

    // The thickness of the line should be 10 points wide.
    CGContextSetLineWidth(ctx, 10);

    // The color of the line should be gray (red/green/blue = 0.6, alpha = 1.0).
    //CGContextSetRGBStrokeColor(ctx, 0.6, 0.6, 0.6, 1.0);
    //[[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0] setStroke];
    [[UIColor lightGrayColor] setStroke];

    // Add a shape to the context - this does not draw the shape.
    //CGContextAddArc(ctx, center.x, center.y, maxRadius, 0.0, M_PI * 2.0, YES);

    // Perform a drawing instruction; draw current shape with current state.
    //CGContextStrokePath(ctx);

    // Draw concentric circles fro the outside in.
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
        // Add a path to the context.
        CGContextAddArc(ctx, center.x, center.y, currentRadius, 0.0, M_PI * 2.0, YES);

        // Perform drawing instruction; removes path.
        CGContextStrokePath(ctx);
    }
}

@end
