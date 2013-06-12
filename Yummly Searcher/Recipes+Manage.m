//
//  Recipes+Manage.m
//  Yummly Searcher
//
//  Created by Gerlach, Ryan K on 6/8/13.
//  Copyright (c) 2013 Gerlach, Ryan K. All rights reserved.
//

#import "Recipes+Manage.h"
#import "YummlyFetch.h"
#import "Search+Manage.h"

@implementation Recipes (Manage)

+(Recipes *)recipesWithYummlyInfo:(NSDictionary *)recipe
                  forSearchString:(NSString *)searchString
                 inManagedContext:(NSManagedObjectContext *)context
{
    //insert to recipes table the search results to use in fetchedresultsTVC
    Recipes *recipes = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Recipes"];
    request.predicate = [NSPredicate predicateWithFormat:@"recipe = %@", [recipe valueForKeyPath:YUMMLY_ID]];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"recipe" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    if(error){NSLog(@"error in executesearch");}
    if (!matches || [matches count] > 1) {
        NSLog(@"error during executesearch matches check");
    } else if ([matches count] == 0) {
        //insert new recipe
        recipes = [NSEntityDescription insertNewObjectForEntityForName:@"Recipes" inManagedObjectContext:context];
        recipes.recipe = [recipe valueForKey:YUMMLY_ID];
        recipes.recipeName = [recipe valueForKey:YUMMLY_RECIPE_NAME];
        NSArray *urlArray = [recipe valueForKey:YUMMLY_SMALL_IMAGE_URL];
        if (urlArray) {
            if ([urlArray count] > 0) {
            NSString *url = [urlArray objectAtIndex:0];
            recipes.smallImageURL = url;
            }
        }
        recipes.sourceDisplayName = [recipe valueForKey:YUMMLY_SOURCE_DISPLAY_NAME];
        NSArray *course = [recipe valueForKeyPath:YUMMLY_COURSE];
        if (course) {
            if ([course count] > 0){
                recipes.course = [course objectAtIndex:0];
            }
        }
        NSArray *cuisine = [recipe valueForKeyPath:YUMMLY_CUISINE];
        if (cuisine) {
            if ([cuisine count] > 0) {
                recipes.cuisine = [cuisine objectAtIndex:0];
            }
        }
        Search *search = [Search searchWithString:searchString inManagedContext:context];
        if (search) {
            [recipes addHasSearchesObject:search];
        }
        
    } else {
        recipes = [matches lastObject];
    }
    return recipes;
    
}

@end
