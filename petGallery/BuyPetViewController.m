//
//  BuyPetViewController.m
//  petGallery
//
//  Created by mac on 7/3/13.
//  Copyright (c) 2013 bricorp. All rights reserved.
//

#import "BuyPetViewController.h"
#import <Parse/Parse.h>

//need to implement delegate here
@interface BuyPetViewController ()

@end

@implementation BuyPetViewController


@synthesize delegate;
@synthesize selectedPet;
@synthesize averageRating;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    PFObject *petdataobj = [selectedPet objectForKey:@"petObject"];
    self.BuyPetNameLabel.text = [petdataobj objectForKey:@"Name"];
    self.BuyPetTypeLabel.text = [petdataobj objectForKey:@"Type"];
    
    self.BuyPetImage.file= [selectedPet objectForKey:@"imageFile"];
    
    
    //self.BuyPetRatingLabel.text = selectedPet.objectId;
    
    
    
    
  [self queryforAverageRating];
    
    
    [self.BuyPetImage loadInBackground];
}

- (void)queryforAverageRating
{
    NSString *petphotoobjectname = selectedPet.objectId;
    NSLog(@"the objectid was:", petphotoobjectname);        
   
    [PFCloud callFunctionInBackground:@"averageStars"
                       withParameters:@{@"petPhoto": petphotoobjectname}
                                block:^(NSNumber *ratings, NSError *error) {
                                    if (!error) {
                                        // ratings is 4.5
                                        NSString *myString = [ratings stringValue];
                                        self.BuyPetRatingLabel.text = myString;
                                        
                                    }
                                }];
    
    
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)BuyPetButton:(id)sender {
    //add commands to buy the pet and change backend database via parse
    PFUser *user = [PFUser currentUser];
    
    //give this user permission to change info
    
    [selectedPet setObject:user forKey:@"owner"];
    [selectedPet save];
    
}

- (IBAction)BackToMarketNavigate:(id)sender {
    
    //send user back to marketplace
    [self.delegate BuyPetViewControllerBackToMarketplace:self];
    
}
@end
