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

@end

@implementation SearchCollectionViewController

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

@end
