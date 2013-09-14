//
//  FrontPageViewController.m
//  petGallery
//
//  Created by mac on 7/25/13.
//  Copyright (c) 2013 bricorp. All rights reserved.
//

#import "FrontPageViewController.h"

@interface FrontPageViewController ()


@end

@implementation FrontPageViewController
int selectedTopBarQuery = 0;
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)FrontNavigationBarChange:(id)sender {
    NSInteger barnum ;
    
    barnum= self.FrontNavigationBar.selectedSegmentIndex;
    NSLog(@"retrieved bar number: %ld", (long)barnum);
    
  selectedTopBarQuery = barnum;
    
    //select query


}
- (PFQuery *)selectFrontPageQuery:(int) queryselection
{
    if(queryselection ==0)
    {
        NSLog(@"hi");
        PFUser *user = [PFUser currentUser];
        PFQuery *query = [PFQuery queryWithClassName:@"petPhoto"];
        
        //later change this to be not equal to and boolean flagged for sale.
        [query whereKey:@"status" equalTo:@"forSale"];
        
        [query whereKey:@"creator" notEqualTo:user];
        [query whereKey:@"owner" notEqualTo:user];
        [query includeKey:@"petObject"];
        [query includeKey:@"creator"];
        
        //add code to also include the pet ratings
        
        
        //need method to call to reload table
        return query;

        
        
        
    }
    
    if(queryselection ==1)
    {
        NSLog(@"2");
        PFUser *user = [PFUser currentUser];
        PFQuery *query = [PFQuery queryWithClassName:@"petPhoto"];
        
        //later change this to be not equal to and boolean flagged for sale.
        [query includeKey:@"petObject"];
        [query includeKey:@"creator"];
        
        //add code to also include the pet ratings
        
        
        //need method to call to reload table
        return query;
        
        
        
        
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString * segueName = segue.identifier;
    if ([segueName isEqualToString: @"frontpage_embed"]) {
        FrontPagePFQueryTableViewController * fpquerytable = (FrontPagePFQueryTableViewController *) [segue destinationViewController];
        
        fpquerytable.frontPageQuery= [self selectFrontPageQuery:(selectedTopBarQuery)];
        
        // do something with the AlertView's subviews here...
    }
}


@end
