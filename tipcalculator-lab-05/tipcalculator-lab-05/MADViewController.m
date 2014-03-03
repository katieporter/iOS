//
//  MADViewController.m
//  tipcalculator-lab-05
//
//  Created by Katie Porter on 9/19/13.
//  Copyright (c) 2013 Katie Porter. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController ()

@end

@implementation MADViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _checkAmount.delegate=self;
    _tipPercent.delegate=self;
    _people.delegate=self;
    //step three: we have assigned the delegate
    //self refers to wherever you are; whatever is currently running
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
    //this is a BOOL because it should return yes or no
}
//step two: we have implemented a method (all are optional for this protocol)

-(void)updateTipTotals {
    //get the values from the text fields
    //floatValue returns a float, intValue returns an int
    float amount=[_checkAmount.text floatValue];
    float pct=[_tipPercent.text floatValue];
    int numberOfPeople=[_people.text intValue];
    
    //convert to a fraction
    pct=pct/100;
    
    //compute the totals
    float tip=amount*pct;
    float total=amount+tip;
    float personTotal=0;
    
    //handles divide by zero error
    if (numberOfPeople>0) {
        personTotal=total/numberOfPeople;
    }
    //alert will show if numberOfPeople is 0
    else {
        UIAlertView *alertView=[[UIAlertView alloc]
                                initWithTitle:@"Warning"
                                message:@"The number of people must be greater than 0"
                                delegate:self
                                cancelButtonTitle:@"Cancel"
                                otherButtonTitles:@"OK", nil]; //list must always end in nil
        [alertView show];
    }
    
    //use NSNumberFormatter to set the format style to currency
    NSNumberFormatter *currencyFormatter=[[NSNumberFormatter alloc]init];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    //update the labels
    //stringFromNumber; generates strings
    _tipDue.text=[currencyFormatter stringFromNumber:[NSNumber numberWithFloat:tip]];
    _totalDue.text=[currencyFormatter stringFromNumber:[NSNumber numberWithFloat:total]];
    _totalDuePerPerson.text=[currencyFormatter stringFromNumber:[NSNumber numberWithFloat:personTotal]];
    
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex==1) { //OK button
        _people.text=[NSString stringWithFormat:@"1"];
        [self updateTipTotals];
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField {
    [self updateTipTotals];
    //void means it doesn't return anything
}

@end
