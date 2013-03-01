//
//  AWBDetailViewController.m
//  TeaLog
//
//  Created by Andrew Braunstein on 2/28/13.
//  Copyright (c) 2013 Andrew Braunstein. All rights reserved.
//

#import "AWBDetailViewController.h"

@interface AWBDetailViewController ()

@property BOOL mapLoaded;

@end

@implementation AWBDetailViewController

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
  self.notesLabel.lineBreakMode = NSLineBreakByWordWrapping;
  self.notesLabel.numberOfLines = 0;
  self.map.delegate = self;
  self.mapLoaded = NO;
  
}

-(void) viewWillAppear:(BOOL)animated {
  if (self.entry == nil) {
    NSLog(@"Nil tea entry");
  }
  
  self.navigationItem.title = self.entry.name;
  self.dateLabel.text = [self.entry.date description];
  self.notesLabel.text = self.entry.note;
  self.brewTimeLabel.text = [self.entry.brewTime stringValue];
  self.ratingLabel.text = [self.entry.rating stringValue];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
   
- (void)addPinToMapAtLocation:(CLLocationCoordinate2D)coordinate
{
  MKPointAnnotation *pin = [[MKPointAnnotation alloc] init];
  pin.coordinate = coordinate;
  [self.map addAnnotation:pin];
  MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.01, 0.01));
  self.map.region = region;
}

#pragma mark - MKMapViewDelegate methods

- (void) mapViewDidFinishLoadingMap:(MKMapView *)mapView {
  if (!self.mapLoaded) {
    [self addPinToMapAtLocation:self.entry.location];
    self.mapLoaded = YES;
  }
}

@end
