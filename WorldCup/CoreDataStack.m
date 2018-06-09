//
//  CoreDataStack.m
//  Dog Walk
//
//  Created by 何东洲 on 2018/5/16.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "CoreDataStack.h"
@interface CoreDataStack()
@property (nonatomic, copy) NSString *modelName;
@property (nonatomic, strong) NSPersistentContainer *persistentContainer;
@end
@implementation CoreDataStack

#pragma mark - Core Data stack

//@synthesize persistentContainer = _persistentContainer;
-(NSPersistentContainer *)storeContainer{
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:_modelName];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    return _persistentContainer;
}
-(NSManagedObjectContext *)managedContext{
    if (!_managedContext) {
        _managedContext = _persistentContainer.viewContext;
    }
    return _managedContext;
}
- (instancetype)initWithModelName:(NSString *)modelName
{
    self = [super init];
    if (self) {
        _modelName = modelName;
    }
    return self;
}
#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}
@end
