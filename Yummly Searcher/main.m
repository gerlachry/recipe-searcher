//
//  main.m
//  Yummly Searcher
//
//  Created by Gerlach, Ryan K on 4/27/13.
//  Copyright (c) 2013 Gerlach, Ryan K. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "YummlyFetch.h"

int main(int argc, char *argv[])
{
    
    //NSLog(@"yummly allergy searchValues = %@", [YummlyFetch allergySearchValues]);
    
    //NSLog(@"yummly response = %@",[YummlyFetch topRecipesForSearch:@"french bread&allowedAllergy[]=393^Gluten-Free"]);
    
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
