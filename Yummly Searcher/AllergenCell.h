//
//  AllergenCell.h
//  Yummly Searcher
//
//  Created by Gerlach, Ryan K on 6/3/13.
//  Copyright (c) 2013 Gerlach, Ryan K. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllergenCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *allergenLabel;
@property (nonatomic, strong) IBOutlet UISwitch *allergenSwitch;

@end
