//
//  AWBTableViewController.m
//  TeaLog
//
//  Created by Andrew Braunstein on 2/28/13.
//  Copyright (c) 2013 Andrew Braunstein. All rights reserved.
//

#import "AWBTableViewController.h"

#define kAWBCellIdentifier @"Entry Cell"

@interface AWBTableViewController ()

@property (nonatomic, strong) NSArray * entries;
@property (nonatomic, strong) AWBDataManager * manager;

@end

@implementation AWBTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
  self = [super initWithStyle:style];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // Uncomment the following line to preserve selection between presentations.
  // self.clearsSelectionOnViewWillAppear = NO;
  
  // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
  self.navigationItem.rightBarButtonItem = self.editButtonItem;
  
  self.manager = [(AWBAppDelegate *)[[UIApplication sharedApplication] delegate] manager];
  
  self.entries = [self.manager getAllEntries];
  
  [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  // Return the number of sections.
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // Return the number of rows in the section.
  return [self.entries count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kAWBCellIdentifier];
  
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kAWBCellIdentifier];
  }
  
  cell.textLabel.text = [(AWBTeaLogEntry *)self.entries[indexPath.row] name];
  return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
  // Return NO if you do not want the specified item to be editable.
  return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView beginUpdates];
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    // Delete the row from the data source
    [self.manager deleteEntry:self.entries[indexPath.row]];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

    self.entries = [self.manager getAllEntries];
    
    [self.tableView reloadData];
  }
  else if (editingStyle == UITableViewCellEditingStyleInsert) {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
  }
  [tableView endUpdates];
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
  AWBTeaLogEntry *entryToMove = [self.entries objectAtIndex:fromIndexPath.row];
  [self.entries removeObjectAtIndex:fromIndexPath.row];
  [self.entries insertObject:entryToMove atIndex:toIndexPath.row];
  
}
*/


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
 // Return NO if you do not want the item to be re-orderable.
 return NO;
}


#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  AWBDetailViewController * detail = [segue destinationViewController];
  if ([detail view]) {
    [detail setEntry:[self.entries objectAtIndex:[self.tableView indexPathForSelectedRow].row]];
  }
}

@end
