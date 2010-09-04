//
//  OptionsEditController.h
//  CoffeTeaTimer
//
//  Created by Sebastian Österlund on 8/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OptionsEditController : UIViewController {
	IBOutlet UILabel *testText; // Timer display
}

@property (retain, nonatomic) UILabel *testText;
- (IBAction)pressButton;
@end
