recipe-searcher
===============

iOS app for searching for allergy friendly recipes using the Yummly API.  Since Yummly recently came out with their own app this is just for personal educational purposes.  Just getting started both on github and objective-c.  

Added integration with Travis CI.  Build details can be found here:
https://travis-ci.org/gerlachry/recipe-searcher

When cloning need to add a YummlyAPI.h file to your local project which contains constants for your Yummly API keys.
Just update the values for YUMMLY_APP and YUMMLY_API_KEY.

Example:
```
#import <Foundation/Foundation.h>

#define YUMMLY_APP @"1234567"
#define YUMMLY_API_KEY @"xxxxxxxxxxxx"

@interface YummlyAPI : NSObject

@end
```
