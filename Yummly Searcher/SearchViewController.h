//
//  SearchViewController.h
//  Yummly Searcher
//
//  Created by Gerlach, Ryan K on 5/31/13.
//  Copyright (c) 2013 Gerlach, Ryan K. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *allergySearchValues; //from yummly api

@end
