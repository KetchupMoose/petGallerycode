//
//  FrontPageViewController.h
//  petGallery
//
//  Created by mac on 7/25/13.
//  Copyright (c) 2013 bricorp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FrontPagePFQueryTableViewController.h"

//brian.  I think I have to do something like set the query property of the data table as an accessible property and then re-set it from outside of the class.  The goal is to have the table change its results depending on the navigation selection

@interface FrontPageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *FrontNavigationBar;
- (IBAction)FrontNavigationBarChange:(id)sender;



@end
