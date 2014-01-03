//
//  SourceRecipeWebViewController.m
//  Yummly Searcher
//
//  Created by Gerlach, Ryan K on 1/2/14.
//  Copyright (c) 2014 Gerlach, Ryan K. All rights reserved.
//

#import "SourceRecipeWebViewController.h"

@interface SourceRecipeWebViewController ()

@end

@implementation SourceRecipeWebViewController

@synthesize webView = _webView;
@synthesize recipeURL = _recipeURL;

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

-(void)viewWillAppear:(BOOL)animated
{
    [self refreshWebView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setRecipeURL:(NSString *)recipeURL
{
    _recipeURL = recipeURL;
}

-(void)refreshWebView
{
    NSURL *url = [NSURL URLWithString:self.recipeURL];
    NSLog(@"url %@", url);
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

@end






