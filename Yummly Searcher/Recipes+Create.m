//
//  Recipes+Create.m
//  Yummly Searcher
//
//  Created by Gerlach, Ryan K on 5/24/13.
//  Copyright (c) 2013 Gerlach, Ryan K. All rights reserved.
//

#import "Recipes+Create.h"
#import "YummlyFetch.h"

@implementation Recipes (Create)

+(Recipes *)recipeWithYummlyInfo:(NSDictionary *)yummlyInfo
                inManagedContext:(NSManagedObjectContext *)context
{
    Recipes *recipe = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Recipes"];
    request.predicate = [NSPredicate predicateWithFormat:@"id = %@",[yummlyInfo objectForKey:YUMMLY_ID]];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"recipeName" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    if(error){NSLog(@"error in recipes+create");}
    
    if (!matches || [matches count] > 1){
        //error, id is PK
    } else if ([matches count] == 0){
        //insert new recipe
        
    } else {
        //recipe already in coredata
        recipe = [matches lastObject];
    }
    
    return recipe;
    
}

@end
