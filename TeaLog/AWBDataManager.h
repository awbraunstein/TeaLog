//
//  AWBDataManager.h
//  TeaLog
//
//  Created by Andrew Braunstein on 3/23/13.
//  Copyright (c) 2013 Andrew Braunstein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class AWBTeaLogEntry;
@class AWBLocation;
@interface AWBDataManager : NSObject

- (BOOL)addEntryWithName:(NSString *)name note:(NSString *)note brewTime:(NSNumber *)brewTime rating:(NSNumber *)rating location:(CLLocationCoordinate2D)location2d;
- (NSArray *)getAllEntries;
- (BOOL)deleteEntry:(AWBTeaLogEntry *)entry;
- (BOOL)deleteAllEntries;

@end
