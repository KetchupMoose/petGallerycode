//
// This is the template PFQueryTableViewController subclass file. Use it to customize your own subclass.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import "BuyPetViewController.h"

@interface MarketplaceQueryTableViewController : PFQueryTableViewController

@end

@implementation MarketplaceQueryTableViewController
//@synthesize MarketplaceTableView;

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom the table
        
        // The className to query on
               
        // The key of the PFObject to display in the label of the default cell style
    
        
        //[self queryForTable];
        // Uncomment the following line to specify the key of a PFFile on the PFObject to display in the imageView of the default cell style
        // self.imageKey = @"image";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 25;
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - PFQueryTableViewController

- (void)objectsWillLoad {
    [super objectsWillLoad];
    
    // This method is called before a PFQuery is fired to get more objects
}

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
    // This method is called every time objects are loaded from Parse via the PFQuery
}


// Override to customize what kind of query to perform on the class. The default is to query for
// all objects ordered by createdAt descending.
- (PFQuery *)queryForTable {
    PFUser *user = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"petPhoto"];
    
    //later change this to be not equal to and boolean flagged for sale.
    [query whereKey:@"creator" notEqualTo:user];
     [query whereKey:@"owner" notEqualTo:user];
    [query includeKey:@"petObject"];
    [query includeKey:@"creator"];
    
    //add code to also include the pet ratings
    
    [query includeKey:@"creator"];
        //need method to call to reload table
    return query;
}



 // Override to customize the look of a cell representing an object. The default is to display
 // a UITableViewCellStyleDefault style cell with the label being the textKey in the object,
 // and the imageView being the imageKey in the object.
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
 static NSString *CellIdentifier = @"marketCell";
 
 PFTableViewCell *cell = (PFTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
 if (cell == nil) {
 cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
 }
 
 // Configure the cell
 //cell.textLabel.text = [object objectForKey:self.textKey];
 //cell.imageView.file = [object objectForKey:self.imageKey];
     
     // Configure the cell...
     
  //   Pet *ptab = [self.pets objectAtIndex:indexPath.row];
     
     PFObject *petobjdata = [object objectForKey:@"petObject"];
  
     
     
     
     
     
     //gets names and types from include key on query
     UILabel *nameLabel = (UILabel *)[cell viewWithTag:1];
     nameLabel.text =    [petobjdata objectForKey:@"Name"];
     UILabel *gameLabel = (UILabel *)[cell viewWithTag:2];
     gameLabel.text =    [petobjdata objectForKey:@"Type"];

     //get owner data
      UILabel *ownerLabel = (UILabel *)[cell viewWithTag:103];
     PFObject *ownerobjdata = [object objectForKey:@"creator"];
    
     ownerLabel.text  = [ownerobjdata objectForKey:@"username"];
    
     
     //take the image data from the uiimage
     PFFile *theImage = [object objectForKey:@"imageFile"];
     NSLog(@"retrieved imageblah: %@", theImage.name);
     
     PFImageView *petimgview = (PFImageView *)[cell viewWithTag:3];
     petimgview.file = theImage;
     [petimgview loadInBackground];
 
 return cell;
 }
 

/*
 // Override if you need to change the ordering of objects in the table.
 - (PFObject *)objectAtIndex:(NSIndexPath *)indexPath {
 return [self.objects objectAtIndex:indexPath.row];
 }
 */

/*
 // Override to customize the look of the cell that allows the user to load the next page of objects.
 // The default implementation is a UITableViewCellStyleDefault cell with simple labels.
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForNextPageAtIndexPath:(NSIndexPath *)indexPath {
 static NSString *CellIdentifier = @"NextPage";
 
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
 
 if (cell == nil) {
 cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
 }
 
 cell.selectionStyle = UITableViewCellSelectionStyleNone;
 cell.textLabel.text = @"Load more...";
 
 return cell;
 }
 */

#pragma mark - UITableViewDataSource

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the object from Parse and reload the table view
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, and save it to Parse
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    //Build a segue string based on the selected cell
    NSString *segueString = [NSString stringWithFormat:@"BuyPetDetails"];
    //Since contentArray is an array of strings, we can use it to build a unique
    //identifier for each segue.
    
    //Perform a segue.
  [self performSegueWithIdentifier: @"BuyPetDetails" sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"BuyPetDetails"])
	{
		UINavigationController *navigationController =
        segue.destinationViewController;
		BuyPetViewController
        *BPViewController =
        [[navigationController viewControllers]
         objectAtIndex:0];
    
         NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *bob = [NSString stringWithFormat:@"%ld",(long)indexPath.item];
        NSLog(@"selectedindex: %@", bob);        //set the selected pet from table here
        PFObject *selectPet = [self objectAtIndexPath:indexPath];
        
		BPViewController.delegate = self;
        BPViewController.selectedPet= selectPet;
        // add method to say destination petviewcontroller equals selected PFObject
	}
}
#pragma mark - BuyPetViewControllerDelegate Methods
- (void)BuyPetViewControllerBackToMarketplace:
(BuyPetViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)refreshbutton:(id)sender {
}
@end