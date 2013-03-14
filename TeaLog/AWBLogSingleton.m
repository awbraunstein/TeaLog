//
//  AWBLogSingleton.m
//  TeaLog
//
//  Created by Andrew Braunstein on 3/1/13.
//  Copyright (c) 2013 Andrew Braunstein. All rights reserved.
//

#import "AWBLogSingleton.h"

@implementation AWBLogSingleton

- (id)init {
  self = [super init];
  if (self) {
    self.teaLog = [[NSMutableArray alloc] init];
  }
  return self;
}

+ (AWBLogSingleton *) sharedTeaLog {
  static AWBLogSingleton *sharedInstance;
  @synchronized(self) {
    if (!sharedInstance) {
      sharedInstance = [[AWBLogSingleton alloc] init];
    }
  }
  return sharedInstance;
  
}

@end
