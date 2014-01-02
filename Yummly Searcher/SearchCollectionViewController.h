//
//  SearchCollectionViewController.h
//  Yummly Searcher
//
//  Created by Gerlach, Ryan K on 12/19/13.
//  Copyright (c) 2013 Gerlach, Ryan K. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipeViewController.h"

@interface SearchCollectionViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, RecipeViewControllerDelegate>

@property (nonatomic, strong) NSDictionary *recipes; //array of results from search

@end
