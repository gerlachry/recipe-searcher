//
//  SearchCollectionViewController.m
//  Yummly Searcher
//
//  Created by Gerlach, Ryan K on 12/19/13.
//  Copyright (c) 2013 Gerlach, Ryan K. All rights reserved.
//

#import "SearchCollectionViewController.h"
#import "SWRevealViewController.h"
#import "RecipeCollectionCell.h"
#import "YummlyFetch.h"
#import "RecipeViewController.h"
#import "SourceRecipeWebViewController.h"

@interface SearchCollectionViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSDictionary *selecteRecipe;
@property (nonatomic, strong) NSDictionary *selectedRecipeDetails; //detailed recipe coming back from popover protocol
@property (weak, nonatomic) IBOutlet UIButton *anchorButton;
@property (nonatomic, strong) UIPopoverController *recipeViewPopoverController;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation SearchCollectionViewController

@synthesize recipes = _recipes;
@synthesize collectionView = _collectionView;
@synthesize selecteRecipe = _selecteRecipe;
@synthesize recipeViewPopoverController = _recipeViewPopoverController;
@synthesize searchString = _searchString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setRecipes:(NSDictionary *)recipes
{
    _recipes = recipes;
    [self.collectionView reloadData];
}

-(void)setSearchString:(NSString *)searchString
{
    _searchString = searchString;
    [self fetchRecipes];
}

/*
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
*/

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //collection view
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_cork@2x.png"]];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    UIBarButtonItem *menuBtn = [[UIBarButtonItem alloc] init];
    menuBtn.image = [UIImage imageNamed:@"menu.png"];
    menuBtn.target = self.revealViewController;
    menuBtn.action = @selector(revealToggle:);
    self.navigationItem.leftBarButtonItem = menuBtn;
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    //display entire rear view using overdraw property
    self.revealViewController.rearViewRevealOverdraw=0;
    //resize rear view to half the width of front view
    self.revealViewController.rearViewRevealWidth = self.view.frame.size.width/2;
    //NSLog(@"rearwidth %f", self.revealViewController.rearViewRevealWidth);
    //NSLog(@"frontwidth %f", self.view.frame.size.width);
    [self.spinner stopAnimating];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fetchRecipes
{
    //Yummly API call
    [self.spinner startAnimating];
    dispatch_queue_t downloadQueue = dispatch_queue_create("downloadRecipes", NULL);
    dispatch_async(downloadQueue, ^{
        int max = YUMMLY_SEARCH_MAX_RESULTS;
        int start = YUMMLY_SEARCH_START_NUMBER;
        self.recipes = [YummlyFetch topRecipesForSearch:self.searchString withMaxResultsPerPage:max startingAtItem:start];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
            [self.spinner stopAnimating];
        });
    });
   
}

#pragma mark - collection view data source

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    //could do sections by cuisine or by entree type
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[self.recipes valueForKey:@"matches"] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RecipeCollectionCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"RecipeCell2" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.recipeName.text = [[[self.recipes valueForKey:@"matches"] objectAtIndex:indexPath.row] valueForKeyPath:YUMMLY_RECIPE_NAME];
    NSString *ingredients = [[[[self.recipes valueForKey:@"matches"] objectAtIndex:indexPath.row] valueForKeyPath:YUMMLY_INGREDIENTS] componentsJoinedByString:@", "];
    cell.ingredients.text = ingredients;
    cell.ingredients.backgroundColor = [UIColor clearColor];
    return cell;
}

//in collection view how to set the space between each cell ...
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(20, 20, 20, 20);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //made an invisible button w/ an outlet in the storyboard to use as an anchor point to enable a popover segue when a collection cell is selected
    RecipeCollectionCell *myCell = (RecipeCollectionCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    
    //Make the rect you want the popover to point at.
    CGRect displayFrom = CGRectMake(myCell.frame.origin.x + myCell.frame.size.width, myCell.center.y + self.collectionView.frame.origin.y - self.collectionView.contentOffset.y, 1, 1);
    
    //Now move your anchor button to this location
    self.anchorButton.frame = displayFrom;
    
    //keep track of the currently selected recipe
    self.selecteRecipe = [[self.recipes valueForKey:@"matches"] objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"RecipeSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"RecipeSegue"]) {
        //set current recipe and save reference to the popoverVC so we can later dismiss via protocol
        self.recipeViewPopoverController =  [(UIStoryboardPopoverSegue *)segue popoverController];
        [segue.destinationViewController setDelegate:self];
        [segue.destinationViewController setRecipe:self.selecteRecipe];
    } else if ([segue.identifier isEqualToString:@"SegueToWeb"]){
        [segue.destinationViewController setRecipeURL:[self.selectedRecipeDetails valueForKeyPath:@"source.sourceRecipeUrl"]];
    }
}

#pragma mark - RecipeViewController delegate
-(void)selectedSourceRecipe:(NSDictionary *)recipe with:(RecipeViewController *)sender
{
    if(self.recipeViewPopoverController){
        [self.recipeViewPopoverController dismissPopoverAnimated:YES];
        self.selectedRecipeDetails = recipe;
        [self performSegueWithIdentifier:@"SegueToWeb" sender:self];
    }
}

@end





























































