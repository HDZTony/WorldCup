//
//  TeamCell.h
//  WorldCup
//
//  Created by hdz on 2018/6/9.
//  Copyright © 2018年 mobi.hdz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *teamLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *flagImageView;

@end
