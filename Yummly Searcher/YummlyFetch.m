//
//  YummlyFetch.m
//  Yummly Searcher
//
//  Created by Gerlach, Ryan K on 4/27/13.
//  Copyright (c) 2013 Gerlach, Ryan K. All rights reserved.
//

#import "YummlyFetch.h"
#import "YummlyAPI.h"

@implementation YummlyFetch

+(NSDictionary *)topRecipesForSearch:(NSString *)searchString;
{

    NSString *query = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",YUMMLY_SEARCH_URL,@"app_id=",YUMMLY_APP,@"&_app_key=",YUMMLY_API_KEY,@"&q=",searchString];
    
    query = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSData *jsonData = [[NSString stringWithContentsOfURL:[NSURL URLWithString:query] encoding:NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"[%@ %@] sent %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), query);
    NSError *error = nil;
    NSDictionary *results = jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&error] : nil;
    if (error) NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);
    //NSLog(@"[%@ %@] received %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), results);
    
    return results;
    
}

+(NSDictionary *)recipeForID:(NSString *)recipeID
{
    //TODO :implement get one recipe
    NSDictionary *recipe = nil;
    return recipe;
    
}

+(NSArray *)allergySearchValues
{
    NSArray *searchValues = nil;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@%@%@",YUMMLY_ALLERGY_URL,@"app_id=",YUMMLY_APP,@"&_app_key=",YUMMLY_API_KEY]];
    NSLog(@"url= %@",url);
    NSString *jsonpData = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    //response is jsonp, need to ignore below leading and trailing characters to get json
    //   set_metadata('allergy',
    //   );
    jsonpData = [jsonpData substringFromIndex:23];
    jsonpData = [jsonpData substringToIndex:[jsonpData length]-2];
    NSData *jsonData = [jsonpData dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    searchValues = jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&error] : nil;
    if (error) NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);
    //NSLog(@"results = %@", [searchValues valueForKeyPath:@"all"]);
    //returning only the array for all locales
    return [searchValues valueForKeyPath:@"all"];
    
}


@end
