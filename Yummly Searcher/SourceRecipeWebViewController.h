//
//  SourceRecipeWebViewController.h
//  Yummly Searcher
//
//  Created by Gerlach, Ryan K on 1/2/14.
//  Copyright (c) 2014 Gerlach, Ryan K. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SourceRecipeWebViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSString * recipeURL;
@end
