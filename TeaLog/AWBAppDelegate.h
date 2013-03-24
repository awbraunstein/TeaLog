//
//  AWBAppDelegate.h
//  TeaLog
//
//  Created by Andrew Braunstein on 2/28/13.
//  Copyright (c) 2013 Andrew Braunstein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AWBDataManager.h"

@interface AWBAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) AWBDataManager * manager;

@end
