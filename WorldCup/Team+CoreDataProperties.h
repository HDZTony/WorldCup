//
//  Team+CoreDataProperties.h
//  WorldCup
//
//  Created by hdz on 2018/6/9.
//  Copyright © 2018年 mobi.hdz. All rights reserved.
//
//

#import "Team+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Team (CoreDataProperties)

+ (NSFetchRequest<Team *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *imageName;
@property (nonatomic) int32_t losses;
@property (nullable, nonatomic, copy) NSString *qualifyingZone;
@property (nullable, nonatomic, copy) NSString *teamName;
@property (nonatomic) int32_t wins;

@end

NS_ASSUME_NONNULL_END
