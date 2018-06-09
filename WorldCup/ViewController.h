//
//  ViewController.h
//  WorldCup
//
//  Created by hdz on 2018/6/9.
//  Copyright © 2018年 mobi.hdz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataStack.h"
@interface ViewController : UIViewController
@property (strong, nonatomic) CoreDataStack *coreDataStack;
@property (weak, nonatomic) IBOutlet UITableView *tablewView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;

@end


