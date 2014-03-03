//
//  MADViewController.h
//  Name That
//
//  Created by Katie Porter on 9/29/13.
//  Copyright (c) 2013 Katie Porter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADViewController : UIViewController <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *colorImage;
@property (weak, nonatomic) IBOutlet UIButton *firstOptionButton;
@property (weak, nonatomic) IBOutlet UIButton *secondOptionButton;
@property (weak, nonatomic) IBOutlet UIButton *thirdOptionButton;
@property (weak, nonatomic) IBOutlet UIButton *fourthOptionButton;

@property (weak, nonatomic) IBOutlet UISlider *colorSlider;
@property (weak, nonatomic) IBOutlet UILabel *colorCounter;
@property (assign, nonatomic) NSInteger sliderValue;

@property (strong, nonatomic) NSArray *colorsArray;
@property (strong, nonatomic) NSArray *buttonsArray;
@property (assign, nonatomic) NSInteger correctIndex;

- (IBAction)sliderMoved:(UISlider *)sender;

- (IBAction)firstOptionButtonPressed:(UIButton *)sender;
- (IBAction)secondOptionButtonPressed:(UIButton *)sender;
- (IBAction)thirdOptionButtonPressed:(UIButton *)sender;
- (IBAction)fourthOptionButtonPressed:(UIButton *)sender;

-(void)resetGame;

@end
