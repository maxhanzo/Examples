//
//  PrefectureDetailsViewController.m
//  Sokuseki
//
//  Created by Ticket Services on 27/12/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "PrefectureDetailsViewController.h"

//TODO
//http://www.shawngrimes.me/2011/04/adding-polygon-map-overlays/

@interface PrefectureDetailsViewController ()

@end

@implementation PrefectureDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.prefectureMap.delegate = self;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    
    self.prefectureMap.showsUserLocation = NO;
    [self.prefectureMap setMapType:MKMapTypeStandard];
    [self.prefectureMap setZoomEnabled:YES];
    [self.prefectureMap setScrollEnabled:YES];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction) returnToPrefectureList: (id) sender
{
    [self performSegueWithIdentifier:@"UnwindToPrefectureListSegue" sender:nil];
}






@end
