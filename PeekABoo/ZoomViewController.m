//
//  ZoomViewController.m
//  PeekABoo
//
//  Created by Stephen Compton on 2/1/14.
//  Copyright (c) 2014 Stephen Compton. All rights reserved.
//

#import "ZoomViewController.h"
#import "User.h"
@import CoreData;
#import "AppDelegate.h"

@interface ZoomViewController ()

{
    NSManagedObjectContext *managedObjectContext;
    UIImageView *imageView;
    NSArray *imageViews;
    __weak IBOutlet UIScrollView *zoomScrollView;
    User *user;
    
}
@end

@implementation ZoomViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    managedObjectContext = ((AppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"foo"];
    
    [_fetchedResultsController performFetch:nil];
    _fetchedResultsController.delegate = self;

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    managedObjectContext = ((AppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext;
    
    CGFloat width = 0.0;
    
    NSData * data = [NSData dataWithContentsOfFile:user.photoURL];
    UIImage *image = [UIImage imageWithData:data];
    imageViews = @[[[UIImageView alloc]initWithImage:image]];
    
    NSLog(@"%@", user.photoURL);
                   
//                   , [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"space.jpg"]], [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Polycyclic_Aromatic_Hydrocarbons_In_Space.jpg"]]];
    
    for (UIImageView *_imageView in imageViews)
    {
        [zoomScrollView addSubview:_imageView];
        _imageView.frame = CGRectMake(width, 0, self.view.frame.size.width, self.view.frame.size.height);
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        width += _imageView.frame.size.width;
        
    }

    
    zoomScrollView.contentSize = CGSizeMake(width, zoomScrollView.frame.size.height);
    
    //    imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"fantasy_space-wide.jpg"]];
    //    [spaceScrollView addSubview:imageView];
    //    [spaceScrollView setContentOffset:CGPointMake(imageView.frame.size.width/2, imageView.frame.size.height/2)];
    //    imageView.frame = self.view.frame; //reduces the size
    //    spaceScrollView.contentSize = imageView.frame.size;
    //
    //    imageView.contentMode = UIViewContentModeScaleAspectFit;
    //    spaceScrollView.minimumZoomScale = 1.0;
    //    spaceScrollView.maximumZoomScale = 6.0;
    //    spaceScrollView.delegate = self;
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return imageView;
}


@end
