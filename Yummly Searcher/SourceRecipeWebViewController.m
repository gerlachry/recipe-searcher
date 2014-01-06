//
//  SourceRecipeWebViewController.m
//  Yummly Searcher
//
//  Created by Gerlach, Ryan K on 1/2/14.
//  Copyright (c) 2014 Gerlach, Ryan K. All rights reserved.
//

#import "SourceRecipeWebViewController.h"

@interface SourceRecipeWebViewController () <NSURLConnectionDataDelegate>
@property (nonatomic, strong) UIActivityIndicatorView *spinner;
@property (nonatomic, strong) NSMutableData *data;
@end

@implementation SourceRecipeWebViewController

@synthesize webView = _webView;
@synthesize recipeURL = _recipeURL;
@synthesize spinner = _spinner;
@synthesize data = _data;

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
    //self.webView.delegate = self;

}

-(NSMutableData *)data
{
    if(!_data) {
        _data = [[NSMutableData alloc] init];
    }
    return _data;
    
}

-(void)setRecipeURL:(NSString *)recipeURL
{
    _recipeURL = recipeURL;
    NSURL *url = [NSURL URLWithString:self.recipeURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.spinner startAnimating];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

- (UIActivityIndicatorView *)spinner
{
    //lazy instantiation
    if (!_spinner) {
        _spinner =[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:
                   UIActivityIndicatorViewStyleGray];
        _spinner.hidesWhenStopped=YES;
        //put spinner on navigation bar
        NSArray *rightButtons =  self.navigationItem.rightBarButtonItems;
        NSMutableArray *mutableRightButtons;
        if(rightButtons){
            mutableRightButtons = [rightButtons mutableCopy];
        } else {
            mutableRightButtons = [[NSMutableArray alloc] initWithCapacity:1];
        }
        int count = [mutableRightButtons count];
        [mutableRightButtons insertObject:[[UIBarButtonItem alloc] initWithCustomView:_spinner] atIndex:count];
        self.navigationItem.rightBarButtonItems = mutableRightButtons;
    }
    return _spinner;
}

#pragma mark NSURLConnectionDataDelegate methods

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.data appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *html = [[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
    [self.webView loadHTMLString:html baseURL:Nil];
    connection = Nil;
    [self.spinner stopAnimating];
}

@end




































