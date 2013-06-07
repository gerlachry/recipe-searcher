//
//  SearchResultsTableViewController.h
//  Yummly Searcher
//
//  Created by Gerlach, Ryan K on 6/7/13.
//  Copyright (c) 2013 Gerlach, Ryan K. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@interface SearchResultsTableViewController : CoreDataTableViewController

@property (nonatomic, strong) NSString *searchString; //search string to fetch from Yummly

@end
