//
//  RecipeViewController.m
//  Yummly Searcher
//
//  Created by Gerlach, Ryan K on 12/24/13.
//  Copyright (c) 2013 Gerlach, Ryan K. All rights reserved.
//

#import "RecipeViewController.h"

@interface RecipeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *ingredientsTextView;

@end

@implementation RecipeViewController

@synthesize recipe = _recipe;
@synthesize ingredientsTextView = _ingredientsTextView;

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
        //self.ingredientsTextView.text = [[self.recipe valueForKeyPath:<#(NSString *)#>]]
        NSLog(@"recipe = %@", self.recipe);
    }
}

@end






















