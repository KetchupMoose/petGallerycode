//
//  MainLoadTabBarController.h
//  petGallery
//
//  Created by mac on 7/3/13.
//  Copyright (c) 2013 bricorp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface MainLoadTabBarController : UITabBarController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>
- (IBAction)logOutButtonTapAction:(id)sender;
@end
