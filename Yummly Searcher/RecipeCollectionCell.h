//
//  RecipeCollectionCell.h
//  Yummly Searcher
//
//  Created by Gerlach, Ryan K on 12/20/13.
//  Copyright (c) 2013 Gerlach, Ryan K. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeCollectionCell : UICollectionViewCell

@property (nonatomic, strong) IBOutlet UILabel *recipeName;
@property (nonatomic, strong) IBOutlet UILabel *ingredients;

@end
