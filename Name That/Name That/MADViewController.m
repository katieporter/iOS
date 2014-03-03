//
//  MADViewController.m
//  Name That
//
//  Created by Katie Porter on 9/29/13.
//  Copyright (c) 2013 Katie Porter. All rights reserved.
//

#import "MADViewController.h"

@implementation MADViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Array syntax adapted from class PPT and http://rypress.com/tutorials/objective-c/data-types/nsarray.html
    self.buttonsArray = @[self.firstOptionButton, self.secondOptionButton, self.thirdOptionButton, self.fourthOptionButton];
    self.colorsArray = @[@"blue", @"green", @"orange", @"yellow", @"red", @"purple", @"black", @"pink", @"teal", @"grey"];
    
    [self resetGame];
}

- (void)resetGame
{
    // Get slider value
    NSInteger sliderValueIndex = self.colorSlider.value;
    self.sliderValue = sliderValueIndex;
    
    // Find a random button to be the correct index
    // Random number generator adapted from http://stackoverflow.com/questions/160890/generating-random-numbers-in-objective-c
    NSInteger randomButtonIndex = arc4random_uniform([self.buttonsArray count]);
    self.correctIndex = randomButtonIndex;
    
    // Find a random color to be the correct color based on slider value
    NSInteger randomColorIndex = arc4random_uniform(self.sliderValue);
    NSString *randomColor = [self.colorsArray objectAtIndex:randomColorIndex];
    self.colorImage.image = [UIImage imageNamed:randomColor];
    
    // Set the correct button title to the correct color
    UIButton *correctButton = [self.buttonsArray objectAtIndex:self.correctIndex];
    [correctButton setTitle:[randomColor capitalizedString] forState:UIControlStateNormal];
    
    // Fill in other buttons with incorrect answers
    // Modulus adapted from http://stackoverflow.com/questions/2664301/how-does-modulus-divison-work
    // Button label change adapted from http://stackoverflow.com/questions/5264546/change-button-text-from-xcode
    NSInteger buttonIndex = 0;
    NSInteger colorIndex = randomColorIndex;
    NSInteger buttonsAssigned = 0;
    while(buttonsAssigned < ([self.buttonsArray count] - 1)) {
        UIButton *currentButton = [self.buttonsArray objectAtIndex:(buttonIndex % [self.buttonsArray count])];
        if (currentButton != correctButton) {
            colorIndex++;
            NSString *currentColor = [self.colorsArray objectAtIndex:(colorIndex % self.sliderValue)];
            [currentButton setTitle:[currentColor capitalizedString] forState:UIControlStateNormal];
            buttonsAssigned++;
        }
        buttonIndex++;
    }
}

- (void)buttonPressed:(UIButton *)sender
{
    UIButton *correctButton = [self.buttonsArray objectAtIndex:self.correctIndex];
    if (sender == correctButton) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Correct!"
                                                            message:@"You chose the correct color!"
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"Next Color", nil];
        [alertView show];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Wrong!"
                                                            message:@"You chose the incorrect color."
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"Try Again", nil];
        [alertView show];
    }
}

- (IBAction)sliderMoved:(UISlider *)sender {
    // Get the color number
    int colorNumber = sender.value;
    // Change the color label
    _colorCounter.text=[NSString stringWithFormat:@"%d Colors", colorNumber];
}

- (IBAction)firstOptionButtonPressed:(UIButton *)sender
{
    [self buttonPressed:sender];
}

- (IBAction)secondOptionButtonPressed:(UIButton *)sender
{
    [self buttonPressed:sender];
}

- (IBAction)thirdOptionButtonPressed:(UIButton *)sender
{
    [self buttonPressed:sender];
}

- (IBAction)fourthOptionButtonPressed:(UIButton *)sender
{
    [self buttonPressed:sender];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self resetGame];
}

@end
