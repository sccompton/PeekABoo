//
//  DetailViewController.m
//  PeekABoo
//
//  Created by Stephen Compton on 1/30/14.
//  Copyright (c) 2014 Stephen Compton. All rights reserved.
//

#import "DetailViewController.h"
#import "User.h"
@import CoreData;
#import "AppDelegate.h"

@interface DetailViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

{
    
    __weak IBOutlet UIButton *selectPhoto;
    __weak IBOutlet UITextField *nameTextField;
    __weak IBOutlet UITextField *phoneTextField;
    __weak IBOutlet UITextField *emailTextField;
    __weak IBOutlet UITextView *addressTextView;
    NSString *chosenImageURL;
    __weak IBOutlet UIImageView *thumbsNailView;
    NSManagedObjectContext *managedObjectContext;
    NSMutableArray *adoredPhotosArray;
    User *user;
    
    NSString *imageName;
}

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic) NSMutableArray *capturedImages;


@end

@implementation DetailViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    managedObjectContext = ((AppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext;
    [self configureView];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
//    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
//    self.imageView.image = chosenImage;
//    [picker dismissViewControllerAnimated:YES completion:NULL];
//    chosenImageURL = [info objectForKey:UIImagePickerControllerReferenceURL];

    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    [selectPhoto setBackgroundImage:image forState:UIControlStateNormal];
    [selectPhoto setTitle:@"" forState:UIControlStateNormal];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *fileLists = [fileManager contentsOfDirectoryAtPath:path error:nil];
    int totalCount = 0;
    for (NSString *fileName in fileLists)
    {
        if([[fileName lastPathComponent] hasPrefix:@"image_"]){
            totalCount++;
        }
        NSLog(@"%@",fileLists);
    }
    
    imageName = [NSString stringWithFormat:@"%@/image_%i", path, totalCount];
    [imageData writeToFile:imageName atomically:YES];
    
    thumbsNailView.image = image;
    

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}



//-(void)save{
//    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
//    NSURL *photo = [[self documentsDirectory] URLByAppendingPathComponent:@"photo"];
//    [adoredPhotosArray writeToURL:plist atomically:YES];
//    NSLog(@"plist = %@", photo);
//    
//    [userDefaults setObject:[NSDate date] forKey:@"Last saved"];
//    [userDefaults synchronize];
//}
//
//-(void)load{
//    NSURL *photo = [[self documentsDirectory] URLByAppendingPathComponent:@"pastes.plist"];
//    adoredToothpastesArray = [NSMutableArray arrayWithContentsOfURL:plist] ?: [NSMutableArray new];
//}
//
//-(NSURL *)documentsDirectory{
//    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentationDirectory inDomains:NSUserDomainMask] firstObject];
//}


- (IBAction)onUserAdded:(id)sender {

    user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:managedObjectContext];
    user.name = nameTextField.text;
    user.phone = phoneTextField.text;
    user.email = emailTextField.text;
    user.address = addressTextView.text;
    
    user.photoURL = imageName;
    //NSLog(@"filepath: %@", imageName);
    
    //user.photoURL = chosenImageURL;
    [user.managedObjectContext save:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
    
   NSLog(@"URL should follow: %@", user.photoURL);
    
//    [nameTextField resignFirstResponder];
//    [phoneTextField resignFirstResponder];
//    [emailTextField resignFirstResponder];
//    [addressTextView resignFirstResponder];
//    
//    [self.view endEditing:YES];
    
}


- (IBAction)selectPhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    [self presentViewController:picker animated:YES completion:NULL];
}



- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"timeStamp"] description];
    }
}



@end
