//
//  MADTasksViewController.m
//  Tasks
//
//  Created by Katie Porter on 11/10/13.
//  Copyright (c) 2013 Katie Porter. All rights reserved.
//

#import "MADTasksViewController.h"
#import "MADAddTaskViewController.h"
#import "MADAppDelegate.h"
#import "MADTask.h"
#import <QuartzCore/QuartzCore.h>

@interface MADTasksViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, assign) BOOL animating;

@end

@implementation MADTasksViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.animating = NO;
    
    // Read about core data fetch requests here: https://developer.apple.com/library/mac/documentation/cocoa/conceptual/coredata/Articles/cdFetching.html#//apple_ref/doc/uid/TP40002484-SW1
    MADAppDelegate *applicationDelegate = [UIApplication sharedApplication].delegate;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Task"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"dueDate" ascending:YES]];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                        managedObjectContext:[applicationDelegate managedObjectContext]
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    self.fetchedResultsController.delegate = self;
    
    NSError *error = nil;
    if([self.fetchedResultsController performFetch:&error]) {
        [self.tableView reloadData];
    }

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSFetchedResultsControllerDelegate

// Reload the table if it is not deleting a task
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    if (!self.animating) {
        [self.tableView reloadData];
    }
}

#pragma mark - Table view data source

// Only one section for now
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// Set the number of rows to the number of tasks stored in core data
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.fetchedResultsController.fetchedObjects count];
}

// Show task names stored in core data in cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TaskCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    MADTask *task = [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.row];
    
    // Show task name in cell
    cell.textLabel.text = task.name;
    
    // Show due date in right detail
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"M/d hh:mm aa"];
    NSString *prettyDate = [dateFormat stringFromDate:task.dueDate];
    cell.detailTextLabel.text = prettyDate;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// Read about transition code here: https://developer.apple.com/library/ios/documentation/GraphicsImaging/Reference/CATransaction_class/Introduction/Introduction.html
// Wrap this code in CATransations to make the automatic animation when user deletes a task
// Switch statement syntax: http://www.techotopia.com/index.php/The_Objective-C_switch_Statement
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (editingStyle) {
        case UITableViewCellEditingStyleDelete: {
            self.animating = YES;
            [CATransaction begin];
            [tableView beginUpdates];
            MADTask *task = [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.row];
            MADAppDelegate *applicationDelegate = [UIApplication sharedApplication].delegate;
            [applicationDelegate.managedObjectContext deleteObject:task];
            NSError *error = nil;
            if ([applicationDelegate.managedObjectContext save:&error]) {
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            [tableView endUpdates];
            [CATransaction setCompletionBlock:^{
                self.animating = NO;
            }];
            [CATransaction commit];
            break;
        }
        default:
            break;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"EditSegue"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        MADAddTaskViewController *addTaskViewController = [navigationController.viewControllers objectAtIndex:0];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        MADTask *task = [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.row];
        addTaskViewController.task = task;
    }
}

@end
