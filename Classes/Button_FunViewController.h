//
//  Button_FunViewController.h
//  Button Fun
//
//  Created by Sebastian Österlund on 7/17/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>
#import "OptionsViewController.h"





@interface Button_FunViewController : UIViewController <OptionsViewControllerDelegate>{
	IBOutlet UILabel *statusText; // Timer display
	IBOutlet UILabel *heatText;  // Displays recommended temperature
	IBOutlet UIButton *startTimer; // Coffee cup button
	SystemSoundID ssid; // For alarm-sound
	IBOutlet UIBarButtonItem *bbiOpenPopOver; // Popover button
	UIPopoverController *popOverController;
	OptionsViewController *optionsViewController; // Popover Controller
	

	
	
	
	


}
@property (retain, nonatomic) UILabel *statusText;
@property (retain, nonatomic) UILabel *heatText;
@property (retain, nonatomic) UIButton *startTimer;
@property (retain, nonatomic) NSTimer *timerCoffee;


@property (readonly) SystemSoundID ssid;

@property (nonatomic, retain) UIBarButtonItem *bbiOpenPopOver;


@property (nonatomic, retain) UIPopoverController *popOverController;
//@property (nonatomic, retain) OptionsViewController *optionsViewController;









-(IBAction)togglePopOverController;
- (IBAction)onTimerPress:(id)sender;



@end



