//
//  Search+Manage.m
//  Yummly Searcher
//
//  Created by Gerlach, Ryan K on 6/7/13.
//  Copyright (c) 2013 Gerlach, Ryan K. All rights reserved.
//

#import "Search+Manage.h"
#import "YummlyFetch.h"

@implementation Search (Manage)

+(Search *)executeSearchWith:(NSString *)searchString
            inManagedContext:(NSManagedObjectContext *)context
{
    Search *search = nil;
    NSDictionary *results = [YummlyFetch topRecipesForSearch:searchString];
    NSArray *resultsTrimmed = [results objectForKey:@"matches"];
    //NSLog(@"resultsTrimmed = %@", resultsTrimmed);
    for (NSDictionary *dict in resultsTrimmed) {
        NSLog(@"recipe name = %@", [dict valueForKeyPath:YUMMLY_RECIPE_NAME]);
    }
    return search;
}
@end
