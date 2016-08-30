//
//  CategoriesTableViewController.m
//  TradeMe
//
//  Created by Max Ueda on 8/28/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "CategoriesTableViewController.h"
#import "ListingsTableViewController.h"
#import "APIOperationsManager.h"
#import "DatabaseManager.h"


//Remove afterwards
#import "Listing.h"

@interface CategoriesTableViewController ()

@end

@implementation CategoriesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //Loading data
    [self retrieveCategories];
    
    //Pull refresh stuff
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor lightGrayColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(refreshAll)
                  forControlEvents:UIControlEventValueChanged];
    

       
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if([self.categoriesArray count]>0)
    {
        //Remove background message
        self.tableView.backgroundView = nil;
        return 1;
    }
    
    //Display a text while data is being loaded
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    messageLabel.text = @"Loading data, please wait!";
    messageLabel.textColor = [UIColor blackColor];
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont fontWithName:@"System" size:20];
    [messageLabel sizeToFit];
    
    self.tableView.backgroundView = messageLabel;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.categoriesArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    ListingCategory *currentCategory = (ListingCategory*)[self.categoriesArray objectAtIndex:indexPath.row];
    if(currentCategory)
    {
        [cell.textLabel setText: currentCategory.title];
    }
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Loading data to the listing of a selected category
    ListingCategory *category = [self.categoriesArray objectAtIndex:indexPath.row];
    if (_delegate) {
        if(category){
            [_delegate selectedCategory:category];
            
            //To make it work on iPhones (due to Navigation Stack). Without this, Back button disappears.
            ListingsTableViewController *detailsViewController = (ListingsTableViewController*) self.delegate;
            
            if(detailsViewController){
                [self.splitViewController showDetailViewController: detailsViewController.navigationController sender: nil];
            }
            
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Networking operations
-(void) retrieveCategories
{
    self.categoriesArray = [DatabaseManager retrieveListingCategories];
    if(!([self.categoriesArray count]>0))
    {
        APIOperationsManager *apiOperationsManager = [APIOperationsManager getSharedInstance];
        [apiOperationsManager retrieveDataFromNetworkWithOperation: [apiOperationsManager retrieveCategories] success:^(BOOL result)
         {
             NSLog(@"Success!");
             self.categoriesArray = [DatabaseManager retrieveListingCategories];
             [self.tableView reloadData];
             [self retrieveListings];
         } failure:^(NSError *error) {
             NSLog(@"Error: %@", error);
     }];
    }
    
    else
    {
        [self retrieveListings];
    }
}

//Pull refresh event. Time limit: 5 min
-(void) refreshAll
{
    APIOperationsManager *apiOperationsManager = [APIOperationsManager getSharedInstance];
    
    NSInteger refreshTimeInterval = 0;
    if(apiOperationsManager.lastRefresh)
    {
        NSTimeInterval secondsNow = [[NSDate date] timeIntervalSinceReferenceDate];
        NSInteger timeStamp = [apiOperationsManager.lastRefresh timeIntervalSinceReferenceDate];
        refreshTimeInterval = secondsNow - timeStamp;
    }
    
    else
    {
        apiOperationsManager.lastRefresh = [NSDate date];
    }
    
    if(refreshTimeInterval > 300)
    {
        [DatabaseManager deleteAllData];
        apiOperationsManager.lastRefresh = [NSDate date];
        [apiOperationsManager retrieveDataFromNetworkWithOperation: [apiOperationsManager retrieveCategories] success:^(BOOL result)
         {
             NSLog(@"Success!");
             self.categoriesArray = [DatabaseManager retrieveListingCategories];
             [self.tableView reloadData];
             self.tableView.backgroundView = nil;
             [self retrieveListings];
             
         } failure:^(NSError *error) {
             NSLog(@"Error: %@", error);
         }];
    }
    
    //I know this is terrible! There are situations in which data may not have been loaded.
    else
    {
        [self retrieveCategories];
    }
    
    [self.refreshControl endRefreshing];
}

-(void) retrieveListings
{
    if([self.categoriesArray count]>0)
    {
         APIOperationsManager *apiOperationsManager = [APIOperationsManager getSharedInstance];
        [apiOperationsManager retrieveDataFromNetworkWithOperations: [apiOperationsManager retrieveCategoriesListings:self.categoriesArray] success:^(BOOL result)
         {
             NSLog(@"Success!");
             
         } failure:^(NSError *error) {
             NSLog(@"Error: %@", error);
             
         }];
    }
}
@end
