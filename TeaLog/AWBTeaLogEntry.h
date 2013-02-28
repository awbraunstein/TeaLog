//
//  AWBTeaLogEntry.h
//  TeaLog
//
//  Created by Andrew Braunstein on 2/28/13.
//  Copyright (c) 2013 Andrew Braunstein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface AWBTeaLogEntry : NSObject

@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSString * note;
@property (strong, nonatomic) NSNumber * brewTime;
@property (strong, nonatomic) NSNumber * rating;

@property (strong, nonatomic) NSDate * date;
@property CLLocationCoordinate2D * location;



@end
