//
//  BuyPetViewController.h
//  petGallery
//
//  Created by mac on 7/3/13.
//  Copyright (c) 2013 bricorp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@class BuyPetViewController;

@protocol BuyPetViewControllerDelegate <NSObject>
- (void)BuyPetViewControllerBackToMarketplace:
(BuyPetViewController *)controller;
- (void)BuyPetViewViewController:
(BuyPetViewController *)controller
                       BuyPet:(PFObject *)PetBought;
@end

@interface BuyPetViewController : UIViewController
@property (nonatomic, weak) PFObject *selectedPet;
@property (nonatomic, weak) NSNumber *averageRating;
@property (nonatomic, weak) id <BuyPetViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UILabel *BuyPetNameLabel;


@property (strong, nonatomic) IBOutlet PFImageView *BuyPetImage;

@property (strong, nonatomic) IBOutlet UILabel *BuyPetTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *BuyPetRatingLabel;
- (IBAction)BuyPetButton:(id)sender;

- (IBAction)BackToMarketNavigate:(id)sender;


@end
