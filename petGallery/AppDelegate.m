//
//  AppDelegate.m
//  petGallery
//
//  Created by mac on 6/17/13.
//  Copyright (c) 2013 bricorp. All rights reserved.
//

#import "AppDelegate.h"
#import "Pet.h"
#import <Parse/Parse.h>
#import "MarketplaceQueryTableViewController.h"
//only importing this to try sharing data with it
#import "MarketplaceTableViewController.h"
@implementation AppDelegate
{
    NSMutableArray *pets;
    
}
@synthesize viewController = _viewController;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //set arrays up for data flows
    pets = [NSMutableArray arrayWithCapacity:20];
    //b.A. just sets initial pet.  need to investigate whether I can unset this or more smoothly load the first data on the marketplace controller.
	Pet *p1 = [[Pet alloc] init];
	p1.petNamec = @"Bill Evans";
	p1.petTypec = @"Ornella";
	[pets addObject:p1];
    
	p1.petNamec = @"BRIAN";
	p1.petTypec = @"Ornella";
	[pets addObject:p1];
    
	p1.petNamec = @"dogdog";
	p1.petTypec = @"Ornella";
	[pets addObject:p1];
    //b.a. this line ensures that the marketplace table view controller is inheriting its data from what is set on this initial file.  will have to investigate more the managing of global arrays...
   
    UITabBarController *tabBarController =
    (UITabBarController *)self.window.rootViewController;
    UINavigationController *navigationController =
    [[tabBarController viewControllers] objectAtIndex:2];
	MarketplaceQueryTableViewController *mpqtvc =
    [[navigationController viewControllers] objectAtIndex:0];
	//mptvc.pets= pets;
    // Override point for customization after application launch.
    
    

    //[mpqtvc queryForTable];
    
    
    [Parse setApplicationId:@"X6Gpdbw0LhLLUWNAkhYiRlmoZrY6HiSoRhbSfQDW"
                  clientKey:@"sQ9PGdYjUsiKsZkdr6l5pI0BSOv56teq38GG8rzI"];
    
[PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    
    
    // Wipe out old user defaults
    //
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"objectIDArray"]){
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"objectIDArray"];
    }
    
   [PFUser logOut];
   // [[NSUserDefaults standardUserDefaults] synchronize];
   
    // Simple way to create a user or log in the existing user
    // For your app, you will probably want to present your own login screen
   

        
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
