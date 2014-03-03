//
//  MADViewController.h
//  tipcalculator-lab-05
//
//  Created by Katie Porter on 9/19/13.
//  Copyright (c) 2013 Katie Porter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController<UITextFieldDelegate, UIAlertViewDelegate>
//step one: adopt a protocol

@property (weak, nonatomic) IBOutlet UITextField *checkAmount;
@property (weak, nonatomic) IBOutlet UITextField *tipPercent;
@property (weak, nonatomic) IBOutlet UITextField *people;
@property (weak, nonatomic) IBOutlet UILabel *tipDue;
@property (weak, nonatomic) IBOutlet UILabel *totalDue;
@property (weak, nonatomic) IBOutlet UILabel *totalDuePerPerson;

//this is the public interface file, so another class can only call methods that show in here (ex. we currently can't call updateTipTotals from the MADAppDelegate)

-(void)updateTipTotals;
//not the MADAppDelegate can find it (we can access it in another class)

@end
