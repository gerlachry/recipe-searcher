//
//  Recipes+Manage.m
//  Yummly Searcher
//
//  Created by Gerlach, Ryan K on 6/8/13.
//  Copyright (c) 2013 Gerlach, Ryan K. All rights reserved.
//

#import "Recipes+Manage.h"
#import "YummlyFetch.h"

@implementation Recipes (Manage)

+(Recipes *)recipesWithYummlyInfo:(NSDictionary *)recipe
                 inManagedContext:(NSManagedObjectContext *)context
{
    //insert to recipes table the search results to use in fetchedresultsTVC
    Recipes *recipes = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Recipes"];
    request.predicate = [NSPredicate predicateWithFormat:@"recipe = %@", [recipe valueForKeyPath:YUMMLY_ID]];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:YUMMLY_ID ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    if(error){NSLog(@"error in executesearch");}
    if (!matches || [matches count] > 1) {
        NSLog(@"error during executesearch matches check");
    } else if ([matches count] == 0) {
        //insert new recipe
        recipes.recipe = [recipe valueForKey:YUMMLY_ID];
        recipes.recipeName = [recipe valueForKey:YUMMLY_RECIPE_NAME];
        recipes.smallImageURL = [recipe valueForKey:YUMMLY_SMALL_IMAGE_URL];
        recipes.sourceDisplayName = [recipe valueForKey:YUMMLY_SOURCE_DISPLAY_NAME];
        
    } else {
        recipes = [matches lastObject];
    }
    return recipes;
    
}

@end
