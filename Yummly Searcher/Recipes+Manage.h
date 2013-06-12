//
//  Recipes+Manage.h
//  Yummly Searcher
//
//  Created by Gerlach, Ryan K on 6/8/13.
//  Copyright (c) 2013 Gerlach, Ryan K. All rights reserved.
//

#import "Recipes.h"

@interface Recipes (Manage)

+(Recipes *)recipesWithYummlyInfo:(NSDictionary *)recipe
                  forSearchString:(NSString *)searchString
                 inManagedContext:(NSManagedObjectContext *)context;//add new recipes from search results

@end
