//
//  ZoomViewController.h
//  PeekABoo
//
//  Created by Stephen Compton on 2/1/14.
//  Copyright (c) 2014 Stephen Compton. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZoomViewController : UIViewController <NSFetchedResultsControllerDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end
