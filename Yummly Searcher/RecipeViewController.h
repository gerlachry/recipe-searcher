//
//  RecipeViewController.h
//  Yummly Searcher
//
//  Created by Gerlach, Ryan K on 12/24/13.
//  Copyright (c) 2013 Gerlach, Ryan K. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RecipeViewController;
@protocol RecipeViewControllerDelegate <NSObject>

-(void)selectedSourceRecipe:(NSDictionary *)recipe with:(RecipeViewController *)sender;
@end
@interface RecipeViewController : UIViewController

@property (nonatomic, strong) NSDictionary *recipe;
@property (nonatomic, weak) id<RecipeViewControllerDelegate> delegate;
@end
