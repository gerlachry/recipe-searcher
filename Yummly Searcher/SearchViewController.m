//
//  SearchViewController.m
//  Yummly Searcher
//
//  Created by Gerlach, Ryan K on 5/31/13.
//  Copyright (c) 2013 Gerlach, Ryan K. All rights reserved.
//

#import "SearchViewController.h"
#import "YummlyFetch.h"
#import "AllergenCell.h"
#import "SWRevealViewController.h"

@interface SearchViewController () <UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation SearchViewController

@synthesize allergySearchValues = _allergySearchValues;
@synthesize searchBar = _searchBar;


- (void)viewDidLoad
{
    [super viewDidLoad];
    //setup navigation buttons
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelPressed)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStylePlain target:self action:@selector(searchPressed)];
    self.navigationItem.rightBarButtonItem = searchButton;
    
    //setup searchbar delegate
    self.searchBar.delegate = self;
    //setup list of allergens using the Yummly metadata API
    [self loadAllergySearchValues];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)loadAllergySearchValues
{
    //get allergens from yummly, array of dictionaries
    /*
    NSArray *allergens = [YummlyFetch allergySearchValues];
    NSLog(@"allergens = %@", allergens);
    NSMutableArray *mutableAllergens = [allergens mutableCopy];
    //add switch to each dictionary object in array
    for (NSMutableDictionary *dict in mutableAllergens){
        [dict setObject:YUMMLY_ALLERGY_SWITCH_OFF forKey:YUMMLY_ALLERGY_SWITCH];
        
    }
    self.allergySearchValues = mutableAllergens;
    */
    self.allergySearchValues = [YummlyFetch allergySearchValues];
    //NSLog(@"allergySearchValues = %@",self.allergySearchValues);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.allergySearchValues count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Allergen Cell";
    AllergenCell *cell = (AllergenCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    cell.allergenLabel.text = [[self.allergySearchValues objectAtIndex:indexPath.row] valueForKeyPath:YUMMLY_ALLERGY_LONG];
    //NSString *switchValue = [[self.allergySearchValues objectAtIndex:indexPath.row] valueForKey:YUMMLY_ALLERGY_SWITCH];
   /*
    if ([switchValue isEqualToString:YUMMLY_ALLERGY_SWITCH_OFF]){
        cell.allergenSwitch.on = NO;
    } else {
        cell.allergenSwitch.on = YES;
    }
    */
    cell.allergenSwitch.on = NO;
    //setting dynamic label and switch positions
    CGRect aframe = cell.allergenLabel.frame;
    aframe.size.width = self.revealViewController.rearViewRevealWidth/2;
    cell.allergenLabel.frame = aframe;
    CGRect sFrame = cell.allergenSwitch.frame;
    sFrame.origin.x = cell.frame.size.width - cell.allergenSwitch.frame.size.width - 5;
    cell.allergenSwitch.frame = sFrame;
    
    //NSLog(@"cell %f", cell.frame.size.width);
    //NSLog(@"frame %f", cell.allergenLabel.frame.size.width);
    //NSLog(@"sframe %f", cell.allergenSwitch.frame.origin.x);
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - search bar delegates
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self searchPressed];
}

#pragma mark - helper methods
-(void)cancelPressed
{
    //  clear the search bar and all the switches and the results on front view if any
    NSLog(@"cancel pressed");
}

-(void)searchPressed
{
    // search yummly based on search bar text and other filters (switches)
    [self.searchBar resignFirstResponder];
    NSLog(@"search pressed %@", self.searchBar.text);
}
@end






