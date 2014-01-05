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
#define YUMMLY_RECIPE_URL @"http://api.yummly.com/v1/api/recipe/";
#define YUMMLY_SEARCH_MAX_RESULTS @"100";
#define YUMMLY_SEARCH_START_NUMBER @"0";
#define YUMMLY_ID @"id"
#define YUMMLY_INGREDIENTS @"ingredients"
#define YUMMLY_INGREDIENT_LINES @"ingredientLines"
#define YUMMLY_RECIPE_NAME @"recipeName"
#define YUMMLY_SMALL_IMAGE_URL @"smallImageUrls"
#define YUMMLY_SOURCE_DISPLAY_NAME @"sourceDisplayName"
#define YUMMLY_COURSE @"attributes.course"
#define YUMMLY_CUISINE @"attributes.cuisine"

//this is the value needed by yummly api when searching by allergen
#define YUMMLY_ALLERGY_SEARCH_VALUE @"searchValue"

//used in search view display
#define YUMMLY_ALLERGY_LONG @"longDescription"
#define YUMMLY_ALLERGY_ID @"id"
#define YUMMLY_ALLERGY_SWITCH @"switch"
#define YUMMLY_ALLERGY_SWITCH_ON @"ON"
#define YUMMLY_ALLERGY_SWITCH_OFF @"OFF"

@interface YummlyFetch : NSObject

+(NSDictionary *)topRecipesForSearch:(NSString *)searchString withMaxResultsPerPage:(NSString *)maxResultsPerPage startingAtItem:(NSString *)startItemNumber;//formated to Yummly, returns dictionary.  maxResultsPerPage and startItemNumber enables paging
+(NSDictionary *)recipeForID:(NSString *)recipeID; //full recipe, includes url for original site
+(NSArray *)allergySearchValues; //gets list of all allergy searchValues, use in UI

@end
