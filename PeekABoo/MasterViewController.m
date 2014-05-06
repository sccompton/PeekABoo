//
//  MasterViewController.m
//  PeekABoo
//
//  Created by Stephen Compton on 1/30/14.
//  Copyright (c) 2014 Stephen Compton. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
@import CoreData;
#import "User.h"
//#import "AssetsLibrary/AssetsLibrary.h"
#import "AppDelegate.h"
#import "PhotoCell.h"
#import "ZoomViewController.h"

@interface MasterViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, NSFetchedResultsControllerDelegate>

{
   //NSMutableArray *userImages;
    __weak IBOutlet UICollectionView *photoCollectionView;
   // NSMutableArray *fetchedResults;
    NSManagedObjectContext *managedObjectContext;
}

@end

@implementation MasterViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    managedObjectContext = ((AppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"foo"];
    [_fetchedResultsController performFetch:nil];
 

   NSArray *fetchedObjects = [self->managedObjectContext executeFetchRequest:request error:nil];

    _fetchedResultsController.delegate = self;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"object = %i", [_fetchedResultsController.sections[section] numberOfObjects]);
  
    return [_fetchedResultsController.sections[section] numberOfObjects];
}



//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    ZoomViewController *zoomView = segue.destinationViewController;
//    NSIndexPath *indexPath = [photoCollectionView indexPathForCell:sender];
//    zoomView.image = [fetchedResults objectAtIndex:indexPath.row];
//}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([[segue identifier] isEqualToString:@"showDetail"]) {
//        NSIndexPath *indexPath = [photoCollectionView indexPathForSelectedRow];
//        NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
//        [[segue destinationViewController] setDetailItem:object];
//    }
//}


-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
        //NSString *selectedUser = [userImages[indexPath.section] objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"ZoomSegue" sender:self];
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    User *user = _fetchedResultsController.fetchedObjects[indexPath.row];
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    
    NSData * data = [NSData dataWithContentsOfFile:user.photoURL];
    UIImage *image = [UIImage imageWithData:data];
    
    cell.imageView.image = image;
    
    return cell;
    
}

//reloads tableview everytime anything is done with the table
-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    [photoCollectionView reloadData];
}



@end
