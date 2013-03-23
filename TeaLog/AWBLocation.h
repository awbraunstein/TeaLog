//
//  AWBLocation.h
//  TeaLog
//
//  Created by Andrew Braunstein on 3/23/13.
//  Copyright (c) 2013 Andrew Braunstein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>

@class AWBTeaLogEntry;

@interface AWBLocation : NSManagedObject

@property (nonatomic) double lat;
@property (nonatomic) double lon;
@property (nonatomic, retain) AWBTeaLogEntry *entry;

- (CLLocationCoordinate2D) getLocation;

- (void) setLocationWithLocation:(CLLocationCoordinate2D)location2d;

@end
