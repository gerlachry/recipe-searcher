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

+(Search *)executeSearchWith:(NSString *)searchString
            inManagedContext:(NSManagedObjectContext *)context
{
    Search *search = nil;
    //should i do the search in the category or in the searchTVC??
    NSDictionary *results = [YummlyFetch topRecipesForSearch:searchString];
    //trim results to exclude the header info from yummly
    NSArray *resultsTrimmed = [results objectForKey:@"matches"]; 
    NSLog(@"resultsTrimmed = %@", resultsTrimmed);
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Search"];
    request.predicate = [NSPredicate predicateWithFormat:@"searchString = %@", searchString];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"searchString" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    if(error){NSLog(@"error in executesearch");}
    
    if (!matches || [matches count] >1){
        NSLog(@"error during executesearch matches check");
    } else if ([matches count] == 0){
        //insert new search
        search.searchString = searchString;
        //insert to recipes table via category
        for (NSDictionary *dict in resultsTrimmed){
            NSLog(@"recipeID = %@", [dict valueForKeyPath:YUMMLY_ID]);
            [search addHasRecipesObject:[Recipes recipesWithYummlyInfo:dict inManagedContext:context]];
        }
        
    } else {
        //return existing search
        search = [matches lastObject];
    }
    
    return search;
}
@end
