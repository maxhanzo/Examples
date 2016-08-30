//
//  ListingsTableViewController.m
//  TradeMe
//
//  Created by Max Ueda on 8/28/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "ListingsTableViewController.h"
#import "Listing.h"
#import "ListingsDetailsViewController.h"
#import "SelectedListingSharedInstance.h"
#import "DatabaseManager.h"
@interface ListingsTableViewController ()

@end

@implementation ListingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataHasBeenLoadedOnce = NO;
 
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([self.listings count]>0)
    {
        //Remove background message
        self.tableView.backgroundView = nil;
        return [self.listings count];
    }
  
    //Display a text when the UITableView has no data
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    messageLabel.text = @"Please choose an item!";
    if(self.dataHasBeenLoadedOnce)
    {
        messageLabel.text = @"Category has no data!";
    }
    
    messageLabel.textColor = [UIColor blackColor];
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont fontWithName:@"System" size:20];
    [messageLabel sizeToFit];
    
    self.tableView.backgroundView = messageLabel;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    return 0;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListingsCell" forIndexPath:indexPath];
    
    Listing *myListing = [self.listings objectAtIndex: indexPath.row];
    [cell.textLabel setText: myListing.ID];
    [cell.detailTextLabel setText: myListing.title];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Loading data to the listing of a selected category
    Listing *listing = [self.listings objectAtIndex:indexPath.row];
    SelectedListingSharedInstance *selectedListingSharedInstance = [SelectedListingSharedInstance getSharedInstance];
    [selectedListingSharedInstance setSelectedListing:listing];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}



#pragma mark - CategorySelectionDelegate
-(void)selectedCategory:(ListingCategory *)category
{
    [self.navigationItem setTitle:category.title];
    [self setListings: [DatabaseManager retrieveListingsWithCategoryID:category.ID]];
    [self.tableView reloadData];
    self.dataHasBeenLoadedOnce = YES;
    
}



@end
