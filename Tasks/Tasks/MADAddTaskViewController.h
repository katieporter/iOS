//
//  MADAddTaskViewController.h
//  Tasks
//
//  Created by Katie Porter on 11/10/13.
//  Copyright (c) 2013 Katie Porter. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MADTask;

@interface MADAddTaskViewController : UITableViewController <UIPickerViewDelegate>;

@property (strong, nonatomic) MADTask *task;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)dissmissKeyboard:(UITextField *)sender;

@end
