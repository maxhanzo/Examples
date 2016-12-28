//
//  PrefectureDetailsViewController.h
//  Sokuseki
//
//  Created by Ticket Services on 27/12/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "PrefectureInfo.h"
@interface PrefectureDetailsViewController : UIViewController<MKMapViewDelegate,  CLLocationManagerDelegate>

@property(nonatomic, strong) PrefectureInfo* prefectureInfo;
@property(nonatomic, weak) IBOutlet MKMapView *prefectureMap;
@property(nonatomic, strong) CLLocationManager *locationManager;

@end
