//
//  Search+Manage.h
//  Yummly Searcher
//
//  Created by Gerlach, Ryan K on 6/7/13.
//  Copyright (c) 2013 Gerlach, Ryan K. All rights reserved.
//

#import "Search.h"

@interface Search (Manage)

+(Search *)searchWithString:(NSString *)searchString
                 inManagedContext:(NSManagedObjectContext *)context;

@end
