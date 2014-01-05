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
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

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
    [self.spinner stopAnimating];
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
        [self.spinner startAnimating];
        dispatch_queue_t downloadQueue = dispatch_queue_create("download", NULL);
        dispatch_async(downloadQueue, ^{
            self.currentRecipeDetails = [YummlyFetch recipeForID:[self.recipe valueForKey:YUMMLY_ID]];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.ingredientsTextView.text = [[self.currentRecipeDetails valueForKey:YUMMLY_INGREDIENT_LINES] componentsJoinedByString:@",\n"];
                [self.spinner stopAnimating];
            });
        });
        

    }
}

- (IBAction)sourceButtonSelected:(UIButton *)sender
{
    [self.delegate selectedSourceRecipe:self.currentRecipeDetails with:self];
}


@end






















