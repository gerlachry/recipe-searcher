//
//  Recipes+Create.h
//  Yummly Searcher
//
//  Created by Gerlach, Ryan K on 5/24/13.
//  Copyright (c) 2013 Gerlach, Ryan K. All rights reserved.
//

#import "Recipes.h"

@interface Recipes (Create)

+(Recipes *)recipeWithYummlyInfo:(NSDictionary *)yummlyInfo
                inManagedContext:(NSManagedObjectContext *)context;//insert recipe,allergy,ingredients


@end
