//
//  AppDelegate.m
//  Gravity
//
//  Created by Benoit Widemann on 27/10/12.
//  Copyright (c) 2012 Benoit Widemann. All rights reserved.
//  Upgraded by Julie Arrigoni, Pierre Mary, Lucas Heymès on 09/11/12
//

#import "AppDelegate.h"

#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
	ViewController *viewController = [[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
	self.window.rootViewController = viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)dealloc
{
	[_window release];
    [super dealloc];
}

@end
