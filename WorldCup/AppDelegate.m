//
//  AppDelegate.m
//  WorldCup
//
//  Created by hdz on 2018/6/9.
//  Copyright © 2018年 mobi.hdz. All rights reserved.
//

#import "AppDelegate.h"
#import "Team+CoreDataProperties.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
-(CoreDataStack *)coreDataStack{
    _coreDataStack = [[CoreDataStack alloc] initWithModelName:@"WorldCup"];
    return _coreDataStack;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self importJSONSeedDataIfNeed];
    UINavigationController *navController = (UINavigationController *)self.window.rootViewController;
    ViewController *viewController = (ViewController *) navController.topViewController;
    viewController.coreDataStack = self.coreDataStack;
    return YES;
}
-(void)applicationWillTerminate:(UIApplication *)application{
    [self.coreDataStack saveContext];
}
- (void)importJSONSeedDataIfNeed{
    NSFetchRequest<Team *> *fetchRequeat = [Team fetchRequest];
    NSUInteger count = [self.coreDataStack.managedContext countForFetchRequest:fetchRequeat error:nil];
    if (count != 0) {
        return;
    }
    [self importJSONSeedData];
}

- (void)importJSONSeedData{
    NSURL *jsonURL = [[NSBundle mainBundle] URLForResource:@"seed" withExtension:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfURL:jsonURL];
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    for (NSDictionary *jsonDictonary in jsonArray) {
        NSString *teamName = jsonDictonary[@"teamName"];
        NSString *zone = jsonDictonary[@"qualifyingZone"];
        NSString *imageName = jsonDictonary[@"imageName"];
        NSNumber *wins = jsonDictonary[@"wins"];
        //NSEntityDescription *description = [NSEntityDescription entityForName:@"Team" inManagedObjectContext:self.coreDataStack.managedContext];
        Team *team = [[Team alloc] initWithContext:self.coreDataStack.managedContext];
        team.teamName = teamName;
        team.imageName = imageName;
        team.qualifyingZone = zone;
        team.wins = wins.intValue;
    }
    [self.coreDataStack saveContext];
    NSLog(@"Imported %lu teams",(unsigned long)jsonArray.count);
    
}


@end
