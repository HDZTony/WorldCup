//
//  Team+CoreDataProperties.m
//  WorldCup
//
//  Created by hdz on 2018/6/9.
//  Copyright © 2018年 mobi.hdz. All rights reserved.
//
//

#import "Team+CoreDataProperties.h"

@implementation Team (CoreDataProperties)

+ (NSFetchRequest<Team *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Team"];
}

@dynamic imageName;
@dynamic losses;
@dynamic qualifyingZone;
@dynamic teamName;
@dynamic wins;

@end
