//
//  ViewController.m
//  Gravity
//
//  Created by Benoit Widemann on 27/10/12.
//  Copyright (c) 2012 Benoit Widemann. All rights reserved.
//  Upgraded by Julie Arrigoni, Pierre Mary, Lucas Heymès on 09/11/12
//

#import "ViewController.h"
	// we need the QuartzCore framework for animation
#import <QuartzCore/QuartzCore.h>

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
		// setup accelerometer
	UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
	accelerometer.delegate = self;
	accelerometer.updateInterval = 0.1;
		// load sound
	AudioServicesCreateSystemSoundID((CFURLRef)[NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"woodblock" ofType:@"aif"]], &tink);
}

- (void)dealloc
{
		// clean up
	AudioServicesDisposeSystemSoundID(tink);
	[_gravImageView release];
	[super dealloc];
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    #pragma mark - Init
	BOOL needTink = NO;
		// get acceleration value
	float x = acceleration.x * 100;
	float y = acceleration.y * 100;
		// get image position
	CGPoint p = self.gravImageView.center;
		// create the path for animation, move to current point
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint(path, nil, p.x, p.y);
	
		// calculate new point
		// make sure we stay on screen (32 is half of image size)
	CGRect limitRect = CGRectInset(self.view.bounds, 32, 32);
	
    
    #pragma mark - X Position
	p.x += x;
	if (p.x < limitRect.origin.x) {
			// too far left
		p.x = limitRect.origin.x;
		if (xEdge == NO)	{
				// set the flag and play sound
			xEdge = YES;
			needTink = YES;
		}
	} else if (p.x > limitRect.origin.x + limitRect.size.width) {
			// too far right
		p.x = limitRect.origin.x + limitRect.size.width;
		if (xEdge == NO)	{
				// set the flag and play sound
			xEdge = YES;
            // Add Bounce
            
			needTink = YES;
		}
	} else {
			// reset flag
		xEdge = NO;
	}

    #pragma mark - X Position
    // repeat for y, use negative offset (y goes down)
	p.y -= y;
	if (p.y < limitRect.origin.y) {
		p.y = limitRect.origin.y;
		if (yEdge == NO)	{
			yEdge = YES;
			needTink = YES;
		}
	} else if (p.y > limitRect.origin.y + limitRect.size.height) {
		p.y = limitRect.origin.y + limitRect.size.height;
		if (yEdge == NO)	{
			yEdge = YES;
			needTink = YES;
		}
	} else {
		yEdge = NO;
	}
	
	
    
    // now we have a new point in p, move image
	self.gravImageView.center = p;
    // complete the path
	CGPathAddLineToPoint(path, nil, p.x, p.y);
    // create the animation
	CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    // set the duration to just a bit less than accelerometer interval
	anim.duration = 0.09;
    // give the animation the path to use, then release it (anim will retain it)
	anim.path = path;
	CGPathRelease(path);
    // give the animation to the imageView's CALayer
	[self.gravImageView.layer addAnimation:anim forKey:@"anim"];
    
	
	if (needTink)	{
			// play sound at the end of animation
		[NSTimer scheduledTimerWithTimeInterval:0.09 target:self selector:@selector(playTink:) userInfo:nil repeats:NO];
	}
}

#pragma mark - Sound

	// timer callback
- (void)playTink:(NSTimer *)timer
{
	AudioServicesPlaySystemSound(tink);
}

@end
