//
//  TeamCell.m
//  WorldCup
//
//  Created by hdz on 2018/6/9.
//  Copyright © 2018年 mobi.hdz. All rights reserved.
//

#import "TeamCell.h"

@implementation TeamCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)prepareForReuse{
    [super prepareForReuse];
    self.teamLabel.text = nil;
    self.scoreLabel.text = nil;
    self.flagImageView.image = nil;
    
}
@end
