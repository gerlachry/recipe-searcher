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

@interface SearchViewController ()

@end

@implementation SearchViewController

@synthesize allergySearchValues = _allergySearchValues;




- (void)viewDidLoad
{
    [super viewDidLoad];
    //setup list of allergens
    [self loadAllergySearchValues];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)loadAllergySearchValues
{
    //get allergens from yummly, array of dictionaries
    NSArray *allergens = [YummlyFetch allergySearchValues];
    NSMutableArray *mutableAllergens = [allergens mutableCopy];
    //add switch to each dictionary object in array
    for (NSMutableDictionary *dict in mutableAllergens){
        [dict setObject:YUMMLY_ALLERGY_SWITCH_OFF forKey:YUMMLY_ALLERGY_SWITCH];
        
    }
    self.allergySearchValues = mutableAllergens;
    NSLog(@"allergySearchValues = %@", self.allergySearchValues);
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

    cell.allergenLabel.text = [[self.allergySearchValues objectAtIndex:indexPath.row] valueForKey:YUMMLY_ALLERGY_LONG];
    NSString *switchValue = [[self.allergySearchValues objectAtIndex:indexPath.row] valueForKey:YUMMLY_ALLERGY_SWITCH];
    if ([switchValue isEqualToString:YUMMLY_ALLERGY_SWITCH_OFF]){
        cell.allergenSwitch.on = NO;
    } else {
        cell.allergenSwitch.on = YES;
    }
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

@end
