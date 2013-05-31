//
//  Allergy.h
//  Yummly Searcher
//
//  Created by Gerlach, Ryan K on 5/24/13.
//  Copyright (c) 2013 Gerlach, Ryan K. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Recipes;

@interface Allergy : NSManagedObject

@property (nonatomic, retain) NSNumber * allergyID;
@property (nonatomic, retain) NSString * longDesc;
@property (nonatomic, retain) NSString * shortDesc;
@property (nonatomic, retain) NSString * searchValue;
@property (nonatomic, retain) Recipes *newRelationship;

@end
