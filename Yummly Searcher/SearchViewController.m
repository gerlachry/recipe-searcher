//
//  SearchViewController.m
//  Yummly Searcher
//
//  Created by Gerlach, Ryan K on 5/24/13.
//  Copyright (c) 2013 Gerlach, Ryan K. All rights reserved.
//

#import "SearchViewController.h"
#import "YummlyFetch.h"

@interface SearchViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation SearchViewController

@synthesize allergySearchValues = _allergySearchValues;

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
    self.scrollView.delegate = self;
    [self refreshAllergy];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshAllergy
{
    //update the view to contain the most recent allergens from Yummly for searching
    self.scrollView.scrollEnabled = YES;
    self.allergySearchValues = [YummlyFetch allergySearchValues];
    
    const CGFloat height = 38;
    const CGFloat labelWidth = 158;
    const CGFloat switchWidth = 27;
    const CGFloat margin = 0;
    const CGFloat xLabel = 20;
    const CGFloat xSwitch = 223;
    CGFloat y = 20;
    
    for(int i=0; i < [self.allergySearchValues count]; i++){
        NSLog(@"allergenDict = %@", [self.allergySearchValues objectAtIndex:i]);
        //create label and switch for each allergen, add to scroll view
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(xLabel, y, labelWidth, height)];
        NSDictionary *dict = [self.allergySearchValues objectAtIndex:i];
        label.text = [dict valueForKey:YUMMLY_ALLERGY_LONG];
        label.font = [UIFont systemFontOfSize:22];
        [self.scrollView addSubview:label];
        
        UISwitch *allergySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(xSwitch, y, 79, height)];
        allergySwitch.tag = (int)[dict valueForKey:YUMMLY_ALLERGY_ID];
        [self.scrollView addSubview:allergySwitch];
        
        y += height +margin;
        
    }
    self.scrollView.contentSize = CGSizeMake(labelWidth + switchWidth, y - margin);
}

- (IBAction)searchPressed:(id)sender
{
    NSMutableArray *subviews =[self.scrollView.subviews mutableCopy];
    for (int i = 0; i < [subviews count]; i++) {
        NSLog(@"subview = %@",[subviews objectAtIndex:i]);
    }
}

@end







