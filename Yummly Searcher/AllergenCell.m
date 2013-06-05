//
//  AllergenCell.m
//  Yummly Searcher
//
//  Created by Gerlach, Ryan K on 6/3/13.
//  Copyright (c) 2013 Gerlach, Ryan K. All rights reserved.
//

#import "AllergenCell.h"

@implementation AllergenCell

@synthesize allergenLabel = _allergenLabel;
@synthesize allergenSwitch = _allergenSwitch;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.allergenLabel.text = nil;
        self.allergenSwitch.on = NO;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)prepareForReuse
{
    [super prepareForReuse];
    self.allergenLabel = nil;
    self.allergenSwitch.on = NO;
    
}

@end
