//
//  Worker.m
//  CoreData2
//
//  Created by Jakub Truhlar on 28.11.14.
//  Copyright (c) 2014 Jakub Truhlar. All rights reserved.
//

#import "Worker.h"


@implementation Worker

@dynamic name;
@dynamic age;
@dynamic position;

+ (NSString *)entityName
{
    return @"Worker";
}

+ (instancetype)insertNewObjectIntoContext:(NSManagedObjectContext *)context
{
    return [NSEntityDescription insertNewObjectForEntityForName:[self entityName]
                                         inManagedObjectContext:context];
}

// Fetch with predicate
+ (Worker *)workerWithName:(NSString *)name fromContext:(NSManagedObjectContext *)context
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", name];
    
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    
    Worker *worker = [Worker fetchManagedObjectWithEntityName:[self entityName] Predicate:predicate SortDesc:sortDescriptors FromContext:context];
    
    return worker;
}

+ (Worker *)fetchManagedObjectWithEntityName:(NSString *)entityName Predicate:(NSPredicate *)predicate SortDesc:(NSArray *)sortDescriptors FromContext:(NSManagedObjectContext *)moc {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:entityName];
    
    // Add a sort descriptor.
    [fetchRequest setSortDescriptors:sortDescriptors];
    fetchRequest.predicate = predicate;
    
    NSError *error;
    NSArray *fetchResults = [moc executeFetchRequest:fetchRequest error:&error];
    
    if (fetchResults == nil) {
        
        // Handle the error.
        NSLog(@"executeFetchRequest failed with error: %@", [error localizedDescription]);
    }
    
    Worker *managedObject = nil;
    
    // Record exists
    if (fetchResults && [fetchResults count] > 0) {
        
        managedObject = [fetchResults objectAtIndex:0];
    }
    
    return managedObject;	
}

@end
