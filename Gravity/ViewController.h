//
//  ViewController.h
//  Gravity
//
//  Created by Benoit Widemann on 27/10/12.
//  Copyright (c) 2012 Benoit Widemann. All rights reserved.
//  Upgraded by Julie Arrigoni, Pierre Mary, Lucas Heymès on 09/11/12
//

#import <UIKit/UIKit.h>
	// we need the framework AudioToolbox to play the sound
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController : UIViewController <UIAccelerometerDelegate>
{
	SystemSoundID tink;	// our sound
	BOOL xEdge, yEdge;	// flags for image on limit (avoid repeating sound)
}

@property (retain, nonatomic) IBOutlet UIImageView *gravImageView;

@end
