recipe-searcher
===============

iOS app for searching for allergy friendly recipes using the Yummly API

Just getting started both on github and objective-c.  Idea is to create a universal app for searching allergy friendly recipes.

When cloning need to add a YummlyAPI.h file to your local project which contains constants for your Yummly API keys.


Example:

#import <Foundation/Foundation.h>

#define YUMMLY_APP @"1234567"
#define YUMMLY_API_KEY @"xxxxxxxxxxxx"

@interface YummlyAPI : NSObject

@end
