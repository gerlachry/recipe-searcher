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

+(NSDictionary *)topRecipesForSearch:(NSString *)searchString withMaxResultsPerPage:(int)maxResultsPerPage startingAtItem:(int)startItemNumber
{
    int maxResults = maxResultsPerPage;
    if (!maxResults || maxResults < 1) {
        maxResults = YUMMLY_SEARCH_MAX_RESULTS;
    }
    int startItem = startItemNumber;
    if (!startItem || startItem < 1){
        startItem = YUMMLY_SEARCH_START_NUMBER;
    }
    
    NSString *query = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%d%@%d",YUMMLY_SEARCH_URL,@"app_id=",YUMMLY_APP,@"&_app_key=",YUMMLY_API_KEY,@"&q=",searchString,@"&maxResult=",maxResults,@"&start=",startItem];
    
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
    // TODO: replace hard coded url with variable, was giving error...
    NSString *query = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",@"http://api.yummly.com/v1/api/recipe/",recipeID,@"?",@"_app_id=",YUMMLY_APP,@"&_app_key=",YUMMLY_API_KEY];
    
    query = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSData *jsonData = [[NSString stringWithContentsOfURL:[NSURL URLWithString:query] encoding:NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"[%@ %@] sent %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), query);
    NSError *error = nil;
    NSDictionary *results = jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&error] : nil;
    if (error) NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);
    
    return results;
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
