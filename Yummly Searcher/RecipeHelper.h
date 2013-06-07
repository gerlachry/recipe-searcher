//
//  RecipeHelper.h
//  Yummly Searcher
//
//  Created by Gerlach, Ryan K on 6/7/13.
//  Copyright (c) 2013 Gerlach, Ryan K. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^completion_block_t) (UIManagedDocument *recipeDB);

//constant for the database name to be used in the project
#define DEFAULT_RECIPE_DB_NAME @"mainRecipeDB"
//directory to store data
#define DEFAULT_DATA_DIRECTORY @"Recipes/"

@interface RecipeHelper : NSObject

+(NSString *)getCurrentDatabase;  //returns current open database

//the uimanageddocument to use for all coredata related recipe activities
// for now will only be one database
+(void) openRecipeDB:(NSString *)recipeDBName
          usingBlock:(completion_block_t)completionBlock;

@end
