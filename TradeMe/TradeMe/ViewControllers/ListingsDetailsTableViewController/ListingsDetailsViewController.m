//
//  ListingsDetailsViewController.m
//  TradeMe
//
//  Created by Max Ueda on 8/29/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "ListingsDetailsViewController.h"
#import "Listing.h"
#import "SelectedListingSharedInstance.h"
#import "Utilities.h"
#import "APIOperationsManager.h"
#import "APIOperations.h"
#import "DatabaseManager.h"

@implementation ListingsDetailsViewController

-(void) viewDidLoad
{
    [self loadData];
}

- (IBAction)unwindToListings:(id)sender {
    [self performSegueWithIdentifier:@"UnwindToListingsSegue" sender:self];
}


-(void) loadData
{
    SelectedListingSharedInstance *selectedListingSharedInstance = [SelectedListingSharedInstance getSharedInstance];
    
    
    ListingDetails *listingDetails = [DatabaseManager retrieveListingsDetailsWithID:selectedListingSharedInstance.selectedListing.ID];
    if(!listingDetails)
    {
        [self startSpinning];
        APIOperationsManager *apiOperationsManager  = [APIOperationsManager getSharedInstance];
        [apiOperationsManager retrieveDataFromNetworkWithOperation: [apiOperationsManager retrieveListingDetailsWithListingID: selectedListingSharedInstance.selectedListing.ID] success:^(BOOL result)
        {
            ListingDetails *listingDetails =  [DatabaseManager retrieveListingsDetailsWithID:selectedListingSharedInstance.selectedListing.ID];
            [self loadSelectedListingData: listingDetails];

            
        } failure:^(NSError *error) {
            [self stopSpinning];
            
            
        }];

    }
    
    else
    {
        [self loadSelectedListingData: listingDetails];
    }
    
}

#pragma mark - CategorySelectionDelegate
-(void)loadSelectedListingData:(ListingDetails *)listingDetails
{
    if(listingDetails)
    {
        [self.navigationItem setTitle:listingDetails.title];
        [self.lblID setText: listingDetails.ID];
        [self.txtVwDetails setText: listingDetails.detail];
        
        //Try to load image
        SelectedListingSharedInstance *selectedListingSharedInstance = [SelectedListingSharedInstance getSharedInstance];
        if(selectedListingSharedInstance.selectedListing.imageFileName){
            [self loadImage: selectedListingSharedInstance.selectedListing.imageFileName];}
    }
    
    else
    {
        [self.navigationItem setTitle:@"N/A"];
        [self.lblID setText: @"N/A"];
        [self.txtVwDetails setText: @"N/A"];
        [self stopSpinning];
    }
    
}

#pragma mark - Try to load the image
//Some listings don't have thumbnails. There is no problem if networking operations fail.
-(void) loadImage: (NSString*) imageID
{
    if(![imageID isEqualToString:@""])
    {
        __block NSData *imageData = [DatabaseManager retrieveImageDataWithID:imageID];
        if(!imageData)
        {
            APIOperationsManager *apiOperationsManager  = [APIOperationsManager getSharedInstance];
            [apiOperationsManager retrieveDataFromNetworkWithOperation: [apiOperationsManager retrieveImageWithImageID:imageID] success:^(BOOL result)
             {
                 imageData = [DatabaseManager retrieveImageDataWithID:imageID];
                 if(imageData)
                 {
                     [self.imgThumbnail setImage: [UIImage imageWithData: imageData]];
                 }
                 [self stopSpinning];
                 
             } failure:^(NSError *error) {
                 NSLog(@"Error: %@", error);
                 
                 [self stopSpinning];
             }];
        }
        
        else
        {
            [self.imgThumbnail setImage: [UIImage imageWithData: imageData]];
            [self stopSpinning];
        }
    }
    else
    {
        [self stopSpinning];
    }
}
#pragma mark - Loading...
- (void)startSpinning
{
    [self.view bringSubviewToFront:self.vwLoadingView];
    [self.view bringSubviewToFront:self.aivLoading];
    [self.aivLoading startAnimating];
}

- (void)stopSpinning
{
    [self.view sendSubviewToBack:self.vwLoadingView];
    [self.view sendSubviewToBack:self.aivLoading];
    [self.aivLoading stopAnimating];
}


@end
