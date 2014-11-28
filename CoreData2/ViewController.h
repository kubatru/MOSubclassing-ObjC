//
//  ViewController.h
//  CoreData2
//
//  Created by Jakub Truhlar on 28.11.14.
//  Copyright (c) 2014 Jakub Truhlar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Worker.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

{
    NSManagedObjectContext *context;
    Worker *searchedWorker;
    NSArray *workers;
}

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *position;
@property (nonatomic, strong) NSNumber *age;

// Outlets and actions
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *secondBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

- (IBAction)btnPressed:(id)sender;

@end

