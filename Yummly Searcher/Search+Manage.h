//
//  Search+Manage.h
//  Yummly Searcher
//
//  Created by Gerlach, Ryan K on 6/7/13.
//  Copyright (c) 2013 Gerlach, Ryan K. All rights reserved.
//

#import "Search.h"

@interface Search (Manage)

+(Search *)executeSearchWith:(NSString *)searchString
            inManagedContext:(NSManagedObjectContext *)context;  //save search to coredata, call yummly, parse results to coredata

@end
