//
//  AWBLogSingleton.h
//  TeaLog
//
//  Created by Andrew Braunstein on 3/1/13.
//  Copyright (c) 2013 Andrew Braunstein. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AWBLogSingleton : NSObject

@property (nonatomic, retain) NSMutableArray * teaLog;

+ (AWBLogSingleton *)sharedTeaLog;

@end
