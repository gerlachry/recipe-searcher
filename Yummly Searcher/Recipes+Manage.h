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
                 inManagedContext:(NSManagedObjectContext *)context;

@end
