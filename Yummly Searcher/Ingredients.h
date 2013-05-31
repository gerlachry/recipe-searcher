//
//  Ingredients.h
//  Yummly Searcher
//
//  Created by Gerlach, Ryan K on 5/24/13.
//  Copyright (c) 2013 Gerlach, Ryan K. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Recipes;

@interface Ingredients : NSManagedObject

@property (nonatomic, retain) NSString * ingredient;
@property (nonatomic, retain) Recipes *newRelationship;

@end
