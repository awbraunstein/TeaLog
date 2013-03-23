//
//  AWBLocation.m
//  TeaLog
//
//  Created by Andrew Braunstein on 3/23/13.
//  Copyright (c) 2013 Andrew Braunstein. All rights reserved.
//

#import "AWBLocation.h"
#import "AWBTeaLogEntry.h"


@implementation AWBLocation

@dynamic lat;
@dynamic lon;
@dynamic entry;

- (CLLocationCoordinate2D) getLocation {
  return CLLocationCoordinate2DMake(self.lat, self.lon);
}

- (void) setLocationWithLocation:(CLLocationCoordinate2D)location2d {
  self.lat = location2d.latitude;
  self.lon = location2d.longitude;
}

@end
