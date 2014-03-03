//
//  MADTaskInfoViewController.h
//  Tasks
//
//  Created by Katie Porter on 12/13/13.
//  Copyright (c) 2013 Katie Porter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADTaskInfoViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel *taskDueDate;
@property (copy, nonatomic) NSString *dueDate;

@end
