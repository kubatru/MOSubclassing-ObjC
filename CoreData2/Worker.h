//
//  Worker.h
//  CoreData2
//
//  Created by Jakub Truhlar on 28.11.14.
//  Copyright (c) 2014 Jakub Truhlar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Worker : NSManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSNumber *age;
@property (nonatomic, retain) NSString *position;

+ (instancetype)insertNewObjectIntoContext:(NSManagedObjectContext *)context;
+ (Worker *)workerWithName:(NSString *)name fromContext:(NSManagedObjectContext *)context;

@end
