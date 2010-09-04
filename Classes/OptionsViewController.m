//
//  OptionsViewController.m
//  CoffeTeaTimer
//
//  Created by Sebastian Österlund on 8/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "OptionsViewController.h"
#import "OptionsEditController.h"
@implementation OptionsViewController


@synthesize optionsViewController;
@synthesize arrayOfStrings;
@synthesize keys;
@synthesize beverages;
@synthesize delegate;
@synthesize optionEditController;

#pragma mark -
#pragma mark View lifecycle

- (NSString *)dataFilePath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:kFilename];
}

- (void)addBeverage:(NSString *)beverage brewTime:(NSNumber *)time brewTemp:(NSNumber *)temp {
	NSString *filePath = [self dataFilePath];
	if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
		beverages = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
		//NSArray *keysa = [beverages allKeys]
		[beverages setObject:[[NSArray alloc] initWithObjects: time, temp, nil]  forKey:beverage];
		[beverages writeToFile:[self dataFilePath] atomically:YES];
	}
	
}



- (void)viewDidLoad {
    [super viewDidLoad];
	//arrayOfStrings = [[NSMutableArray alloc] initWithObjects:@"Espresso", @"French Press", @"Oolong", @"Rooibos", @"Darjeeling", @"Mint Tea", @"Green Tea", nil];
	
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	NSString *filePath = [self dataFilePath];
	if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
		beverages = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
		//NSArray *keysa = [beverages allKeys]
		NSMutableArray *keys2 = [[NSMutableArray alloc] initWithArray:[beverages allKeys]];
		NSArray *keysSorted = [keys2 sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
		keys = [[NSArray alloc] initWithArray:keysSorted];
	}
	else {
		
		keys = [[NSArray alloc] initWithObjects:
				@"Espresso", @"French Press", @"Oolong"
				, nil];
		arrayOfStrings = [[NSMutableArray alloc] initWithObjects: 
						  [NSArray arrayWithObjects: [NSNumber numberWithInt:24], [NSNumber numberWithInt:96], nil], 
						  [NSArray arrayWithObjects: [NSNumber numberWithInt:360], [NSNumber numberWithInt:92], nil], 
						  [NSArray arrayWithObjects: [NSNumber numberWithInt:180], [NSNumber numberWithInt:88], nil]
						  ,  nil];
		beverages = [NSMutableDictionary dictionaryWithObjects:arrayOfStrings forKeys:keys];
		
		[beverages writeToFile:[self dataFilePath] atomically:YES];
		[self addBeverage:@"Darjeeling" brewTime:[NSNumber numberWithInt:180] brewTemp:[NSNumber numberWithInt:82]];
		[self addBeverage:@"Mint Tea" brewTime:[NSNumber numberWithInt:300] brewTemp:[NSNumber numberWithInt:98]];
		[self addBeverage:@"Green Tea" brewTime:[NSNumber numberWithInt:150] brewTemp:[NSNumber numberWithInt:71]];
		[self addBeverage:@"Rooibos" brewTime:[NSNumber numberWithInt:180] brewTemp:[NSNumber numberWithInt:93]];
		beverages = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
		keys = [[NSArray alloc] initWithArray:[beverages allKeys]];
		
	}

	UIApplication *app = [UIApplication sharedApplication];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminate:) 
											   name: UIApplicationWillTerminateNotification object:app];
	
	
}


- (void)applicationWillTerminate:(NSNotification *)notification
{
	//[self addBeverage:@"Test" brewTime:[NSNumber numberWithInt:96] brewTemp:[NSNumber numberWithInt:96]];
	//[beverages setObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:24], [NSNumber numberWithInt:96], nil] forKey:@"Rooibos"];
	//NSString *filePath = [self dataFilePath];
	// Add saving of array
	//arrayOfStrings = [[NSMutableArray alloc] initWithObjects:@"Espresso", @"French Press", @"Oolong", @"Rooibos", @"Darjeeling", @"Mint Tea", @"Green Tea", nil];
	[beverages writeToFile:[self dataFilePath] atomically:YES];
	[beverages release];
}

- (IBAction)switchViews:(id)sender
{
	if (self.optionEditController == nil) {
		
	self.optionEditController = [[OptionsEditController alloc] initWithNibName:@"OptionsEditController" bundle:nil];
	
	
	}
	[self.view addSubview:optionEditController.view];
	[optionEditController release];
		
	/*
	UIAlertView *alert = [[UIAlertView alloc]
						  initWithTitle:@"Edit"
						  message:@"Create new"
						  delegate:nil
						  cancelButtonTitle:@"News"
						  otherButtonTitles:nil];
	[alert show];
	[alert release];
	 */
	
}
/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Override to allow orientations other than the default portrait orientation.
    return YES;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [keys count];
	

}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	//id key = [keys objectAtIndex:indexPath.row];
	//NSLog(@"alkan %@\n", key);

	cell.textLabel.text = [keys objectAtIndex:indexPath.row];

    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	NSLog(@"Random\n");
	//NSLog(@"%@\n", [beverages objectForKey:@"Espresso"]);
	NSNumber *time = [[beverages objectForKey:[keys objectAtIndex:indexPath.row]] objectAtIndex:0];
	NSNumber *temp = [[beverages objectForKey:[keys objectAtIndex:indexPath.row]] objectAtIndex:1];
	NSArray *array = [[NSArray alloc] initWithObjects:[keys objectAtIndex:indexPath.row], time, temp, nil]; 
	//[self.delegate didTap:[keys objectAtIndex:indexPath.row]];
	NSLog(@"Random2\n");
	[self.delegate didTap:array];
	[array release];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[optionsViewController release];
	[delegate release];
	[arrayOfStrings release];
	[keys release];
	//[beverages release];
}


@end

