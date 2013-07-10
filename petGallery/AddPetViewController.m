//
//  ViewController.m
//  petGallery
//
//  Created by mac on 6/17/13.
//  Copyright (c) 2013 bricorp. All rights reserved.
//

#import "AddPetViewController.h"
#import "Pet.h"
#import <Parse/Parse.h>
@interface AddPetViewController ()


@end

@implementation AddPetViewController
@synthesize PetName;
@synthesize PetType;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self setFirstProfileInfo];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    
    
        
        [theTextField resignFirstResponder];
        
    
    
    return YES;
   }

- (void)setFirstProfileInfo {
    // check if the user has advanced profile stats, if not create them for the current user for the first time
    //move this function to the first nib the user sees after login for the future...
    
    //check if they have a row in the player stats table...
    PFUser *user = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"UserProfile"];
    [query whereKey:@"user" equalTo:user];
    NSLog(@"Username: %@", user.objectId);
    
    
    
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!object) {
            NSLog(@"need to create a profile");
            //create first profile now
             PFUser *user = [PFUser currentUser];
            NSString *username = user.username;
            NSNumber *level = [NSNumber numberWithInt:1];
            NSNumber *currency = [NSNumber numberWithFloat:0];
            NSNumber *xp = [NSNumber numberWithFloat:0];
            
            PFObject *profileObject = [PFObject objectWithClassName:@"UserProfile"];
            [profileObject setObject:username forKey:@"Username"];
            [profileObject setObject:level forKey:@"Level"];
            [profileObject setObject:currency forKey:@"Currency"];
            [profileObject setObject:xp forKey:@"XP"];
            [profileObject setObject:user forKey:@"user"];
            
        [profileObject saveInBackground];
            
        } else {
            // The find succeeded.
            NSLog(@"Successfully retrieved the object.");
            
            
        }    }];
    
    
    
    
}





    
- (IBAction)petAdd:(id)sender
{
    Pet *newpet = [[Pet alloc] init];
    newpet.petNamec = self.PetName.text;
	 newpet.petTypec = self.PetType.text;
        newpet.petMarketThumbc = self.imageButton.currentImage;
        
        PFObject *petObject = [PFObject objectWithClassName:@"petObject"];
        [petObject setObject:newpet.petNamec forKey:@"Name"];
         [petObject setObject:newpet.petTypec forKey:@"Type"];
     PFUser *user = [PFUser currentUser];
    [petObject setObject:user forKey:@"creator"];
     [petObject setObject:@"forSale" forKey:@"status"];
    
    PFACL *petACL = [PFACL ACLWithUser:[PFUser currentUser]];
    [petACL setPublicReadAccess:YES];
    [petACL setPublicWriteAccess:YES];
    petObject.ACL = petACL;
    
         [petObject save];
       
        void (^petimguploadblock)(void);
        {
            UIImage *image =newpet.petMarketThumbc;
            
            // Resize image
            UIGraphicsBeginImageContext(CGSizeMake(640, 960));
            [image drawInRect: CGRectMake(0, 0, 640, 960)];
            UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            // Upload image
            NSData *imageData = UIImageJPEGRepresentation(image, 0.05f);
            
                    
            // Save PFFile
            PFObject *imgObject;
            // set permissions for photoobject
            PFACL *petPhotoACL = [PFACL ACLWithUser:[PFUser currentUser]];
            [petPhotoACL setPublicReadAccess:YES];
            [petPhotoACL setPublicWriteAccess:YES];
            imgObject.ACL = petPhotoACL;
            imgObject = [self uploadImage2:imageData];
            
            // Add a relation between the petobject and photo
            
            [imgObject setObject:petObject forKey:@"petObject"];
            
    }

}

- (int)magicNumber {
    
    return 42;
    
}
- (PFObject*)uploadImage2:(NSData *)imageData
{
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:imageData];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    // Set determinate mode
    HUD.mode = MBProgressHUDModeDeterminate;
    HUD.delegate = self;
    HUD.labelText = @"Uploading";
    [HUD show:YES];
    
    // Create a PFObject around a PFFile and associate it with the current user
    PFObject *userPhoto = [PFObject objectWithClassName:@"petPhoto"];
    
    // Save PFFile
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            //Hide determinate HUD
            [HUD hide:YES];
            
            // Show checkmark
            HUD = [[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:HUD];
            
            // The sample image is based on the work by http://www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
            // Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
            HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
            
            // Set custom view mode
            HUD.mode = MBProgressHUDModeCustomView;
            
            HUD.delegate = self;
            
          
            [userPhoto setObject:imageFile forKey:@"imageFile"];
            
            // Set the access control list to current user for security purposes
            PFACL *petPhotoACL = [PFACL ACLWithUser:[PFUser currentUser]];
            [petPhotoACL setPublicReadAccess:YES];
            [petPhotoACL setPublicWriteAccess:YES];
            
            userPhoto.ACL = petPhotoACL;
            
            PFUser *user = [PFUser currentUser];
            [userPhoto setObject:user forKey:@"creator"];
            [userPhoto setObject:user forKey:@"owner"];
            
            [userPhoto saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    NSLog(@"image uploaded successfully");
                }
                else{
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        }
        else{
            [HUD hide:YES];
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    } progressBlock:^(int percentDone) {
        // Update your progress spinner here. percentDone will be between 0 and 100.
        HUD.progress = (float)percentDone/100;
    }
    
     ];
    
    return userPhoto;
    
}

- (IBAction)setPetImage:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
   [self.imageButton setImage:chosenImage forState:UIControlStateNormal];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
@end
