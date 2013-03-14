//
//  AWBAddEntryViewController.m
//  TeaLog
//
//  Created by Andrew Braunstein on 2/28/13.
//  Copyright (c) 2013 Andrew Braunstein. All rights reserved.
//

#import "AWBAddEntryViewController.h"

@interface AWBAddEntryViewController ()
@property (strong, nonatomic) CLLocationManager *locationManager;
@property CLLocationCoordinate2D location;

@property (strong, nonatomic) NSNumber * brewTime;
@property (strong, nonatomic) NSNumber * rating;

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
  [[self.notesField layer] setBorderColor:[[UIColor grayColor] CGColor]];
  [[self.notesField layer] setBorderWidth:2.3];
  [[self.notesField layer] setCornerRadius:15];
  self.nameField.delegate = self;
  self.rating = @50;
  self.ratingLabel.text = [self.rating stringValue];
  self.brewTime = @0;
  self.brewTimeLabel.text = [[self.brewTime stringValue] stringByAppendingString:@" minutes"];
  
  if(CLLocationManager.locationServicesEnabled == NO){
    //It isn't enabled, fix in settings
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Location Services Not Enabled" message:@"Go to Settings -> Privacy and turn Location Services on to use this app." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
  } else {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
  }
  
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

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
  
  if([text isEqualToString:@"\n"]) {
    [textView resignFirstResponder];
    return NO;
  }
  
  return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  [textField resignFirstResponder];
  
  return YES;
}

- (IBAction)ratingSlider:(UISlider *)sender forEvent:(UIEvent *)event {
  self.rating = [NSNumber numberWithInt:(int)sender.value];
  self.ratingLabel.text = [self.rating stringValue];
}

- (IBAction)brewTimeStepper:(UIStepper *)sender forEvent:(UIEvent *)event {
  self.brewTime = [NSNumber numberWithInt:(int)sender.value];
  self.brewTimeLabel.text = [[self.brewTime stringValue] stringByAppendingString:@" minutes"];
}

- (IBAction)submitButton:(UIButton *)sender {
  
  NSMutableArray * log = [AWBLogSingleton sharedTeaLog].teaLog;
  AWBTeaLogEntry * entry = [[AWBTeaLogEntry alloc] init];
  entry.name = self.nameField.text;
  entry.note = self.notesField.text;
  entry.location = self.location;
  entry.brewTime = self.brewTime;
  entry.rating = self.rating;
  if ([entry.name isEqualToString:@""]) {
    entry.name = @"Untitled";
  }
  
  [log addObject: entry];
  [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
  CLLocation *location = [locations lastObject];
  self.location = location.coordinate;
}

@end
