//
//  MasterViewController.h
//  PeekABoo
//
//  Created by Stephen Compton on 1/30/14.
//  Copyright (c) 2014 Stephen Compton. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
