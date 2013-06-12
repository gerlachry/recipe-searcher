//
//  SearchResultsTableViewController.m
//  Yummly Searcher
//
//  Created by Gerlach, Ryan K on 6/7/13.
//  Copyright (c) 2013 Gerlach, Ryan K. All rights reserved.
//

#import "SearchResultsTableViewController.h"
#import "RecipeHelper.h"
#import "Recipes.h"

@interface SearchResultsTableViewController ()

@end

@implementation SearchResultsTableViewController

@synthesize searchString = _searchString;

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
    [self setupFetchedResultsContoller];
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
    [RecipeHelper openRecipeDB:[RecipeHelper getCurrentDatabase] usingBlock:^(UIManagedDocument *recipeDB)  {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Recipes"];
        //need to add predicate to only get recipes for current search
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"recipe" ascending:YES];
        request.sortDescriptors = [NSArray arrayWithObject:sort];
        NSLog(@"setting fetchedresults");
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:recipeDB.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    }];
       
}
#pragma mark - Table view data source
/*
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
*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Recipe Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // set title to recipe name, subtitle to original site name, left assec. image to small url if any
    // if reusing cell cleanup image
    Recipes *recipe = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = recipe.recipe;
    cell.detailTextLabel.text = recipe.sourceDisplayName;
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
