//
//  Search+Manage.m
//  Yummly Searcher
//
//  Created by Gerlach, Ryan K on 6/7/13.
//  Copyright (c) 2013 Gerlach, Ryan K. All rights reserved.
//

#import "Search+Manage.h"
#import "YummlyFetch.h"
#import "Recipes+Manage.h"

@implementation Search (Manage)

+(Search *)searchWithString:(NSString *)searchString
           inManagedContext:(NSManagedObjectContext *)context
{
    Search *search = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Search"];
    request.predicate = [NSPredicate predicateWithFormat:@"searchString = %@", searchString];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"searchString" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    if(error){NSLog(@"error in searchWithString");}
    if (!matches || [matches count] > 1) {
        NSLog(@"error in database for search table");
    } else if ([matches count] == 0) {
        //insert new search
        search = [NSEntityDescription insertNewObjectForEntityForName:@"Search" inManagedObjectContext:context];
        search.searchString = searchString;
    } else {
        search = [matches lastObject];
    }
    
    return search;
}

@end
