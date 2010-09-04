//
//  Button_FunViewController.m
//  Button Fun
//
//  Created by Sebastian Österlund on 7/17/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "Button_FunViewController.h"

@implementation Button_FunViewController
@synthesize statusText;
@synthesize heatText;
@synthesize startTimer;
@synthesize timerCoffee;
@synthesize ssid;

@synthesize bbiOpenPopOver;
@synthesize popOverController;


int count = 0;
int minutes;
int seconds;






// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	optionsViewController = [[OptionsViewController alloc] init];
	optionsViewController.delegate = self;

	
	popOverController = [[UIPopoverController alloc] initWithContentViewController:optionsViewController];
	
	popOverController.popoverContentSize = CGSizeMake(250, 300);
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	NSString *sndPath = [[NSBundle mainBundle]
						 pathForResource:@"river"
						 ofType:@"caf"
						 inDirectory:@"/"];
	NSLog(@"%@\n", sndPath);
	// Create URL
	CFURLRef sndURL = (CFURLRef)[[NSURL alloc]
								 initFileURLWithPath:sndPath];
	
	// Create system sound ID
	AudioServicesCreateSystemSoundID(sndURL, &ssid);
}





-(IBAction)togglePopOverController {
	
	if ([popOverController isPopoverVisible]) {
		
		[popOverController dismissPopoverAnimated:YES];
		
	} else {
		
		[popOverController presentPopoverFromBarButtonItem:bbiOpenPopOver permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
		
	}
	
}


-(IBAction)onTimerPress:(id)sender
{	
	
	if (timerCoffee) {
		[timerCoffee invalidate];
		timerCoffee = nil;
		[startTimer setTitle:@"Resume" forState:UIControlStateNormal];
	}
	else if (count > 0) {
		
		[startTimer setTitle:@"Pause" forState:UIControlStateNormal];
		timerCoffee =    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector( updateTimerDisplay) userInfo:nil repeats:YES];
		
			

		

	}
	else {
		UIAlertView *alert = [[UIAlertView alloc]
							  initWithTitle:@"Select beverage"
							  message:@"Please select a beverage"
							  delegate:nil
							  cancelButtonTitle:@"Ok"
							  otherButtonTitles:nil];
		[alert show];
		[alert release];
	}


	
	

	
	}

-(void)updateTimerDisplay
{
	//set label text or whatever to current time left
	//decrement current time left
	
    if( count <=0 )  // a class var you can setup yourself. Hope you can do this
	{
		statusText.text = @"Ready!";
		[timerCoffee invalidate]; //this stops the timer
		timerCoffee = nil;
		[startTimer setTitle:@"Start" forState:UIControlStateNormal];
		
		AudioServicesPlayAlertSound(ssid); // Play alarm
		
		
		UIAlertView *alert = [[UIAlertView alloc]
							  initWithTitle:@"Ready"
							  message:@"Enjoy your drink"
							  delegate:nil
							  cancelButtonTitle:@"Done!"
							  otherButtonTitles:nil];
		[alert show];
		[alert release];
		
		
		//now you can load the next view
		// ...
	}
	else {
		count = count - 1;
		minutes = count / 60;
		seconds = count - minutes * 60;
		statusText.text = [NSString stringWithFormat:@"%d:%.2d", minutes, seconds];
		
	}

}

-(void)didTap:(NSArray *)string {
	
	
	
	count = [[string objectAtIndex:1] intValue];
	//heatText.text = @"@96C / 205F";
	NSNumber *celsius = [string objectAtIndex:2];
	int fahrenheit = ((((([celsius doubleValue])*9)/5)+32));
	
	heatText.text = [NSString stringWithFormat:@"@%@C / %dF",celsius, fahrenheit];
	
	/*
	else if ([string isEqualToString:@"French Press"]) {
		count = 6*60;
		heatText.text = @"@92C / 198F";

	}
	else if ([string isEqualToString:@"Oolong"]) {
		count = 3*60;
		heatText.text = @"@88C / 190F";
	}
	else if ([string isEqualToString:@"Rooibos"]) {
		count = 3*60;
		heatText.text = @"@93C / 200F";
	}
	else if ([string isEqualToString:@"Darjeeling"]) {
		count = 3*60;
		heatText.text = @"@82C / 180F";
	}
	else if ([string isEqualToString:@"Mint Tea"]) {
		count = 5*60;
		heatText.text = @"@98C / 208F";
		
	}
	else if ([string isEqualToString:@"Green Tea"]) {
		count = 2*60 + 30;
		heatText.text = @"@71C / 160F";
	}
	 */
	[timerCoffee invalidate]; //this stops the timer
	timerCoffee = nil;
	minutes = count / 60;
	seconds = count - minutes * 60;
	statusText.text = [NSString stringWithFormat:@"%d:%.2d", minutes, seconds];
	
	
	
	
	[popOverController dismissPopoverAnimated:YES];
	
}


- (void)dealloc {
	[statusText release];
	AudioServicesDisposeSystemSoundID(ssid);
    [super dealloc];
}

@end
