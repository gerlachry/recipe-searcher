//
//  YummlyFetch.h
//  Yummly Searcher
//
//  Created by Gerlach, Ryan K on 4/27/13.
//  Copyright (c) 2013 Gerlach, Ryan K. All rights reserved.
//

// APIs for interacting with Yummly, need app and app key in YummlyAPI.h
#import <Foundation/Foundation.h>

#define YUMMLY_SEARCH_URL @"http://api.yummly.com/v1/api/recipes?_"
#define YUMMLY_ALLERGY_URL @"http://api.yummly.com/v1/api/metadata/allergy?_"
#define YUMMLY_ID @"id"
#define YUMMLY_INGREDIENTS @"ingredients"
#define YUMMLY_RECIPE_NAME @"recipeName"
#define YUMMLY_SMALL_IMAGE_URL @"smallImageUrls"
#define YUMMLY_SOURCE_DISPLAY_NAME @"sourceDisplayName"
#define YUMMLY_ALLERGY_LONG @"longDescription"
#define YUMMLY_ALLERGY_ID @"id"

@interface YummlyFetch : NSObject

+(NSDictionary *)topRecipesForSearch:(NSString *)searchString;//formated to Yummly
+(NSDictionary *)recipeForID:(NSString *)recipeID; //full recipe, includes url for original site
+(NSArray *)allergySearchValues; //gets list of all allergy searchValues, use in UI

@end
