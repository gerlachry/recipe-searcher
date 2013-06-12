//
//  Recipes.h
//  Yummly Searcher
//
//  Created by Gerlach, Ryan K on 6/11/13.
//  Copyright (c) 2013 Gerlach, Ryan K. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Search;

@interface Recipes : NSManagedObject

@property (nonatomic, retain) NSString * course;
@property (nonatomic, retain) NSString * cuisine;
@property (nonatomic, retain) NSString * recipe;
@property (nonatomic, retain) NSString * recipeName;
@property (nonatomic, retain) NSString * smallImageURL;
@property (nonatomic, retain) NSString * sourceDisplayName;
@property (nonatomic, retain) NSSet *hasSearches;
@end

@interface Recipes (CoreDataGeneratedAccessors)

- (void)addHasSearchesObject:(Search *)value;
- (void)removeHasSearchesObject:(Search *)value;
- (void)addHasSearches:(NSSet *)values;
- (void)removeHasSearches:(NSSet *)values;

@end
