//
//  Search.h
//  Yummly Searcher
//
//  Created by Gerlach, Ryan K on 6/8/13.
//  Copyright (c) 2013 Gerlach, Ryan K. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Recipes;

@interface Search : NSManagedObject

@property (nonatomic, retain) NSString * searchString;
@property (nonatomic, retain) NSSet *hasRecipes;
@end

@interface Search (CoreDataGeneratedAccessors)

- (void)addHasRecipesObject:(Recipes *)value;
- (void)removeHasRecipesObject:(Recipes *)value;
- (void)addHasRecipes:(NSSet *)values;
- (void)removeHasRecipes:(NSSet *)values;

@end
