//
//  CoreDataStack.h
//  Dog Walk
//
//  Created by 何东洲 on 2018/5/16.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface CoreDataStack : NSObject
@property (nonatomic, strong)NSManagedObjectContext *managedContext;
-(instancetype)initWithModelName:(NSString *)modelName;
- (void)saveContext;
@end
