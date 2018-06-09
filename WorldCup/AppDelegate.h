//
//  AppDelegate.h
//  WorldCup
//
//  Created by hdz on 2018/6/9.
//  Copyright © 2018年 mobi.hdz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CoreDataStack.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CoreDataStack *coreDataStack;



@end

