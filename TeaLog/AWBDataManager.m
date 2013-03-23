//
//  AWBDataManager.m
//  TeaLog
//
//  Created by Andrew Braunstein on 3/23/13.
//  Copyright (c) 2013 Andrew Braunstein. All rights reserved.
//

#import "AWBDataManager.h"

#import <CoreData/CoreData.h>
#import "AWBTeaLogEntry.h"
#import "AWBLocation.h"

#define kAWBEntryName @"AWBTeaLogEntry"
#define kAWBLocationName @"AWBLocation"
#define kAWBSaveError @"Whoops, couldn't save: %@"

@interface AWBDataManager ()
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@end

@implementation AWBDataManager


- (BOOL)addEntryWithName:(NSString *)name note:(NSString *)note brewTime:(NSNumber *)brewTime rating:(NSNumber *)rating location:(CLLocationCoordinate2D)location2d
{
  NSManagedObjectContext *context = [self managedObjectContext];
  AWBTeaLogEntry *entry = [NSEntityDescription insertNewObjectForEntityForName:kAWBEntryName inManagedObjectContext:context];
  AWBLocation * location = [NSEntityDescription insertNewObjectForEntityForName:kAWBLocationName inManagedObjectContext:context];
  
  [location setLocationWithLocation:location2d];
  
  entry.name = name;
  entry.note = note;
  entry.brewTime = brewTime;
  entry.rating = rating;
  entry.location = location;
  entry.timestamp = [NSDate date];
  NSError *error;
  if (![context save:&error]) {
    NSLog(kAWBSaveError, [error localizedDescription]);
    return NO;
  }
  return YES;
}

- (NSArray *)getAllEntries
{
  NSManagedObjectContext *context = [self managedObjectContext];
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
  NSEntityDescription *entity = [NSEntityDescription
                                 entityForName:kAWBEntryName inManagedObjectContext:context];
  
  NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                            initWithKey:@"timestamp" ascending:YES];
  [fetchRequest setSortDescriptors:@[sort]];
  [fetchRequest setEntity:entity];
  NSError *error;
  NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
  
  return fetchedObjects;
}

- (BOOL)deleteEntry:(AWBTeaLogEntry *)entry
{
  NSManagedObjectContext *context = [self managedObjectContext];
  [context deleteObject:entry];
  NSError *error;
  if (![context save:&error]) {
    NSLog(kAWBSaveError, [error localizedDescription]);
    return NO;
  }
  return YES;
}

- (BOOL)deleteAllEntries
{
  NSArray *allEntries = [self getAllEntries];
  for (AWBTeaLogEntry *entry in allEntries) {
    if (![self deleteEntry:entry]) {
      return NO;
    }
  }
  return YES;
}


#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
  if (_managedObjectContext != nil) {
    return _managedObjectContext;
  }
  
  NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
  if (coordinator != nil) {
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
  }
  return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
  if (_managedObjectModel != nil) {
    return _managedObjectModel;
  }
  NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"GoudaCD" withExtension:@"momd"];
  _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
  return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
  if (_persistentStoreCoordinator != nil) {
    return _persistentStoreCoordinator;
  }
  
  NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Ideas.sqlite"];
  
  NSError *error = nil;
  _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
  if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
    /*
     Replace this implementation with code to handle the error appropriately.
     
     abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
     
     Typical reasons for an error here include:
     * The persistent store is not accessible;
     * The schema for the persistent store is incompatible with current managed object model.
     Check the error message to determine what the actual problem was.
     
     
     If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
     
     If you encounter schema incompatibility errors during development, you can reduce their frequency by:
     * Simply deleting the existing store:
     [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
     
     * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
     [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
     
     Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
     
     */
    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    abort();
  }
  
  return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
  return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end