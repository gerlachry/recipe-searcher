//
//  SearchResultsTableViewController.m
//  Yummly Searcher
//
//  Created by Gerlach, Ryan K on 6/7/13.
//  Copyright (c) 2013 Gerlach, Ryan K. All rights reserved.
//

#import "SearchResultsTableViewController.h"

@interface SearchResultsTableViewController ()

@end

@implementation SearchResultsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //setup fetched table view via core data
    [self fetchedResultsController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CoreDataTableViewController
-(void)setupFetchedResultsContoller
{
    //setup the table to populate via coredata query, need to add coredata helper class and model
    /*
    [VacationHelper openVacation:[VacationHelper getCurrentVacation] usingBlock:^(UIManagedDocument *vacation){
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Place"];
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"dateAdded" ascending:YES];
        request.sortDescriptors = [NSArray arrayWithObject:sort];
        
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:vacation.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    }];
     */
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // number of sections will be the recipe groups (dinner, lunch, soup...)
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // number of recipes in the section
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Recipe Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // set title to recipe name, subtitle to original site name, left assec. imiage to small url if any
    // if reusing cell cleanup image
    
    return cell;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    //segue to the recipe's site using uiwebview
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // probably nothing here, need to touch right accesssory and will segue to recipe site
    
}

@end
