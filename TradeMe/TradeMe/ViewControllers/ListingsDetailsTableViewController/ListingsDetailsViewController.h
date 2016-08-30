//
//  ListingsDetailsViewController.h
//  TradeMe
//
//  Created by Max Ueda on 8/29/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ListingsDetailsViewController : UIViewController
//Title goes on navigation bar
//@property(nonatomic, weak) IBOutlet UILabel *lblTitle;
@property(nonatomic, weak) IBOutlet UILabel *lblID;
@property(nonatomic, weak) IBOutlet UITextView *txtVwDetails;
@property(nonatomic, weak) IBOutlet UIImageView *imgThumbnail;
@property(nonatomic, weak) IBOutlet UIView *vwLoadingView;
@property(nonatomic, weak) IBOutlet UIActivityIndicatorView *aivLoading;

@end
