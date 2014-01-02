//
//  RecipeViewController.m
//  Yummly Searcher
//
//  Created by Gerlach, Ryan K on 12/24/13.
//  Copyright (c) 2013 Gerlach, Ryan K. All rights reserved.
//

#import "RecipeViewController.h"
#import "YummlyFetch.h"

@interface RecipeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *ingredientsTextView;
@property (nonatomic, strong) NSDictionary *currentRecipeDetails;

@end

@implementation RecipeViewController

@synthesize recipe = _recipe;
@synthesize ingredientsTextView = _ingredientsTextView;
@synthesize currentRecipeDetails = _currentRecipeDetails;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.ingredientsTextView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"antique_paper.jpg"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setRecipe:(NSDictionary *)recipe
{
    _recipe = recipe;
    [self refreshRecipe];
}

-(void) refreshRecipe
{
    if(self.recipe) {
        //TODO : start spinner, download recipe details via yummly api, update UI, stop spinner
        //self.ingredientsTextView.text = [[self.recipe valueForKeyPath:<#(NSString *)#>]]
        dispatch_queue_t downloadQueue = dispatch_queue_create("download", NULL);
        dispatch_async(downloadQueue, ^{
            NSLog(@"viewer recipe id = %@", [self.recipe valueForKey:YUMMLY_ID]);
            self.currentRecipeDetails = [YummlyFetch recipeForID:[self.recipe valueForKey:YUMMLY_ID]];
            NSLog(@"currentRecipeDetails %@", self.currentRecipeDetails);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.ingredientsTextView.text = [[self.currentRecipeDetails valueForKey:YUMMLY_INGREDIENT_LINES] componentsJoinedByString:@",\n"];
            });
        });
        

    }
}

@end






















