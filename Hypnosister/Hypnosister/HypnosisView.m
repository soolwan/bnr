//
//  HypnosisView.m
//  Hypnosister
//
//  Created by Sean Coleman on 6/13/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import "HypnosisView.h"

@implementation HypnosisView

// Implement setter so we can setNeedsDisplay.
- (void)setCircleColor:(UIColor *)circleColor
{
    _circleColor = circleColor;
    [self setNeedsDisplay];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // All HypnosisViews start with a clear background color.
        [self setBackgroundColor:[UIColor clearColor]];
        [self setCircleColor:[UIColor lightGrayColor]];

        // Create the new layer object (Chaper 22).
        boxLayer = [[CALayer alloc] init];

        // Give it a size.
        [boxLayer setBounds:CGRectMake(0.0, 0.0, 85.0, 85.0)];

        // Give it a location.
        [boxLayer setPosition:CGPointMake(160.0, 100.0)];

        // Make half-transparent red the background color for the layer.
        UIColor *reddish = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.5];

        // Get a CGColor object with the same color values.
        CGColorRef cgReddish = [reddish CGColor];
        [boxLayer setBackgroundColor:cgReddish];

        // Create a UIImage.
        UIImage *layerImage = [UIImage imageNamed:@"Hypno.png"];

        // Get the underlying CGImage.
        CGImageRef image = [layerImage CGImage];

        // Put the CGImage on the layer.
        [boxLayer setContents:(__bridge id)image];

        // Inset the image a bit on each side.
        [boxLayer setContentsRect:CGRectMake(-0.1, -0.1, 1.2, 1.2)];

        // Let the image resize (without changing the aspect ratio)
        // to fill the contentRect.
        [boxLayer setContentsGravity:kCAGravityResizeAspect];

        // Make it a sublayer of the view's layer.
        [[self layer] addSublayer:boxLayer];
    }

    return self;
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
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
    //[[UIColor lightGrayColor] setStroke];
    [self.circleColor setStroke];

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

    // Create a string.
    NSString *text = @"You are getting sleepy.";

    // Get a font to draw it in.
    UIFont *font = [UIFont boldSystemFontOfSize:28];

    CGRect textRect;

    // How big is the string when drawn in this font?
    textRect.size = [text sizeWithFont:font];

    // Let's put thta string in the center of the view.
    textRect.origin.x = center.x - textRect.size.width / 2.0;
    textRect.origin.y = center.y - textRect.size.height / 2.0;

    // Set the fill color of the current context to black.
    [[UIColor blackColor] setFill];

    // The shadow will move 4 points to the right and 3 points down from the text.
    CGSize offset = CGSizeMake(4, 3);

    // The shadow will be dark gray in color.
    CGColorRef color = [[UIColor darkGrayColor] CGColor];

    // Set the shadow of the context with these parameters,
    // all subsequent drawing will be shadowed.
    CGContextSetShadowWithColor(ctx, offset, 2.0, color);

    // Draw the string to the current context.
    [text drawInRect:textRect withFont:font];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    // We only have shake motions right now, but more may be added in the future.
    if (motion == UIEventSubtypeMotionShake) {
        NSLog(@"Device started shaking!");
        [self setCircleColor:[UIColor redColor]];
    }
}

@end
