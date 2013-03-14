//
//  AWBAddEntryViewController.h
//  TeaLog
//
//  Created by Andrew Braunstein on 2/28/13.
//  Copyright (c) 2013 Andrew Braunstein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h> 
#import "AWBTeaLogEntry.h"
#import "AWBLogSingleton.h"

@interface AWBAddEntryViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate, CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextView *notesField;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *brewTimeLabel;
- (IBAction)ratingSlider:(UISlider *)sender forEvent:(UIEvent *)event;
- (IBAction)brewTimeStepper:(UIStepper *)sender forEvent:(UIEvent *)event;
- (IBAction)submitButton:(UIButton *)sender;


@end
