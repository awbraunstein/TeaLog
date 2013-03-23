//
//  AWBTeaLogEntry.h
//  TeaLog
//
//  Created by Andrew Braunstein on 3/23/13.
//  Copyright (c) 2013 Andrew Braunstein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AWBLocation;

@interface AWBTeaLogEntry : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSNumber * brewTime;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) AWBLocation *location;

@end
