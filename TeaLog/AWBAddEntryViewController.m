//
//  AWBAddEntryViewController.m
//  TeaLog
//
//  Created by Andrew Braunstein on 2/28/13.
//  Copyright (c) 2013 Andrew Braunstein. All rights reserved.
//

#import "AWBAddEntryViewController.h"

@interface AWBAddEntryViewController ()

@end

@implementation AWBAddEntryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view.
  
  self.notesField.text = @"Notes";
  self.notesField.textColor = [UIColor lightGrayColor];
  self.notesField.delegate = self;
  self.nameField.delegate = self;
  
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
  [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard
{
  [self.nameField resignFirstResponder];
  [self.notesField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
  self.notesField.text = @"";
  self.notesField.textColor = [UIColor blackColor];
  return YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
  
  if(self.notesField.text.length == 0){
    self.notesField.textColor = [UIColor lightGrayColor];
    self.notesField.text = @"Notes";
    [self.notesField resignFirstResponder];
  }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  [textField resignFirstResponder];
  
  return YES;
}

- (IBAction)ratingSlider:(UISlider *)sender forEvent:(UIEvent *)event {
}

- (IBAction)brewTimeStepper:(UIStepper *)sender forEvent:(UIEvent *)event {
}

- (IBAction)submitButton:(UIButton *)sender {
}
@end
