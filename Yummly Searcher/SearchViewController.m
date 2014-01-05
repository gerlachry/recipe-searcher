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
#import "SearchCollectionViewController.h"

@interface SearchViewController () <UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) NSString *searchString;

@end

@implementation SearchViewController

@synthesize allergySearchValues = _allergySearchValues;
@synthesize searchBar = _searchBar;
@synthesize spinner = _spinner;
@synthesize searchString = _searchString;

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

- (UIActivityIndicatorView *)spinner
{
    //lazy instantiation
    if (!_spinner) {
        _spinner =[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:
                   UIActivityIndicatorViewStyleGray];
        _spinner.hidesWhenStopped=YES;
        //put spinner on navigation bar, added array of buttons (Visit/unvisit and spinner)
        NSArray *rightButtons =  self.navigationItem.rightBarButtonItems;
        NSMutableArray *mutableRightButtons = [rightButtons mutableCopy];
        int count = [mutableRightButtons count];
        [mutableRightButtons insertObject:[[UIBarButtonItem alloc] initWithCustomView:_spinner] atIndex:count];
        self.navigationItem.rightBarButtonItems = mutableRightButtons;
    }
    return _spinner;
}

-(void)loadAllergySearchValues
{
    //get allergens from yummly, array of dictionaries
    //TODO : store allergens in user defaults and only update when there is a change, Yummly API has last mod date to utilize
    [self.spinner startAnimating];
    dispatch_queue_t downloadQueue = dispatch_queue_create("downloadAllergens", NULL);
    dispatch_async(downloadQueue, ^{
        NSArray *allergens = [YummlyFetch allergySearchValues];
        NSMutableArray *mutableAllergens = [allergens mutableCopy];
        //add switch to each dictionary object in array to keep track of toggle switches
        for (NSMutableDictionary *dict in mutableAllergens){
            [dict setObject:YUMMLY_ALLERGY_SWITCH_OFF forKey:YUMMLY_ALLERGY_SWITCH];
        }
        self.allergySearchValues = mutableAllergens;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self.spinner stopAnimating];
        });
    });
    
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
    NSString *switchValue = [[self.allergySearchValues objectAtIndex:indexPath.row] valueForKeyPath:YUMMLY_ALLERGY_SWITCH];
   
    if ([switchValue isEqualToString:YUMMLY_ALLERGY_SWITCH_OFF]){
        cell.allergenSwitch.on = NO;
    } else {
        cell.allergenSwitch.on = YES;
    }
    //use the tag later to link a switch to data model
    cell.allergenSwitch.tag = indexPath.row;
    
    //setting dynamic label and switch positions based on views width
    CGRect aframe = cell.allergenLabel.frame;
    aframe.size.width = self.revealViewController.rearViewRevealWidth/2;
    cell.allergenLabel.frame = aframe;
    CGRect sFrame = cell.allergenSwitch.frame;
    sFrame.origin.x = cell.frame.size.width - cell.allergenSwitch.frame.size.width - 5;
    cell.allergenSwitch.frame = sFrame;
    NSLog(@"%@",[[self.allergySearchValues objectAtIndex:indexPath.row] valueForKeyPath:YUMMLY_ALLERGY_LONG]);
    return cell;
}

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

- (IBAction)switchPressed:(UISwitch *)sender
{
    //update model when switch is toggled
    if([sender isOn]){
        [[self.allergySearchValues objectAtIndex:sender.tag] setValue:YUMMLY_ALLERGY_SWITCH_ON forKey:YUMMLY_ALLERGY_SWITCH];
    } else {
        [[self.allergySearchValues objectAtIndex:sender.tag] setValue:YUMMLY_ALLERGY_SWITCH_OFF forKey:YUMMLY_ALLERGY_SWITCH];
    }
}

-(void)cancelPressed
{
    //  TODO: clear the search bar and all the switches and the results if any
    NSLog(@"cancel pressed");
}

-(void)searchPressed
{
    // search yummly based on search bar text and other filters (switches)
    [self.searchBar resignFirstResponder];
    NSString *searchString = self.searchBar.text;
    for(NSDictionary *items in self.allergySearchValues) {
        
        if([[items valueForKey:YUMMLY_ALLERGY_SWITCH] isEqualToString:YUMMLY_ALLERGY_SWITCH_ON]){
            NSString *searchValue =[items valueForKey:YUMMLY_ALLERGY_SEARCH_VALUE];
            searchString = [searchString stringByAppendingString:[NSString stringWithFormat:@"&allowedAllergy[]=%@",searchValue]];
        }
    }
    self.searchString = searchString;
    NSLog(@"searchString %@", searchString);
    
    UIViewController *vc = self.revealViewController.frontViewController;
    UIViewController *vcc = [(UINavigationController *)vc topViewController];
    [(SearchCollectionViewController *)vcc setSearchString:self.searchString];
    
}
@end






