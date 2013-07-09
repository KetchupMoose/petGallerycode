//
//  AddPetViewController.h
//  petGallery
//
//  Created by mac on 6/17/13.
//  Copyright (c) 2013 bricorp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "MBProgressHUD.h"
@interface AddPetViewController : UIViewController <UITextFieldDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate, MBProgressHUDDelegate>
{
MBProgressHUD *HUD;
}
 
@property (strong, nonatomic) IBOutlet UITextField *PetName;
@property (strong, nonatomic) IBOutlet UITextField *PetType;
@property (strong, nonatomic) IBOutlet UIButton *imageButton;

- (IBAction)petAdd:(id)sender;
- (IBAction)setPetImage:(id)sender;
- (void)uploadImage:(NSData *)imageData;

@end
