//
//  OptionsViewController.h
//  CoffeTeaTimer
//
//  Created by Sebastian Österlund on 8/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kFilename @"data.plist"
@class OptionsEditController;
@protocol OptionsViewControllerDelegate <NSObject>

-(void)didTap:(NSArray *)string;


@end

@interface OptionsViewController : UIViewController {
	OptionsViewController *optionsViewController;
	NSMutableDictionary *beverages;
	NSArray *keys;
	NSMutableArray *arrayOfStrings;
	id delegate;
	OptionsEditController *optionEditController;

}

@property (nonatomic, retain) OptionsViewController *optionsViewController;
@property (nonatomic, retain) OptionsEditController *optionEditController;
@property (nonatomic, retain) NSMutableArray *arrayOfStrings;
@property (nonatomic, retain) NSArray *keys;
@property (nonatomic, retain) NSMutableDictionary *beverages;
@property (nonatomic, assign) id<OptionsViewControllerDelegate> delegate;

- (NSString *)dataFilePath;
- (void)applicationWillTerminate:(NSNotification *)notification;
- (IBAction)switchViews:(id)sender;

@end
