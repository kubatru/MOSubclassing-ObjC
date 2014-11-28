//
//  ViewController.m
//  CoreData2
//
//  Created by Jakub Truhlar on 28.11.14.
//  Copyright (c) 2014 Jakub Truhlar. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Context from singleton
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    context = [appDelegate managedObjectContext];
    
    // Make new objects
    Worker *workerOne = [Worker insertNewObjectIntoContext:context];
    workerOne.name = @"Jakub";
    workerOne.age = [NSNumber numberWithInt:23];
    workerOne.position = @"Developer";
    
    Worker *workerTwo = [Worker insertNewObjectIntoContext:context];
    workerTwo.name = @"Petr";
    workerTwo.age = [NSNumber numberWithInt:41];
    workerTwo.position = @"Mechanic";
    
    // Save
    NSError *error;
    [context save:&error];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (IBAction)btnPressed:(id)sender {
    
    NSError *error = nil;
    
    // Show Searched
    if ([sender tag] == 1) {
        
        // Core Data - Fetch with predicate
        searchedWorker = [Worker workerWithName:@"Tereza" fromContext:context];
        
        workers = nil;
    }
    
    // Show all
    else if ([sender tag] == 2) {
        
        // Core Data - Fetch
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Worker"];
        workers = [context executeFetchRequest:request error:&error];
        
        searchedWorker = nil;
    }
    
    // Add one worker
    else {
        
        // Core Data - Make a new object
        Worker *newWorker = [Worker insertNewObjectIntoContext:context];
        newWorker.name = @"Tereza";
        newWorker.age = [NSNumber numberWithInt:23];
        newWorker.position = @"Psychologist";
        [context save:&error];
    }
    
    [self.tableView reloadData];
}

#pragma mark - TableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    // Keep it simple: When btn pressed, one of two situation: fetch one worker or all of them. When one is fill, other is set to nil.
    if (searchedWorker != nil) {
        
        cell.textLabel.text = searchedWorker.name;
        cell.detailTextLabel.text = [searchedWorker.age stringValue];
    }
    
    if (workers != nil) {
        
        Worker *worker = [workers objectAtIndex:indexPath.row];
        cell.textLabel.text = worker.name;
        cell.detailTextLabel.text = [worker.age stringValue];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (searchedWorker != nil) {
        return 1;
    }
    
    if (workers != nil) {
        return [workers count];
    }
    
    else {
        return 0;
    }
}

@end
