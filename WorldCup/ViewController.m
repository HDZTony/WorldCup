//
//  ViewController.m
//  WorldCup
//
//  Created by hdz on 2018/6/9.
//  Copyright © 2018年 mobi.hdz. All rights reserved.
//

#import "ViewController.h"
#import "TeamCell.h"
static  NSString *const teamCellIdentifier = @"teamCellReuseIdentifier";
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)configureTableViewCell:(TeamCell *)cell forIndexPath:(NSIndexPath *)path{
    cell.teamLabel.text = @"team";
    cell.flagImageView.backgroundColor = [UIColor redColor];
    cell.scoreLabel.text = @"f";
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TeamCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self configureTableViewCell:cell forIndexPath:indexPath];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}



@end
