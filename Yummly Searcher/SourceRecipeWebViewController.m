//
//  SourceRecipeWebViewController.m
//  Yummly Searcher
//
//  Created by Gerlach, Ryan K on 1/2/14.
//  Copyright (c) 2014 Gerlach, Ryan K. All rights reserved.
//

#import "SourceRecipeWebViewController.h"

@interface SourceRecipeWebViewController ()
@property (nonatomic, strong) UIActivityIndicatorView *spinner;
@end

@implementation SourceRecipeWebViewController

@synthesize webView = _webView;
@synthesize recipeURL = _recipeURL;
@synthesize spinner = _spinner;

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

- (UIActivityIndicatorView *)spinner
{
    //lazy instantiation
    if (!_spinner) {
        NSLog(@"creating spinner");
        _spinner =[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:
                   UIActivityIndicatorViewStyleGray];
        _spinner.hidesWhenStopped=YES;
        //put spinner on navigation bar
        NSArray *rightButtons =  self.navigationItem.rightBarButtonItems;
        NSMutableArray *mutableRightButtons = [rightButtons mutableCopy];
        int count = [mutableRightButtons count];
        [mutableRightButtons insertObject:[[UIBarButtonItem alloc] initWithCustomView:_spinner] atIndex:count];
        self.navigationItem.rightBarButtonItems = mutableRightButtons;
    }
    return _spinner;
}

-(void)refreshWebView
{
    //TODO : loadRequest investigation, looks like it is already an asyn method...
    [self.spinner startAnimating];
    NSLog(@"spinner started");
    NSURL *url = [NSURL URLWithString:self.recipeURL];
    NSLog(@"url %@", url);
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];

    /*
    dispatch_queue_t downloadQueue = dispatch_queue_create("downloadURL", NULL);
    dispatch_async(downloadQueue, ^{
        NSURL *url = [NSURL URLWithString:self.recipeURL];
        NSLog(@"url %@", url);
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.spinner stopAnimating];
            NSLog(@"spinner stopped");
        });
    });
     */
    
}

@end






