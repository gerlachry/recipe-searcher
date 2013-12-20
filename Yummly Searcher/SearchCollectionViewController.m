//
//  SearchCollectionViewController.m
//  Yummly Searcher
//
//  Created by Gerlach, Ryan K on 12/19/13.
//  Copyright (c) 2013 Gerlach, Ryan K. All rights reserved.
//

#import "SearchCollectionViewController.h"
#import "SWRevealViewController.h"

@interface SearchCollectionViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation SearchCollectionViewController

@synthesize recipes = _recipes;
@synthesize collectionView = _collectionView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setRecipes:(NSArray *)recipes
{
    NSLog(@"recipes %@", recipes);
    _recipes = recipes;
}

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
    NSLog(@"rearwidth %f", self.revealViewController.rearViewRevealWidth);
    NSLog(@"frontwidth %f", self.view.frame.size.width);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - collection view data source

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    //could do sections by cuisine or by entree type
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.recipes count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"RecipeCell " forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}
@end





























