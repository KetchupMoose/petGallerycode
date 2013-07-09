//
//  MarketplaceQueryTableViewController.h
//  petGallery
//
//  Created by mac on 6/28/13.
//  Copyright (c) 2013 bricorp. All rights reserved.
//

#import <Parse/Parse.h>
#import "BuyPetViewController.h"
@interface MarketplaceQueryTableViewController:PFQueryTableViewController <BuyPetViewControllerDelegate>

- (IBAction)refreshbutton:(id)sender;
//@property (strong, nonatomic) IBOutlet UITableView *MarketplaceTableView;

@property (nonatomic, strong) NSMutableArray *pets;
@end
