//
//  Recipes.h
//  Yummly Searcher
//
//  Created by Gerlach, Ryan K on 5/24/13.
//  Copyright (c) 2013 Gerlach, Ryan K. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Allergy, Ingredients;

@interface Recipes : NSManagedObject

@property (nonatomic, retain) NSString * recipeID;
@property (nonatomic, retain) NSString * smallImageURL;
@property (nonatomic, retain) NSString * sourceDisplayName;
@property (nonatomic, retain) NSString * recipeName;
@property (nonatomic, retain) NSSet *hasIngredients;
@property (nonatomic, retain) NSSet *hasAllergyFree;
@end

@interface Recipes (CoreDataGeneratedAccessors)

- (void)addHasIngredientsObject:(Ingredients *)value;
- (void)removeHasIngredientsObject:(Ingredients *)value;
- (void)addHasIngredients:(NSSet *)values;
- (void)removeHasIngredients:(NSSet *)values;

- (void)addHasAllergyFreeObject:(Allergy *)value;
- (void)removeHasAllergyFreeObject:(Allergy *)value;
- (void)addHasAllergyFree:(NSSet *)values;
- (void)removeHasAllergyFree:(NSSet *)values;

@end
