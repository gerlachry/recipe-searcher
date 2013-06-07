//
//  RecipeHelper.m
//  Yummly Searcher
//
//  Created by Gerlach, Ryan K on 6/7/13.
//  Copyright (c) 2013 Gerlach, Ryan K. All rights reserved.
//

#import "RecipeHelper.h"


@implementation RecipeHelper

static UIManagedDocument *recipeDatabase;

+(NSURL *) getDatabaseDirectory
{
    //get the recipes directory in the documents directory, create one if does not exist already
    NSURL *documents = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *vacationsDirectory = [documents URLByAppendingPathComponent:DEFAULT_DATA_DIRECTORY];
    if (![[NSFileManager defaultManager] fileExistsAtPath:vacationsDirectory.path]){
        //create it
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:vacationsDirectory.path withIntermediateDirectories:NO attributes:nil error:&error];
        if(error){
            NSLog(@"error createing recipes directory!");
        }
    }
    return vacationsDirectory;
}

+(NSString *)getCurrentDatabase
{
    NSString *current = [recipeDatabase.fileURL lastPathComponent];
    if(!current) current = DEFAULT_RECIPE_DB_NAME;
    return current;
    
}

+(void)openDatabase:(NSString *)recipeDBName usingBlock:(completion_block_t)completionBlock
{
    //initializes vacation database
    NSURL *recipeNameURL = [[self getDatabaseDirectory] URLByAppendingPathComponent:recipeDBName];
    UIManagedDocument *database = [[UIManagedDocument alloc] initWithFileURL:recipeNameURL];
    NSLog(@"database = %@",database);
    //prepare database for use
    if(![[NSFileManager defaultManager] fileExistsAtPath:database.fileURL.path]){
        //need to create on disk
        [database saveToURL:database.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success){
            recipeDatabase = database;
            completionBlock(recipeDatabase);
        }];
    } else if(database.documentState == UIDocumentStateClosed){
        [database openWithCompletionHandler:^(BOOL success){
            recipeDatabase = database;
            completionBlock(recipeDatabase);
        }];
    } else if(database.documentState == UIDocumentStateNormal){
        recipeDatabase = database;
        completionBlock(recipeDatabase);
    }
    
}

+(void) openRecipeDB:(NSString *)recipeDBName
          usingBlock:(completion_block_t)completionBlock
{
    //only have one database for now, reusing code from class
    NSLog(@"recipeDatabase = %@", recipeDatabase);
    if([recipeDBName isEqualToString:[recipeDatabase.fileURL lastPathComponent]]){
        //use current vacation
        NSLog(@"using current");
        completionBlock(recipeDatabase);
    } else if (recipeDatabase){
        //different from current, close existing and open new one, should not happen in this project
        NSLog(@"switch");
        [recipeDatabase closeWithCompletionHandler:^(BOOL success){
            recipeDatabase = nil;
            [self openDatabase:recipeDBName usingBlock:completionBlock];
        }];
    } else {
        //no current database just open new one
        NSLog(@"brand new");
        [self openDatabase:recipeDBName usingBlock:completionBlock];
    }
     
    
}
@end
